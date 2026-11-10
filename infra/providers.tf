# Configuración de los providers necesarios para la infraestructura
# Se utiliza el provider de AWS con la versión especificada para asegurar compatibilidad
# y estabilidad en la creación de recursos.

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.70.0"
    }
  }
}

# Configuración del provider de AWS
# Las credenciales se obtienen desde las variables de entorno o el perfil de AWS configurado.
provider "aws" {
  region = var.aws_region
  # Opcional: especificar un perfil si se usa uno diferente al default
  # profile = var.aws_profile
}

# Variables globales utilizadas en la configuración del provider
variable "aws_region" {
  description = "Región de AWS donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Perfil de AWS a utilizar para la autenticación"
  type        = string
  default     = "default"
}