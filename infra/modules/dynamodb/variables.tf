# Variables del módulo DynamoDB
# Estas variables permiten configurar los atributos y capacidades de la tabla DynamoDB
# de órdenes, así como las políticas IAM asociadas.

# Variable para el nombre de la tabla DynamoDB
variable "table_name" {
  description = "Nombre de la tabla DynamoDB"
  type        = string
}

# Variable para el read capacity de la tabla DynamoDB
variable "read_capacity" {
  description = "Capacidad de lectura provisionada para la tabla DynamoDB"
  type        = number
}

# Variable para el write capacity de la tabla DynamoDB
variable "write_capacity" {
  description = "Capacidad de escritura provisionada para la tabla DynamoDB"
  type        = number
}

# Variable para el atributo hash key de la tabla DynamoDB
variable "hash_key" {
  description = "Nombre del atributo utilizado como hash key en la tabla DynamoDB"
  type        = string
  default     = "order_id"
}

# Variable para el tipo de dato del hash key
variable "hash_key_type" {
  description = "Tipo de dato del hash key (S para string, N para number, B para binary)"
  type        = string
  default     = "S"
}

# Variable para habilitar el TTL en DynamoDB
variable "enable_ttl" {
  description = "Indica si se habilita el Time To Live (TTL) en la tabla DynamoDB"
  type        = bool
  default     = false
}

# Variable para el atributo TTL en DynamoDB
variable "ttl_attribute" {
  description = "Nombre del atributo utilizado para el Time To Live (TTL) en DynamoDB"
  type        = string
  default     = "expiration_time"
}

# Variable para los atributos adicionales de la tabla DynamoDB
variable "attributes" {
  description = "Lista de atributos adicionales para la tabla DynamoDB"
  type = list(object({
    name = string
    type = string
  }))
  default = [
    {
      name = "state"
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
}

# Variable para los estados válidos de una orden
variable "valid_states" {
  description = "Estados válidos para una orden"
  type        = list(string)
  default     = ["PENDING", "PROCESSING", "COMPLETED", "CANCELLED"]
}

# Variable para habilitar el stream en DynamoDB
variable "enable_stream" {
  description = "Indica si se habilita el stream en la tabla DynamoDB"
  type        = bool
  default     = false
}

# Variable para el tipo de stream en DynamoDB
variable "stream_view_type" {
  description = "Tipo de vista del stream (KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES)"
  type        = string
  default     = "NEW_AND_OLD_IMAGES"
}