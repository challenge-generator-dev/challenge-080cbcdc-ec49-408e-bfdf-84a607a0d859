output "table_name" {
  description = "Nombre de la tabla DynamoDB de órdenes"
  value       = aws_dynamodb_table.orders.name
}

output "table_arn" {
  description = "ARN completo de la tabla DynamoDB"
  value       = aws_dynamodb_table.orders.arn
}

output "table_id" {
  description = "Identificador único de la tabla"
  value       = aws_dynamodb_table.orders.id
}

output "table_stream_arn" {
  description = "ARN del stream de DynamoDB si está habilitado"
  value       = var.enable_streams ? aws_dynamodb_table.orders.stream_arn : null
}

output "table_stream_label" {
  description = "Etiqueta del stream de DynamoDB"
  value       = var.enable_streams ? aws_dynamodb_table.orders.stream_label : null
}

output "table_size_bytes" {
  description = "Tamaño actual de la tabla en bytes"
  value       = aws_dynamodb_table.orders.size_bytes
}

output "table_item_count" {
  description = "Cantidad de elementos en la tabla"
  value       = aws_dynamodb_table.orders.item_count
}

output "table_status" {
  description = "Estado actual de la tabla (ACTIVE, CREATING, DELETING, UPDATING)"
  value       = aws_dynamodb_table.orders.status
}

output "partition_key_name" {
  description = "Nombre de la clave de partición"
  value       = var.partition_key_name
}

output "sort_key_name" {
  description = "Nombre de la clave de ordenamiento"
  value       = var.sort_key_name
}

output "global_secondary_indexes" {
  description = "Lista de índices secundarios globales configurados"
  value       = [for idx in aws_dynamodb_table.orders.global_secondary_index : idx.name]
}

output "local_secondary_indexes" {
  description = "Lista de índices secundarios locales configurados"
  value       = [for idx in aws_dynamodb_table.orders.local_secondary_index : idx.name]
}

output "iam_policy_arn" {
  description = "ARN de la política IAM de acceso a la tabla"
  value       = aws_iam_policy.dynamodb_access.arn
}

output "iam_policy_name" {
  description = "Nombre de la política IAM de acceso"
  value       = aws_iam_policy.dynamodb_access.name
}

output "iam_policy_id" {
  description = "Identificador de la política IAM"
  value       = aws_iam_policy.dynamodb_access.id
}

output "dynamodb_to_sns_mapping_arn" {
  description = "ARN del event source mapping para integración con SNS"
  value       = var.enable_event_notification ? aws_lambda_event_source_mapping.dynamodb_to_sns[0].function_arn : null
}

output "event_topic_arn" {
  description = "ARN del topic SNS para eventos de órdenes"
  value       = var.enable_event_notification ? aws_sns_topic.order_events[0].arn : null
}

output "event_dlq_name" {
  description = "Nombre de la cola de mensajes fallidos para procesamiento de eventos"
  value       = var.enable_event_notification ? aws_dynamodb_table.order_events_subscription[0].name : null
}

output "event_dlq_arn" {
  description = "ARN de la cola de mensajes fallidos"
  value       = var.enable_event_notification ? aws_dynamodb_table.order_events_subscription[0].arn : null
}

output "billing_mode" {
  description = "Modo de facturación de la tabla"
  value       = aws_dynamodb_table.orders.billing_mode
}

output "server_side_encryption_enabled" {
  description = "Indica si el cifrado del lado del servidor está habilitado"
  value       = aws_dynamodb_table.orders.server_side_encryption[0].enabled
}

output "point_in_time_recovery_enabled" {
  description = "Indica si la recuperación a un punto en el tiempo está habilitado"
  value       = aws_dynamodb_table.orders.point_in_time_recovery[0].enabled
}

output "ttl_enabled" {
  description = "Indica si el TTL está habilitado"
  value       = aws_dynamodb_table.orders.ttl[0].enabled
}

output "ttl_attribute_name" {
  description = "Nombre del atributo de TTL"
  value       = aws_dynamodb_table.orders.ttl[0].attribute_name
}

output "kms_key_arn" {
  description = "ARN de la clave KMS utilizada para cifrado"
  value       = var.kms_key_arn
}

output "log_group_name" {
  description = "Nombre del grupo de logs de CloudWatch"
  value       = var.enable_metrics ? aws_cloudwatch_log_group.dynamodb_metrics[0].name : null
}

output "attributes" {
  description = "Lista de atributos definidos en la tabla"
  value       = [for attr in aws_dynamodb_table.orders.attribute : {
    name = attr.name
    type = attr.type
  }]
}