# Proyecto de Ingeniería de Analytics con dbt

## Descripción General

Este proyecto es un caso de estudio de Ingeniería de Analytics construido con **dbt + DuckDB**, basado en datasets CSV sin procesar.

El objetivo es construir un modelo analítico limpio siguiendo un **enfoque de medallón / esquema de estrella**, permitiendo el cálculo confiable de KPIs y análisis escalables.

---

## Tecnologías Utilizadas

- dbt Core
- DuckDB
- SQL
- CSV (datos semilla)

---

## Estructura del Proyecto
models/
├── staging/ # Limpieza y estandarización de datos sin procesar
├── marts/ # Capa analítica (hechos y dimensiones)
│ ├── facts/
│ ├── dimensions/
│ └── metrics/
seeds/ # Datasets CSV sin procesar


---

## Pipeline de Datos

### 1. Ingesta de semillas (seeds)
Carga los archivos CSV sin procesar en DuckDB:
dbt seed


### 2. Transformación
Construye los modelos staging, aplicando:
- Estandarización de tipos de datos
- Parseo de fechas
- Limpieza y normalización
- Tablas de mapeo (estandarización de estados)
dbt run


### 3. Pruebas
Ejecuta controles de calidad de datos:
dbt test


Incluye:
- Restricciones únicas
- Validación de valores no nulos
- Integridad referencial
- Validación de reglas de negocio

---

## Documentación de dbt

Generar y servir la documentación:
dbt docs generate
dbt docs serve

text

Esto proporciona:
- Linaje de modelos (DAG)
- Documentación a nivel de columna
- Gráfico de dependencias

---

## Modelos de Datos Clave

### Hechos (Facts)
- **fct_appointments** → Modelo transaccional principal
- **fct_reviews** → Feedback de pacientes
- **fct_events** → Seguimiento de comportamiento de usuarios

### Dimensiones
- **dim_patients** (Pacientes)
- **dim_doctors** (Médicos)
- **dim_date** (Fechas)

---

## KPIs Principales

- Tasa de Conversión de Citas
- Tasa de Finalización
- Utilización de Médicos (mensual)

Todos los KPIs están construidos sobre la capa de marts.

---

## Decisiones de Diseño

- Events y appointments se modelan por separado debido a que pertenecen a dominios analíticos diferentes (datos de comportamiento vs datos transaccionales).
- La normalización de estados se maneja mediante una tabla semilla de mapeo dedicada.
- La capa staging se utiliza para garantizar la consistencia de los datos antes del modelado analítico.

---

## Cómo Ejecutar el Proyecto

Orden de ejecución recomendado:

```bash
dbt seed
dbt run
dbt test

Posible ejecución para documentación:
dbt docs generate
dbt docs serve