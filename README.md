# Implementación de CRUD de órdenes en DynamoDB

El sistema debe permitir la creación, lectura, actualización y eliminación de órdenes en una tabla de DynamoDB. Los órdenes son gestionados por el equipo de operaciones y consumidos por el sistema de facturación. Cada orden tiene un identificador único, un estado, una fecha de creación y una fecha de modificación. El sistema debe garantizar que los identificadores de órdenes no se dupliquen y que los estados de órdenes sean válidos según las reglas de negocio definidas.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | CRUD de ordenes sobre DynamoDB |
| **Nivel** | advanced-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y entregará cada archivo con su ruta.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Node.js 18+, npm, VS Code o similar.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y entregará cada archivo con su ruta. Guárdalos en la carpeta donde quieras trabajar, respetando las rutas.
- Ejecuta `npm install && npm run build` (o `npm start`). Si no hay errores, estás listo.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no entrega todos los archivos al terminar el análisis, escríbele: "entrégame todos los archivos con su ruta".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Creación de la tabla DynamoDB y operaciones básicas

**Objetivo:** Implementar las operaciones básicas de CRUD para órdenes en DynamoDB.

**Tiempo estimado:** 4 horas

**Instrucciones:**

- Diseña la estructura de la tabla DynamoDB para almacenar órdenes.
- Implementa las operaciones de creación, lectura, actualización y eliminación de órdenes.
- Asegúrate de que los identificadores de órdenes sean únicos y que los estados de órdenes sean válidos.

**Entregable:** Tabla DynamoDB con esquema definido y operaciones CRUD implementadas.

<details>
<summary>Pistas de conocimiento</summary>

- Considera las restricciones de DynamoDB al diseñar la estructura de la tabla.
- Usa Terraform para gestionar la infraestructura de DynamoDB.

</details>

### Fase 2: Exposición de las operaciones CRUD a través de una API REST

**Objetivo:** Exponer las operaciones CRUD de órdenes a través de una API REST.

**Tiempo estimado:** 4 horas

**Instrucciones:**

- Crea una API REST que exponga las operaciones CRUD implementadas en la fase anterior.
- Asegúrate de que la API REST sigue las mejores prácticas de seguridad y rendimiento.
- Documenta la API REST utilizando OpenAPI.

**Entregable:** API REST documentada que expone las operaciones CRUD de órdenes.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el uso de middleware para manejar errores y validaciones en la API REST.
- Usa Terraform para gestionar la infraestructura de la API REST.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es una operación CRUD y cómo se aplica en el contexto de DynamoDB?
- **paraQueSirve**: ¿Para qué sirve exponer las operaciones CRUD a través de una API REST?
- **comoSeUsa**: ¿Cómo se usan las operaciones CRUD en el flujo de trabajo del equipo de operaciones?

## Criterios de Evaluacion

- Implementación correcta de las operaciones CRUD en DynamoDB.
- Exposición adecuada de las operaciones CRUD a través de una API REST.
- Seguridad y rendimiento de la API REST.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT) si no tenes un agente en el IDE. Declara lo mismo que AGENTS.md; los archivos que te devuelva el chat los guardas en esta carpeta respetando las rutas.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

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

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd app && npm install && npm run build) && (cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && docker compose config -q
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
