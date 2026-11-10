resource "aws_dynamodb_table" "orders" {
  name           = var.table_name
  billing_mode   = var.billing_mode
  hash_key       = var.partition_key_name
  range_key      = var.sort_key_name != null ? var.sort_key_name : null
  stream_enabled = var.enable_streams
  stream_view_type = var.enable_streams ? var.stream_view_type : null

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes
    content {
      name            = global_secondary_index.value.name
      hash_key        = global_secondary_index.value.hash_key
      range_key       = global_secondary_index.value.range_key != null ? global_secondary_index.value.range_key : null
      projection_type = global_secondary_index.value.projection_type
      read_capacity   = var.billing_mode == "PROVISIONED" ? global_secondary_index.value.read_capacity : null
      write_capacity  = var.billing_mode == "PROVISIONED" ? global_secondary_index.value.write_capacity : null
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_indexes
    content {
      name       = local_secondary_index.value.name
      range_key  = local_secondary_index.value.range_key
      projection_type = local_secondary_index.value.projection_type
    }
  }

  server_side_encryption {
    enabled     = var.server_side_encryption
    kms_key_arn = var.kms_key_arn
  }

  point_in_time_recovery {
    enabled = var.enable_point_in_time_recovery
  }

  ttl {
    enabled        = var.ttl_enabled
    attribute_name = var.ttl_attribute_name
  }

  tags = merge(
    var.common_tags,
    {
      "Name"        = var.table_name
      "Environment" = var.environment
      "ManagedBy"   = "Terraform"
      "Project"     = var.project_name
    }
  )

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_iam_policy" "dynamodb_access" {
  name        = "${var.table_name}-access-policy"
  description = "Política IAM para acceso CRUD a la tabla de órdenes de DynamoDB"

  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Sid" = "AllowReadOperations"
        "Effect" = "Allow"
        "Action" = [
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:DescribeTable"
        ]
        "Resource" = [
          aws_dynamodb_table.orders.arn,
          "${aws_dynamodb_table.orders.arn}/index/*"
        ]
      },
      {
        "Sid" = "AllowWriteOperations"
        "Effect" = "Allow"
        "Action" = [
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem"
        ]
        "Resource" = aws_dynamodb_table.orders.arn
      },
      {
        "Sid" = "AllowStreamRead"
        "Effect" = "Allow"
        "Action" = [
          "dynamodb:GetRecords",
          "dynamodb:GetShardIterator",
          "dynamodb:DescribeStream",
          "dynamodb:ListStreams"
        ]
        "Resource" = var.enable_streams ? aws_dynamodb_table.orders.stream_arn : ""
        "Condition" = {
          "Bool" = {
            "dynamodb:IsStream" = "true"
          }
        }
      }
    ]
  })

  tags = merge(
    var.common_tags,
    {
      "Name"        = "${var.table_name}-access-policy"
      "Environment" = var.environment
      "ManagedBy"   = "Terraform"
    }
  )
}

resource "aws_iam_role_policy_attachment" "dynamodb_access_attachment" {
  for_each   = toset(var.allowed_iam_roles)
  role       = each.value
  policy_arn = aws_iam_policy.dynamodb_access.arn
}

resource "aws_dynamodb_table_policy" "deny_unencrypted" {
  count  = var.enforce_ssl ? 1 : 0
  table_name = aws_dynamodb_table.orders.name

  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Sid" = "DenyUnencryptedUploads"
        "Effect" = "Deny"
        "Action" = [
          "dynamodb:PutItem",
          "dynamodb:UpdateItem"
        ]
        "Resource" = aws_dynamodb_table.orders.arn
        "Condition" = {
          "Bool" = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}

resource "aws_cloudwatch_log_group" "dynamodb_metrics" {
  count              = var.enable_metrics ? 1 : 0
  name               = "/aws/dynamodb/${var.table_name}"
  retention_in_days = var.log_retention_days
  kms_key_id         = var.logs_kms_key_arn

  tags = merge(
    var.common_tags,
    {
      "Name"        = "/aws/dynamodb/${var.table_name}"
      "Environment" = var.environment
    }
  )
}

resource "aws_sns_topic" "order_events" {
  count             = var.enable_event_notification ? 1 : 0
  name              = "${var.table_name}-events"
  display_name      = "Notificaciones de eventos de órdenes"
  kms_master_key_id = var.sns_kms_key_arn

  tags = merge(
    var.common_tags,
    {
      "Name"        = "${var.table_name}-events"
      "Environment" = var.environment
    }
  )
}

resource "aws_dynamodb_table" "order_events_subscription" {
  count = var.enable_event_notification ? 1 : 0
  name  = "${var.table_name}-events-dlq"

  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "MessageId"

  attribute {
    name = "MessageId"
    type = "S"
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = var.kms_key_arn
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_lambda_event_source_mapping" "dynamodb_to_sns" {
  count              = var.enable_event_notification ? 1 : 0
  event_source_arn   = aws_dynamodb_table.orders.stream_arn
  function_name      = var.event_processor_function_name
  starting_position  = "LATEST"
  batch_size         = var.event_batch_size
  maximum_record_age_in_seconds = var.event_max_record_age
  destination_config {
    on_failure {
      destination_arn = aws_dynamodb_table.order_events_subscription[0].arn
    }
  }
  depends_on = [aws_dynamodb_table.orders]
}

resource "aws_dynamodb_tag" "table_tags" {
  for_each = var.extra_tags
  key      = each.key
  value    = each.value
  resource_arn = aws_dynamodb_table.orders.arn
}