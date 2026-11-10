# Definición de variables globales para la configuración de la infraestructura
# Estas variables permiten parametrizar la creación de recursos y facilitar la reutilización
# en diferentes entornos.

# Variable para la región de AWS
variable "aws_region" {
  description = "Región de AWS donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

# Variable para el nombre de la tabla DynamoDB de órdenes
variable "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB para almacenar órdenes"
  type        = string
  default     = "orders-table"
}

# Variable para el read capacity de la tabla DynamoDB
variable "dynamodb_read_capacity" {
  description = "Capacidad de lectura provisionada para la tabla DynamoDB"
  type        = number
  default     = 5
}

# Variable para el write capacity de la tabla DynamoDB
variable "dynamodb_write_capacity" {
  description = "Capacidad de escritura provisionada para la tabla DynamoDB"
  type        = number
  default     = 5
}

# Variable para los estados válidos de una orden
variable "order_valid_states" {
  description = "Estados válidos para una orden"
  type        = list(string)
  default     = ["PENDING", "PROCESSING", "COMPLETED", "CANCELLED"]
}

# Variable para habilitar el TTL en DynamoDB
variable "dynamodb_enable_ttl" {
  description = "Indica si se habilita el Time To Live (TTL) en la tabla DynamoDB"
  type        = bool
  default     = false
}

# Variable para el atributo TTL en DynamoDB
variable "dynamodb_ttl_attribute" {
  description = "Nombre del atributo utilizado para el Time To Live (TTL) en DynamoDB"
  type        = string
  default     = "expiration_time"
}