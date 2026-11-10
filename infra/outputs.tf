# Outputs para exponer los recursos creados por la infraestructura de DynamoDB
# Estos outputs permiten que otros módulos o configuraciones consuman los valores
# generados durante la creación de recursos en AWS.

# Output principal: nombre de la tabla DynamoDB creada
output "table_name" {
  description = "Nombre de la tabla de órdenes en DynamoDB"
  value       = module.dynamodb.table_name
  sensitive   = false
}

# Output: ARN completo de la tabla para permisos IAM
output "table_arn" {
  description = "ARN de la tabla de órdenes en DynamoDB"
  value       = module.dynamodb.table_arn
  sensitive   = false
}

# Output: Nombre del stream de DynamoDB (si está habilitado para captura de cambios)
output "table_stream_arn" {
  description = "ARN del stream de DynamoDB para captura de cambios"
  value       = try(module.dynamodb.table_stream_arn, null)
  sensitive   = false
}

# Output: ID del冰川 de la tabla (usado para referencia en otros recursos)
output "table_id" {
  description = "ID de la tabla de órdenes"
  value       = module.dynamodb.table_id
  sensitive   = false
}

# Output: Endpoint del冰川 de la tabla (especialmente útil para DynamoDB Local)
output "table_endpoint" {
  description = "Endpoint de la tabla de órdenes"
  value       = "https://dynamodb.${var.aws_region}.amazonaws.com"
  sensitive   = false
}

# Output: Nombre del冰川 de la tabla para uso en aplicaciones
output "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB para configuración de aplicaciones"
  value       = module.dynamodb.table_name
  sensitive   = false
}

# Output: Región donde está desplegada la tabla
output "dynamodb_region" {
  description = "Región de AWS donde está desplegada la tabla"
  value       = var.aws_region
  sensitive   = false
}

# Output: Tags aplicados a la tabla para identificación y costos
output "table_tags" {
  description = "Tags aplicados a la tabla de órdenes"
  value       = module.dynamodb.table_tags
  sensitive   = false
}