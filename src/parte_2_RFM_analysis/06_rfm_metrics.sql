-- Análisis RFM (Recency, Frequency, Monetary). El análisis RFM clasifica a los clientes en tres ejes:
-- Recencia (R): ¿Hace cuánto compró por última vez? (Menos días = Mejor).
-- Frecuencia (F): ¿Cuántas veces ha comprado? (Más veces = Mejor).
-- Valor Monetario (M): ¿Cuánto ha gastado en total? (Más dinero = Mejor).

-- Calculamos cuál es la fecha más reciente de todo el dataset ("Hoy" simulado)
WITH reference_date AS (
    SELECT MAX(order_purchase_timestamp) as max_date
    FROM olist_orders_dataset
)

-- Calculamos las métricas RFM para cada cliente
SELECT 
    c.customer_unique_id,
    -- RECENCY: Días desde la última compra hasta la fecha máxima del dataset
    CAST(
        julianday((SELECT max_date FROM reference_date)) - 
        julianday(MAX(o.order_purchase_timestamp)) 
    AS INTEGER) AS recency_days,

    -- FREQUENCY: Cantidad de pedidos distintos
    COUNT(DISTINCT o.order_id) AS frequency,
    
    -- MONETARY: Dinero total gastado
    ROUND(SUM(p.payment_value), 2) AS monetary_value

-- Unimos las tablas de pedidos, clientes y pagos para obtener la información necesaria
FROM olist_orders_dataset o
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
-- Excluimos los pedidos cancelados para obtener métricas más precisas
WHERE o.order_status <> 'canceled'
GROUP BY c.customer_unique_id
-- Ordenamos por valor monetario para identificar a los clientes más valiosos
ORDER BY monetary_value DESC;