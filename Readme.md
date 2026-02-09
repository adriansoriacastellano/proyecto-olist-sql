# 📊 Olist E-Commerce Analysis (SQL End-to-End)

## 🎯 Objetivo del Proyecto
Actuar como Consultor de Datos para Olist (Marketplace Brasileño) con el objetivo de optimizar **Ventas**, **Retención de Clientes** y **Eficiencia Logística**.
Se ha analizado un dataset de **100k pedidos** (2016-2018) utilizando técnicas avanzadas de SQL.

## 🛠️ Stack Tecnológico
* **Motor de Base de Datos:** SQLite.
* **Cliente SQL:** DBeaver (para exploración y validación).
* **IDE:** VS Code (para gestión de scripts y versionado).
* **Control de Versiones:** Git & GitHub.

# Resultados del Análisis

## 📊 PARTE I: INSIGHTS GENERALES (`/src`: del 01 hasta el 05)

### 1. 💰 Segmentación de Clientes (RFM)
* **El Problema de Retención:** El **97%** de los clientes ha comprado una sola vez. Olist es una máquina de adquisición, pero falla en fidelización.
* **Las "Ballenas":** Se identificaron clientes VIP con gastos superiores a **13.000 BRL** y alta frecuencia (Tier 1).
* **Acción Recomendada:** Crear un programa de fidelidad inmediato para los clientes "Prometedores" (frecuencia = 2) para evitar que caigan en el segmento "Dormidos".

### 2. 🚚 Eficiencia Operativa & Logística
* **La "Zona de la Muerte":** El estado de **Alagoas (AL)** presenta los peores índices de retraso.
* **Impacto en Negocio:** Se demostró una correlación directa entre puntualidad y satisfacción:
    * 📦 Pedidos a tiempo: **6.6%** de insatisfacción.
    * ⏳ Pedidos con retraso: **46.6%** de insatisfacción.
    * **Conclusión:** Un retraso logístico multiplica por **7x** la probabilidad de perder al cliente.

### 3. 📈 Tendencias de Mercado
* **Black Friday 2017:** Fue el pico histórico de ventas, validando la sensibilidad al precio.
* **Categorías:** "Health & Beauty" lidera el mercado, superando a tecnología.

## 📂 Estructura del Repositorio
* `/src`: Contiene los scripts SQL numerados por orden de ejecución lógica.