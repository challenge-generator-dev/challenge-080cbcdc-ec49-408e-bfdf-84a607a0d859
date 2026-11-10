locals {
  common_tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
    Project     = "crud-orders-dynamodb"
    Terraform   = "true"
  }

  table_name = var.table_name != "" ? var.table_name : "orders"

  dynamodb_attributes = [
    {
      name = "order_id"
      type = "S"
    },
    {
      name = "status"
      type = "S"
    },
    {
      name = "customer_id"
      type = "S"
    },
    {
      name = "created_at"
      type = "S"
    },
    {
      name = "updated_at"
      type = "S"
    }
  ]

  gsi_config = [
    {
      name            = "status_index"
      hash_key        = "status"
      range_key       = "created_at"
      projection_type = "ALL"
      read_capacity   = 5
      write_capacity  = 5
    },
    {
      name            = "customer_index"
      hash_key        = "customer_id"
      range_key       = "created_at"
      projection_type = "ALL"
      read_capacity   = 5
      write_capacity  = 5
    }
  ]
}

module "dynamodb_table" {
  source = "./modules/dynamodb"

  environment     = var.environment
  table_name      = local.table_name
  attributes      = local.dynamodb_attributes
  billing_mode    = var.billing_mode
  read_capacity   = var.read_capacity
  write_capacity  = var.write_capacity
  gsi_config      = local.gsi_config
  enable_ttl      = var.enable_ttl
  ttl_attribute   = "expires_at"
  stream_enabled  = var.stream_enabled
  stream_view_type = var.stream_view_type

  tags = local.common_tags
}

resource "aws_sns_topic" "order_events" {
  name            = "${local.table_name}-events"
  display_name    = "Órdenes - Eventos de tabla"
  fifo_topic      = false
  delivery_policy = jsonencode({
    http = {
      defaultHealthyRetryPolicy = {
        minimumDelayTarget     = 20
        maximumDelayTarget     = 20
        numRetries             = 3
        numMaxDelayRetries     = 3
        numMinDelayRetries     = 3
        backoffFunction        = "linear"
      }
      defaultThrottlePolicy = {
        maximumReceiveRate = 10
      }
    }
  })

  tags = merge(local.common_tags, {
    Description = "Tópico SNS para eventos de cambios en órdenes"
  })
}

resource "aws_sns_topic_policy" "order_events_policy" {
  arn = aws_sns_topic.order_events.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowDynamoDBToPublish"
        Effect = "Allow"
        Principal = {
          Service = "dynamodb.amazonaws.com"
        }
        Action   = "sns:Publish"
        Resource = aws_sns_topic.order_events.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = module.dynamodb_table.table_arn
          }
        }
      }
    ]
  })
}

resource "aws_kms_key" "orders_key" {
  description             = "Clave KMS para cifrado de datos de órdenes"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-policy"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow DynamoDB to use the key"
        Effect = "Allow"
        Principal = {
          Service = "dynamodb.amazonaws.com"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey",
          "kms:CreateGrant"
        ]
        Resource = "*"
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = module.dynamodb_table.table_arn
          }
        }
      }
    ]
  })

  tags = merge(local.common_tags, {
    Purpose = "Cifrado de datos sensibles de órdenes"
  })
}

resource "aws_kms_alias" "orders_key_alias" {
  name          = "alias/orders-cmk"
  target_key_id = aws_kms_key.orders_key.key_id
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

output "table_name" {
  description = "Nombre de la tabla DynamoDB"
  value       = module.dynamodb_table.table_name
}

output "table_arn" {
  description = "ARN de la tabla DynamoDB"
  value       = module.dynamodb_table.table_arn
}

output "topic_arn" {
  description = "ARN del tópico SNS para eventos"
  value       = aws_sns_topic.order_events.arn
}

output "kms_key_arn" {
  description = "ARN de la clave KMS"
  value       = aws_kms_key.orders_key.arn
}

output "account_id" {
  description = "ID de la cuenta de AWS"
  value       = data.aws_caller_identity.current.account_id
}

output "region" {
  description = "Región de AWS actual"
  value       = data.aws_region.current.name
}

variable "table_name" {
  description = "Nombre de la tabla DynamoDB para órdenes"
  type        = string
  default     = "orders"
}

variable "billing_mode" {
  description = "Modo de facturación de DynamoDB (PAY_PER_REQUEST o PROVISIONED)"
  type        = string
  default     = "PAY_PER_REQUEST"
  validation {
    condition     = contains(["PAY_PER_REQUEST", "PROVISIONED"], var.billing_mode)
    error_message = "El modo de facturación debe ser PAY_PER_REQUEST o PROVISIONED"
  }
}

variable "read_capacity" {
  description = "Capacidad de lectura para modo PROVISIONED"
  type        = number
  default     = 5
  validation {
    condition     = var.read_capacity >= 1 && var.read_capacity <= 40000
    error_message = "La capacidad de lectura debe estar entre 1 y 40000"
  }
}

variable "write_capacity" {
  description = "Capacidad de escritura para modo PROVISIONED"
  type        = number
  default     = 5
  validation {
    condition     = var.write_capacity >= 1 && var.write_capacity <= 40000
    error_message = "La capacidad de escritura debe estar entre 1 y 40000"
  }
}

variable "enable_ttl" {
  description = "Habilitar Time-To-Live para eliminación automática"
  type        = bool
  default     = true
}

variable "stream_enabled" {
  description = "Habilitar DynamoDB Streams para capturar cambios"
  type        = bool
  default     = true
}

variable "stream_view_type" {
  description = "Tipo de vista de stream (KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES)"
  type        = string
  default     = "NEW_AND_OLD_IMAGES"
  validation {
    condition     = contains(["KEYS_ONLY", "NEW_IMAGE", "OLD_IMAGE", "NEW_AND_OLD_IMAGES"], var.stream_view_type)
    error_message = "El tipo de vista debe ser uno de: KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES"
  }
}