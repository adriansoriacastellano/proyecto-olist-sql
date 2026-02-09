# 📊 Olist E-Commerce Analysis (SQL End-to-End)

## 🎯 Objetivo del Proyecto
Actuar como Consultor de Datos para Olist (Marketplace Brasileño) con el objetivo de optimizar **Ventas**, **Retención de Clientes** y **Eficiencia Logística**.
Se ha analizado un dataset de **100k pedidos** (2016-2018) utilizando técnicas avanzadas de SQL.

## 🛠️ Stack Tecnológico
* **Lenguaje:** SQL (SQLite).
* **Herramientas:** DBeaver (Análisis), VS Code (Gestión), Git/GitHub (Control de Versiones).
* **Técnicas:** Window Functions (`NTILE`, `RANK`), CTEs, Vistas (`CREATE VIEW`), Segmentación RFM.

## 💡 Insights Clave (Resultados)

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

## 📂 Estructura del Proyecto

El código está organizado en carpetas lógicas para facilitar la mantenibilidad:

* `/src/parte_1_insights_generales`: KPIs financieros, categorías top y tendencias temporales.
* `/src/parte_2_RFM_analysis`: Segmentación avanzada de clientes (Recencia, Frecuencia, Monetario).
* `/src/parte_3_eficiencia_operativa`: Auditoría de tiempos de entrega y su impacto en reviews.
* `/src/parte_4_ingenieria_datos`: Creación de **Vistas SQL** (`v_ecommerce_stats`, `v_clientes_rfm` y `v_logistic_stack`) para automatizar el reporte en herramientas de BI.

---
*Autor: Adrian Soria Castellano | Proyecto realizado como parte de portfolio de Data Analytics.*