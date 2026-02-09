# Análisis del E-Commerce Brasileño (Olist)

## 🎯 Objetivo del Proyecto
Analizar el dataset público de Olist (100k pedidos, 2016-2018) para responder preguntas clave de negocio sobre **Ventas**, **Logística** y **Comportamiento del Consumidor**.

## 🛠️ Stack Tecnológico
* **Motor de Base de Datos:** SQLite.
* **Cliente SQL:** DBeaver (para exploración y validación).
* **IDE:** VS Code (para gestión de scripts y versionado).
* **Control de Versiones:** Git & GitHub.

# Resultados del Análisis

## 📊 PARTE I: INSIGHTS GENERALES (/src: del 01 hasta el 05)

### 1. Rendimiento Financiero
* **Ventas Totales:** La compañía ha generado más de **13.5 Millones de BRL** en ventas históricas.
* **Ticket Medio:** El gasto promedio por pedido es de **~120 BRL**, indicando un mercado de consumo masivo/retail.

### 2. Comportamiento del Consumidor
* **Top Categoría:** "Health & Beauty" lidera las ventas, superando a categorías tradicionales como electrónica.
* **Métodos de Pago:** La **Tarjeta de Crédito** domina las transacciones (>70k pedidos), permitiendo cuotas (installments) que facilitan compras de mayor valor.

### 3. Logística y Geografía
* **Fricción Logística:** Se detectó que en ciertos estados, el coste del envío representa hasta un **26% del valor del producto**.
* **Estrategia Recomendada:** * *Estados Centrales (SP, RJ):* Implementar "Envío Gratis" para aumentar conversión (coste logístico bajo).
    * *Estados Periféricos:* Mantener coste de envío o subsidiar solo en tickets altos (>200 BRL) para proteger el margen.

### 4. Estacionalidad
* El **Black Friday de Noviembre 2017** fue el pico histórico de ventas, validando la sensibilidad al precio de la base de usuarios.

## 📂 Estructura del Repositorio
* `/src`: Contiene los scripts SQL numerados por orden de ejecución lógica.
