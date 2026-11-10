# Variables específicas para el ambiente de desarrollo
# Estas variables sobrescriben los valores por defecto definidos en variables.tf
# y configuran el entorno de desarrollo para el sistema de gestión de órdenes.

# Configuración general del proyecto
environment              = "dev"
project_name             = "orders-crud"
aws_region               = "us-east-1"

# Habilitar características de desarrollo
enable_dynamodb_streams  = true
enable_point_in_time_recovery = false

# Configuración de la tabla DynamoDB
dynamodb_table_name      = "orders-dev"
dynamodbbilling_mode     = "PAY_PER_REQUEST"

# Configuración de capacidad (solo aplica si billing_mode es PROVISIONED)
read_capacity  = 5
write_capacity = 5

# Configuración de claves y atributos
hash_key_name  = "order_id"
hash_key_type  = "S"  # S = String, N = Number, B = Binary

# Habilitar TTL para auto-limpieza de registros antiguos
enable_ttl     = true
ttl_attribute  = "expires_at"

# Tags para identificación en AWS
tags = {
  Environment = "development"
  Project     = "orders-crud"
  ManagedBy   = "terraform"
  Team        = "operations"
  CostCenter  = "engineering"
}

# Configuración de redundancia para desarrollo (menor costo)
replica_regions = []

# Configuración de servidor local de DynamoDB (opcional para desarrollo)
# Descomenta si usas DynamoDB Local en lugar de AWS real
# use_dynamodb_local = true
# dynamodb_local_port = 8000