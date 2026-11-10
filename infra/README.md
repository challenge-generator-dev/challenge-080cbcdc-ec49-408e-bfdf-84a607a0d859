# Infraestructura CRUD de Órdenes en DynamoDB

Este módulo de Terraform define la infraestructura necesaria para el sistema de gestión de órdenes sobre DynamoDB.

## Recursos Definidos

### Tabla DynamoDB
- **Nombre**: `orders` (configurable via variable)
- **Partición clave**: `order_id` (String)
- **Atributos**: 
  - `status` - Estado de la orden
  - `created_at` - Fecha de creación
  - `updated_at` - Fecha de modificación
  - `customer_id` - Identificador del cliente
  - `total_amount` - Monto total de la orden

### Índice Global Secundario (GSI)
- **GSI por status**: Permite consultas por estado de orden
- **GSI por customer_id**: Permite consultas por cliente

### Políticas IAM
- Política de lectura/escritura con mínimos privilegios
- Rol de ejecución para Lambda (preparado para futura integración)

## Uso del Módulo

```hcl
module "orders_infra" {
  source = "./modules/dynamodb"

  environment = "dev"
  table_name  = "orders"
}
```

## Validación Local

### Prerrequisitos
- Terraform >= 1.9.0
- AWS CLI configurado con credenciales
- Provider AWS 5.70.0

### Comandos de Validación

1. **Inicializar Terraform**:
```bash
terraform init
```

2. **Validar sintaxis**:
```bash
terraform validate
```

3. **Planificar cambios**:
```bash
terraform plan -var-file=environments/dev/terraform.tfvars
```

4. **Aplicar infraestructura**:
```bash
terraform apply -var-file=environments/dev/terraform.tfvars
```

5. **Destruir recursos** (limpieza):
```bash
terraform destroy -var-file=environments/dev/terraform.tfvars
```

## Variables Requeridas

| Variable | Tipo | Descripción |
|----------|------|-------------|
| `environment` | string | Entorno de despliegue |
| `table_name` | string | Nombre de la tabla DynamoDB |

## Outputs

| Output | Descripción |
|--------|-------------|
| `table_name` | Nombre de la tabla creada |
| `table_arn` | ARN de la tabla DynamoDB |
| `table_id` | ID único de la tabla |

## Consideraciones de Seguridad

- La tabla usa encryption por defecto con AWS owned keys
- El punto de acceso está deshabilitado para entorno dev
- Las políticas IAM siguen el principio de mínimo privilegio
- Los timestamps usan formato ISO 8601 para consistencia