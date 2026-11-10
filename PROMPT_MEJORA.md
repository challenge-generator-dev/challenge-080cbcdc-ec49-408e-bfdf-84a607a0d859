# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `app` | `app/` | practice, chapter | server | Node | Express, DynamoDB |
| `infra` | `infra/` | support | infra | Terraform (AWS) | Terraform |
| `infra-local` | (raiz) | support | infra | Compose local | DynamoDB |

## Orden de arranque

1. `docker compose up -d` (en la raiz) — levanta la infraestructura local.
2. `cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate` — componente `infra` (support).
3. `cd app && npm install && npm run build` — componente `app` (practice, chapter).

### Contratos entre componentes

- `app` expone http (api: http://localhost:3000):
  - `POST /orders`
  - `GET /orders/:id`
  - `PUT /orders/:id`
  - `DELETE /orders/:id`

## Herramientas

- **Terraform**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Boilerplate del stack que falta

Sin esto no compila ni arranca. Es andamiaje, no toca nada de lo pedagogico:

- **app/src/app.module.ts** — Sin el modulo raiz, Nest no tiene arbol de dependencias que resolver y el bootstrap falla.

## Como saber que terminaste

```bash
(cd app && npm install && npm run build) && (cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && docker compose config -q
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Backend, Especialidad Desarrollador, Tecnología Node, Advanced L2

### Brecha de conocimiento
CRUD de ordenes en DynamoDB expuesto por una API REST (corrida e2e 20261109193147506), Implementa operaciones CRUD de ordenes sobre una tabla DynamoDB expuestas por una API REST

### Misión / candidato
Persistir y consultar ordenes

### Reto
- Tema: CRUD de ordenes sobre DynamoDB
- Seniority: advanced-l2
- Tipo: practical
- Título: Implementación de CRUD de órdenes en DynamoDB
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Creación de la tabla DynamoDB y operaciones básicas — objetivo: Implementar las operaciones básicas de CRUD para órdenes en DynamoDB. — entregable (NO resolver): Tabla DynamoDB con esquema definido y operaciones CRUD implementadas.
- Fase 2: Exposición de las operaciones CRUD a través de una API REST — objetivo: Exponer las operaciones CRUD de órdenes a través de una API REST. — entregable (NO resolver): API REST documentada que expone las operaciones CRUD de órdenes.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: app/src/main.ts ===
import { createApp } from './app';
import { startServer } from './server';
import dotenv from 'dotenv';

dotenv.config();

const app = createApp();
startServer(app);

console.log('Application started successfully');

// === ARCHIVO: app/src/app.ts ===
import express, { Express, Request, Response, NextFunction } from 'express';
import 'express-async-errors';
import { validate } from 'class-validator';
import { plainToInstance, ClassConstructor } from 'class-transformer';
import swaggerUi from 'swagger-ui-express';
import fs from 'fs';
import path from 'path';
import { OrderCreateDTO, OrderUpdateDTO } from './types/orderTypes';

export const createApp = (): Express => {
    const app: Express = express();

    app.use(express.json());
    app.use(express.urlencoded({ extended: true }));

    app.use((req: Request, res: Response, next: NextFunction) => {
        res.header('Access-Control-Allow-Origin', '*');
        res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
        res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
        if (req.method === 'OPTIONS') {
            return res.sendStatus(200);
        }
        next();
    });

    app.get('/health', (req: Request, res: Response) => {
        res.status(200).json({ status: 'OK', timestamp: new Date().toISOString() });
    });

    try {
        const swaggerDocument = JSON.parse(fs.readFileSync(path.join(__dirname, '../../swagger.json'), 'utf8'));
        app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));
    } catch (error) {
        console.warn('Swagger documentation not found or invalid');
    }

    const orderCreateDtoClass = OrderCreateDTO as unknown as ClassConstructor<OrderCreateDTO>;
    const orderUpdateDtoClass = OrderUpdateDTO as unknown as ClassConstructor<OrderUpdateDTO>;

    app.post('/orders', async (req: Request, res: Response) => {
        const orderData = plainToInstance(orderCreateDtoClass, req.body);
        const errors = await validate(orderData);

        if (errors.length > 0) {
            const errorMessages = errors.map(error => Object.values(error.constraints || {})).flat();
            return res.status(400).json({ errors: errorMessages });
        }

        return res.status(501).json({ message: 'Endpoint not implemented yet' });
    });

    app.get('/orders/:id', async (req: Request, res: Response) => {
        const { id } = req.params;

        return res.status(501).json({ message: 'Endpoint not implemented yet' });
    });

    app.put('/orders/:id', async (req: Request, res: Response) => {
        const { id } = req.params;
        const orderData = plainToInstance(orderUpdateDtoClass, req.body);
        const errors = await validate(orderData);

        if (errors.length > 0) {
            const errorMessages = errors.map(error => Object.values(error.constraints || {})).flat();
            return res.status(400).json({ errors: errorMessages });
        }

        return res.status(501).json({ message: 'Endpoint not implemented yet' });
    });

    app.delete('/orders/:id', async (req: Request, res: Response) => {
        const { id } = req.params;

        return res.status(501).json({ message: 'Endpoint not implemented yet' });
    });

    app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
        console.error('Error no manejado:', err.message);
        console.error(err.stack);
        
        if (err.name === 'ValidationError') {
            return res.status(400).json({ error: 'Validation failed', details: err.message });
        }
        if (err.name === 'UnauthorizedError') {
            return res.status(401).json({ error: 'Unauthorized' });
        }
        
        res.status(500).json({ error: 'Internal server error', message: process.env.NODE_ENV === 'development' ? err.message : undefined });
    });

    app.use((req: Request, res: Response) => {
        res.status(404).json({ error: 'Not found', path: req.path });
    });

    return app;
};

// === ARCHIVO: app/src/server.ts ===
import { Express } from 'express';
import dotenv from 'dotenv';

dotenv.config();

const PORT = process.env.PORT || 3000;

export const startServer = (app: Express): void => {
    app.listen(PORT, () => {
        console.log(`Server running on port ${PORT}`);
        console.log(`API docs available at http://localhost:${PORT}/api-docs`);
    }).on('error', (err: Error) => {
        console.error('Server failed to start:', err.message);
        process.exit(1);
    });
};

// === ARCHIVO: app/src/domain/models/Order.ts ===
export enum OrderStatus {
  PENDING = 'PENDING',
  PROCESSING = 'PROCESSING',
  CONFIRMED = 'CONFIRMED',
  SHIPPED = 'SHIPPED',
  DELIVERED = 'DELIVERED',
  COMPLETED = 'COMPLETED',
  CANCELLED = 'CANCELLED'
}

export class Order {
  id: string;
  customerId: string;
  status: OrderStatus;
  createdAt: Date;
  updatedAt: Date;
  items: string[];

  constructor(
    id: string,
    customerId: string,
    status: OrderStatus,
    createdAt: Date,
    updatedAt: Date,
    items: string[]
  ) {
    this.id = id;
    this.customerId = customerId;
    this.status = status;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.items = items;
  }

  updateStatus(newStatus: OrderStatus): void {
    if (!Object.values(OrderStatus).includes(newStatus)) {
      throw new Error('Invalid order status');
    }
    this.status = newStatus;
    this.updatedAt = new Date();
  }

  updateItems(newItems: string[]): void {
    if (!newItems || newItems.length === 0) {
      throw new Error('Items cannot be empty');
    }
    this.items = newItems;
    this.updatedAt = new Date();
  }

  static createNewOrder(customerId: string, items: string[]): Order {
    const now = new Date();
    return new Order(
      crypto.randomUUID(),
      customerId,
      OrderStatus.PENDING,
      now,
      now,
      items
    );
  }
}

// === ARCHIVO: app/src/domain/repositories/OrderRepository.ts ===
import { Order } from '../models/Order';

export interface OrderRepository {
  create(order: Order): Promise<Order>;
  findById(id: string): Promise<Order | null>;
  update(order: Order): Promise<Order>;
  delete(id: string): Promise<void>;
}

// === ARCHIVO: app/src/infrastructure/repositories/DynamoOrderRepository.ts ===
import { DynamoDB } from 'aws-sdk';
import { Order, OrderStatus } from '../../domain/models/Order';
import { OrderRepository } from '../../domain/repositories/OrderRepository';

export class DynamoOrderRepository implements OrderRepository {
  private readonly tableName: string;
  private readonly dynamoDB: DynamoDB.DocumentClient;

  constructor(tableName: string, dynamoDB?: DynamoDB.DocumentClient) {
    this.tableName = tableName;
    this.dynamoDB = dynamoDB || new DynamoDB.DocumentClient();
  }

  async create(order: Order): Promise<Order> {
    const params = {
      TableName: this.tableName,
      Item: {
        id: order.id,
        customerId: order.customerId,
        status: order.status,
        createdAt: order.createdAt.toISOString(),
        updatedAt: order.updatedAt.toISOString(),
        items: order.items
      },
      ConditionExpression: 'attribute_not_exists(id)'
    };

    try {
      await this.dynamoDB.put(params).promise();
      return order;
    } catch (error) {
      const err = error as { code?: string; message?: string };
      if (err.code === 'ConditionalCheckFailedException') {
        throw new Error('Order with this ID already exists');
      }
      throw error;
    }
  }

  async findById(id: string): Promise<Order | null> {
    const params = {
      TableName: this.tableName,
      Key: { id }
    };

    const result = await this.dynamoDB.get(params).promise();
    if (!result.Item) {
      return null;
    }

    return new Order(
      result.Item.id,
      result.Item.customerId,
      result.Item.status as OrderStatus,
      new Date(result.Item.createdAt),
      new Date(result.Item.updatedAt),
      result.Item.items || []
    );
  }

  async update(order: Order): Promise<Order> {
    const params = {
      TableName: this.tableName,
      Key: { id: order.id },
      UpdateExpression: 'SET customerId = :customerId, status = :status, updatedAt = :updatedAt, items = :items',
      ExpressionAttributeValues: {
        ':customerId': order.customerId,
        ':status': order.status,
        ':updatedAt': order.updatedAt.toISOString(),
        ':items': order.items
      },
      ReturnValues: 'ALL_NEW'
    };

    const result = await this.dynamoDB.update(params).promise();
    if (!result.Attributes) {
      throw new Error('Order update failed');
    }

    return new Order(
      result.Attributes.id,
      result.Attributes.customerId,
      result.Attributes.status as OrderStatus,
      new Date(result.Attributes.createdAt),
      new Date(result.Attributes.updatedAt),
      result.Attributes.items || []
    );
  }

  async delete(id: string): Promise<void> {
    const params = {
      TableName: this.tableName,
      Key: { id }
    };

    await this.dynamoDB.delete(params).promise();
  }
}

// === ARCHIVO: app/package.json ===
{
  "name": "app",
  "version": "1.0.0",
  "description": "CRUD de órdenes sobre DynamoDB",
  "main": "dist/main.js",
  "scripts": {
    "build": "tsc",
    "start": "node dist/main.js",
    "dev": "ts-node src/main.ts",
    "test": "jest",
    "lint": "eslint src/**/*.ts"
  },
  "dependencies": {
    "aws-sdk": "2.1691.0",
    "class-transformer": "^0.5.1",
    "class-validator": "0.14.1",
    "dotenv": "16.4.5",
    "express": "4.21.0",
    "swagger-ui-express": "5.0.1",
    "express-async-errors": "^3.1.1"
  },
  "devDependencies": {
    "@types/express": "4.17.21",
    "@types/jest": "29.5.12",
    "@types/node": "22.7.4",
    "@typescript-eslint/eslint-plugin": "6.21.0",
    "@typescript-eslint/parser": "6.21.0",
    "eslint": "8.57.0",
    "jest": "29.7.0",
    "ts-jest": "29.2.5",
    "ts-node": "10.9.2",
    "typescript": "5.7.2"
  },
  "engines": {
    "node": ">=22.0.0"
  }
}


// === ARCHIVO: app/tsconfig.json ===
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "commonjs",
    "lib": ["ES2022"],
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "moduleResolution": "node",
    "baseUrl": ".",
    "paths": {
      "@domain/*": ["src/domain/*"],
      "@application/*": ["src/application/*"],
      "@infrastructure/*": ["src/infrastructure/*"],
      "@types/*": ["src/types/*"]
    }
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "**/*.spec.ts", "**/*.test.ts"]
}

// === ARCHIVO: app/.env ===
# Configuración del servidor
PORT=3000
NODE_ENV=development

# Configuración de AWS DynamoDB
AWS_REGION=us-east-1
AWS_ACCESS_KEY_ID=local
AWS_SECRET_ACCESS_KEY=local
DYNAMODB_ENDPOINT=http://localhost:8000
DYNAMODB_TABLE_NAME=orders

# Configuración de Swagger
SWAGGER_PATH=/api-docs
SWAGGER_TITLE=Orders API
SWAGGER_VERSION=1.0.0

# Configuración de logging
LOG_LEVEL=debug

// === ARCHIVO: app/swagger.json ===
{
  "openapi": "3.0.3",
  "info": {
    "title": "Orders API",
    "description": "API para gestión de órdenes en DynamoDB",
    "version": "1.0.0",
    "contact": {
      "name": "Equipo de Operaciones"
    }
  },
  "servers": [
    {
      "url": "http://localhost:3000",
      "description": "Servidor de desarrollo"
    }
  ],
  "paths": {
    "/orders": {
      "post": {
        "summary": "Crear una nueva orden",
        "description": "Crea una nueva orden en el sistema. El identificador se genera automáticamente.",
        "operationId": "createOrder",
        "tags": ["Orders"],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/OrderCreateDTO"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Orden creada exitosamente",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/OrderDTO"
                }
              }
            }
          },
          "400": {
            "description": "Solicitud inválida",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ErrorResponse"
                }
              }
            }
          },
          "500": {
            "description": "Error interno del servidor",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ErrorResponse"
                }
              }
            }
          }
        }
      }
    },
    "/orders/{id}": {
      "get": {
        "summary": "Obtener una orden por ID",
        "description": "Recupera los detalles de una orden específica mediante su identificador.",
        "operationId": "getOrder",
        "tags": ["Orders"],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "Identificador único de la orden",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Orden encontrada",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/OrderDTO"
                }
              }
            }
          },
          "404": {
            "description": "Orden no encontrada",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ErrorResponse"
                }
              }
            }
          },
          "500": {
            "description": "Error interno del servidor",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ErrorResponse"
                }
              }
            }
          }
        }
      },
      "put": {
        "summary": "Actualizar una orden",
        "description": "Actualiza los datos de una orden existente. Solo se actualizan los campos proporcionados.",
        "operationId": "updateOrder",
        "tags": ["Orders"],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "Identificador único de la orden",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/OrderUpdateDTO"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Orden actualizada exitosamente",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/OrderDTO"
                }
              }
            }
          },
          "400": {
            "description": "Solicitud inválida",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ErrorResponse"
                }
              }
            }
          },
          "404": {
            "description": "Orden no encontrada",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ErrorResponse"
                }
              }
            }
          },
          "500": {
            "description": "Error interno del servidor",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ErrorResponse"
                }
              }
            }
          }
        }
      },
      "delete": {
        "summary": "Eliminar una orden",
        "description": "Elimina una orden del sistema permanentemente.",
        "operationId": "deleteOrder",
        "tags": ["Orders"],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "description": "Identificador único de la orden",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "204": {
            "description": "Orden eliminada exitosamente"
          },
          "404": {
            "description": "Orden no encontrada",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ErrorResponse"
                }
              }
            }
          },
          "500": {
            "description": "Error interno del servidor",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ErrorResponse"
                }
              }
            }
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "OrderCreateDTO": {
        "type": "object",
        "required": ["customerId", "items"],
        "properties": {
          "customerId": {
            "type": "string",
            "description": "Identificador único del cliente",
            "example": "cust-12345"
          },
          "items": {
            "type": "array",
            "items": {
              "type": "string"
            },
            "description": "Lista de artículos en la orden",
            "example": ["item-001", "item-002"]
          }
        }
      },
      "OrderUpdateDTO": {
        "type": "object",
        "properties": {
          "status": {
            "type": "string",
            "enum": ["PENDING", "CONFIRMED", "SHIPPED", "DELIVERED", "CANCELLED"],
            "description": "Nuevo estado de la orden"
          },
          "items": {
            "type": "array",
            "items": {
              "type": "string"
            },
            "description": "Lista actualizada de artículos"
          }
        }
      },
      "OrderDTO": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "description": "Identificador único de la orden",
            "example": "ord-67890"
          },
          "customerId": {
            "type": "string",
            "description": "Identificador del cliente",
            "example": "cust-12345"
          },
          "status": {
            "type": "string",
            "enum": ["PENDING", "CONFIRMED", "SHIPPED", "DELIVERED", "CANCELLED"],
            "description": "Estado actual de la orden"
          },
          "items": {
            "type": "array",
            "items": {
              "type": "string"
            },
            "description": "Artículos de la orden"
          },
          "createdAt": {
            "type": "string",
            "format": "date-time",
            "description": "Fecha de creación"
          },
          "updatedAt": {
            "type": "string",
            "format": "date-time",
            "description": "Última fecha de modificación"
          }
        }
      },
      "ErrorResponse": {
        "type": "object",
        "properties": {
          "message": {
            "type": "string",
            "description": "Mensaje de error"
          },
          "code": {
            "type": "string",
            "description": "Código de error"
          },
          "details": {
            "type": "object",
            "description": "Detalles adicionales del error"
          }
        }
      }
    }
  }
}

// === ARCHIVO: app/src/application/services/OrderService.ts ===
import { Order, OrderStatus } from '../../domain/models/Order';
import { OrderRepository } from '../../domain/repositories/OrderRepository';

export class OrderService {
  private readonly repository: OrderRepository;

  constructor(repository: OrderRepository) {
    this.repository = repository;
  }

  async createOrder(customerId: string, items: string[]): Promise<Order> {
    if (!customerId || customerId.trim().length === 0) {
      throw new InvalidOrderDataError('El identificador del cliente es requerido');
    }

    if (!items || items.length === 0) {
      throw new InvalidOrderDataError('La orden debe contener al menos un elemento');
    }

    const order = Order.createNewOrder(customerId, items);
    return this.repository.create(order);
  }

  async getOrder(id: string): Promise<Order> {
    if (!id || id.trim().length === 0) {
      throw new InvalidOrderDataError('El identificador de la orden es requerido');
    }

    const order = await this.repository.findById(id);
    if (!order) {
      throw new OrderNotFoundError(`No se encontró la orden con ID: ${id}`);
    }

    return order;
  }

  async updateOrder(id: string, status?: OrderStatus, items?: string[]): Promise<Order> {
    if (!id || id.trim().length === 0) {
      throw new InvalidOrderDataError('El identificador de la orden es requerido');
    }

    const existingOrder = await this.repository.findById(id);
    if (!existingOrder) {
      throw new OrderNotFoundError(`No se encontró la orden con ID: ${id}`);
    }

    if (status && !this.isValidStatusTransition(existingOrder.status, status)) {
      throw new InvalidStatusTransitionError(
        `Transición de estado inválida: de ${existingOrder.status} a ${status}`
      );
    }

    if (status) {
      existingOrder.updateStatus(status);
    }

    if (items && items.length > 0) {
      existingOrder.updateItems(items);
    }

    return this.repository.update(existingOrder);
  }

  async deleteOrder(id: string): Promise<void> {
    if (!id || id.trim().length === 0) {
      throw new InvalidOrderDataError('El identificador de la orden es requerido');
    }

    const existingOrder = await this.repository.findById(id);
    if (!existingOrder) {
      throw new OrderNotFoundError(`No se encontró la orden con ID: ${id}`);
    }

    return this.repository.delete(id);
  }

  private isValidStatusTransition(current: OrderStatus, next: OrderStatus): boolean {
    const allowedTransitions: Record<OrderStatus, OrderStatus[]> = {
      [OrderStatus.PENDING]: [OrderStatus.PROCESSING, OrderStatus.CONFIRMED, OrderStatus.CANCELLED],
      [OrderStatus.PROCESSING]: [OrderStatus.COMPLETED, OrderStatus.CANCELLED],
      [OrderStatus.CONFIRMED]: [OrderStatus.SHIPPED, OrderStatus.CANCELLED],
      [OrderStatus.SHIPPED]: [OrderStatus.DELIVERED, OrderStatus.CANCELLED],
      [OrderStatus.DELIVERED]: [OrderStatus.COMPLETED],
      [OrderStatus.COMPLETED]: [],
      [OrderStatus.CANCELLED]: [],
    };

    return allowedTransitions[current]?.includes(next) ?? false;
  }
}

export class InvalidOrderDataError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'InvalidOrderDataError';
  }
}

export class OrderNotFoundError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'OrderNotFoundError';
  }
}

export class InvalidStatusTransitionError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'InvalidStatusTransitionError';
  }
}

// === ARCHIVO: app/src/types/orderTypes.ts ===
import { OrderStatus } from '../domain/models/Order';

export interface OrderCreateDTO {
  customerId: string;
  items: string[];
}

export interface OrderUpdateDTO {
  status?: OrderStatus;
  items?: string[];
}

export interface OrderDTO {
  id: string;
  customerId: string;
  items: string[];
  status: OrderStatus;
  createdAt: string;
  updatedAt: string;
}

// === ARCHIVO: app/src/infrastructure/config/dynamoConfig.ts ===
import AWS from 'aws-sdk';
import dotenv from 'dotenv';

dotenv.config();

const region = process.env.AWS_REGION || 'us-east-1';
const endpoint = process.env.DYNAMO_ENDPOINT || undefined;
const accessKeyId = process.env.AWS_ACCESS_KEY_ID;
const secretAccessKey = process.env.AWS_SECRET_ACCESS_KEY;

const awsConfig: AWS.ConfigurationOptions = {
  region,
  ...(endpoint && { endpoint }),
  ...(accessKeyId && secretAccessKey && {
    accessKeyId,
    secretAccessKey,
  }),
};

AWS.config.update(awsConfig);

export const dynamoDB = new AWS.DynamoDB(awsConfig);

export const createDocumentClient = (): AWS.DynamoDB.DocumentClient => {
  return new AWS.DynamoDB.DocumentClient({
    ...awsConfig,
    apiVersion: '2012-08-10',
  });
};

export const getDynamoTableName = (): string => {
  const tableName = process.env.DYNAMO_TABLE_NAME;
  if (!tableName) {
    throw new Error('DYNAMO_TABLE_NAME environment variable is not set');
  }
  return tableName;
};

// === ARCHIVO: app/src/infrastructure/controllers/OrderController.ts ===
import { Request, Response, NextFunction } from 'express';
import { OrderService } from '../../application/services/OrderService';
import { OrderCreateDTO, OrderUpdateDTO, OrderDTO } from '../../types/orderTypes';
import { OrderStatus } from '../../domain/models/Order';

export class OrderController {
  private readonly orderService: OrderService;

  constructor(orderService: OrderService) {
    this.orderService = orderService;
  }

  async createOrder(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const dto: OrderCreateDTO = req.body;
      
      if (!dto.customerId || !dto.items || !Array.isArray(dto.items)) {
        res.status(400).json({ error: 'Invalid request: customerId and items are required' });
        return;
      }

      const order = await this.orderService.createOrder(dto.customerId, dto.items);
      const orderDTO: OrderDTO = this.mapToDTO(order);
      
      res.status(201).json(orderDTO);
    } catch (error) {
      next(error);
    }
  }

  async getOrder(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      
      if (!id) {
        res.status(400).json({ error: 'Order ID is required' });
        return;
      }

      const order = await this.orderService.getOrder(id);
      
      if (!order) {
        res.status(404).json({ error: 'Order not found' });
        return;
      }

      const orderDTO: OrderDTO = this.mapToDTO(order);
      res.status(200).json(orderDTO);
    } catch (error) {
      next(error);
    }
  }

  async updateOrder(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      const dto: OrderUpdateDTO = req.body;

      if (!id) {
        res.status(400).json({ error: 'Order ID is required' });
        return;
      }

      const existingOrder = await this.orderService.getOrder(id);
      if (!existingOrder) {
        res.status(404).json({ error: 'Order not found' });
        return;
      }

      let status: OrderStatus | undefined;
      if (dto.status !== undefined) {
        if (!this.isValidOrderStatus(dto.status)) {
          res.status(400).json({ error: 'Invalid order status' });
          return;
        }
        status = dto.status as OrderStatus;
      }

      const updatedOrder = await this.orderService.updateOrder(id, status, dto.items);
      const orderDTO: OrderDTO = this.mapToDTO(updatedOrder);
      res.status(200).json(orderDTO);
    } catch (error) {
      next(error);
    }
  }

  async deleteOrder(req: Request, res: Response, next: NextFunction): Promise<void> {
    try {
      const { id } = req.params;
      
      if (!id) {
        res.status(400).json({ error: 'Order ID is required' });
        return;
      }

      const existingOrder = await this.orderService.getOrder(id);
      if (!existingOrder) {
        res.status(404).json({ error: 'Order not found' });
        return;
      }

      await this.orderService.deleteOrder(id);
      res.status(204).send();
    } catch (error) {
      next(error);
    }
  }

  private mapToDTO(order: any): OrderDTO {
    return {
      id: order.id,
      customerId: order.customerId,
      items: order.items,
      status: order.status,
      createdAt: order.createdAt instanceof Date ? order.createdAt.toISOString() : order.createdAt,
      updatedAt: order.updatedAt instanceof Date ? order.updatedAt.toISOString() : order.updatedAt,
    };
  }

  private isValidOrderStatus(status: any): status is OrderStatus {
    const validStatuses = ['PENDING', 'PROCESSING', 'CONFIRMED', 'SHIPPED', 'DELIVERED', 'COMPLETED', 'CANCELLED'];
    return validStatuses.includes(status);
  }
}

// === ARCHIVO: infra/providers.tf ===
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

// === ARCHIVO: infra/variables.tf ===
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

// === ARCHIVO: infra/modules/dynamodb/variables.tf ===
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

// === ARCHIVO: infra/versions.tf ===
terraform {
  required_version = ">= 1.9.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.70.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "terraform"
      Project     = "crud-orders-dynamodb"
    }
  }

  skip_credentials_validation = false
  skip_requesting_account_id  = false
  skip_metadata_api_check     = true
}

variable "aws_region" {
  description = "Región de AWS donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "El entorno debe ser uno de: dev, staging, prod"
  }
}

output "aws_region" {
  description = "Región de AWS configurada"
  value       = var.aws_region
}

output "environment" {
  description = "Entorno de despliegue"
  value       = var.environment
}

// === ARCHIVO: infra/README.md ===
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

// === ARCHIVO: infra/main.tf ===
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

// === ARCHIVO: infra/outputs.tf ===
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

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
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

// === ARCHIVO: infra/modules/dynamodb/main.tf ===
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

// === ARCHIVO: infra/modules/dynamodb/outputs.tf ===
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

// === ARCHIVO: docker-compose.yml ===
# Infraestructura local del reto. SOLO desarrollo: credenciales de ejemplo (local-dev-only), puertos en loopback.
# Levantar: docker compose up -d --wait
name: infra-local
services:
  dynamodb-local:
    image: "amazon/dynamodb-local:2.5.2"
    command: ["-jar","DynamoDBLocal.jar","-sharedDb","-inMemory"]
    ports:
      - "127.0.0.1:8000:8000"
    healthcheck:
      test: ["CMD-SHELL","bash -c ':> /dev/tcp/127.0.0.1/8000' || exit 1"]
      interval: 10s
      timeout: 5s
      retries: 10
      start_period: 5s


// === ARCHIVO: infra-local/README.md ===
# Infraestructura local

Servicios de soporte para el reto, definidos en `docker-compose.yml` (raiz del repo).

```bash
docker compose up -d --wait
```

| Servicio | Imagen | Puertos (host) |
|---|---|---|
| DynamoDB Local | `amazon/dynamodb-local:2.5.2` | 8000 |

Credenciales: solo de desarrollo local (`local-dev-only`, `local`). No son secretos ni deben reutilizarse.
Los scripts de `infra-local/` (tablas, topics) se ejecutan con el compose en estado healthy.


// === ARCHIVO: infra-local/dynamodb/create-tables.sh ===
#!/usr/bin/env bash
# Crea las tablas en DynamoDB Local (idempotente). Credenciales dummy: DynamoDB Local no valida firmas.
set -euo pipefail

export AWS_ACCESS_KEY_ID=local
export AWS_SECRET_ACCESS_KEY=local
export AWS_REGION=us-east-1
ENDPOINT="${DYNAMODB_ENDPOINT:-http://localhost:8000}"

create_table() {
  local name="$1" pk="$2" sk="${3:-}"
  if aws dynamodb describe-table --table-name "$name" --endpoint-url "$ENDPOINT" >/dev/null 2>&1; then
    echo "Tabla $name ya existe"
    return
  fi
  local attrs="AttributeName=$pk,AttributeType=S"
  local keys="AttributeName=$pk,KeyType=HASH"
  if [ -n "$sk" ]; then
    attrs="$attrs AttributeName=$sk,AttributeType=S"
    keys="$keys AttributeName=$sk,KeyType=RANGE"
  fi
  # shellcheck disable=SC2086
  aws dynamodb create-table --table-name "$name" --attribute-definitions $attrs --key-schema $keys \
    --billing-mode PAY_PER_REQUEST --endpoint-url "$ENDPOINT" >/dev/null
  echo "Tabla $name creada"
}

create_table "app-items" "id"

```
