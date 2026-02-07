-- En este paso, vamos a segmentar a los clientes en grupos basados en sus métricas RFM. 
-- Para esto, asignaremos un "Tier o Top" del 1 al 5 para cada métrica,
-- donde 1 representa el mejor comportamiento (más reciente, más frecuente, mayor gasto).


-- Volvemos a calcular las métricas crudas (ver archivo 06_rfm_metrics.sql para referencia)
WITH rfm_metrics AS (
    SELECT 
        c.customer_unique_id,

        CAST(
            julianday((SELECT MAX(order_purchase_timestamp) FROM olist_orders_dataset)) - 
            julianday(MAX(o.order_purchase_timestamp)) 
        AS INTEGER) AS recency_days,

        COUNT(DISTINCT o.order_id) AS frequency,

        SUM(p.payment_value) AS monetary_value

    FROM olist_orders_dataset o
    JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
    JOIN olist_order_payments_dataset p ON o.order_id = p.order_id

    WHERE o.order_status <> 'canceled'
    GROUP BY c.customer_unique_id
)

-- Ahora asignamos los "Tiers" del 1 al 5 para cada métrica usando NTILE, donde 1 es el mejor comportamiento.
SELECT 
    customer_unique_id,
    recency_days,
    frequency,
    monetary_value,

    -- RECENCIA: Tier 1 es el que compró "ayer" (Menor número de días)
    NTILE(5) OVER (ORDER BY recency_days ASC) AS r_tier,
    
    -- FRECUENCIA: Lógica de Negocio (Reglas fijas). Para frecuencia se decide utilizar una lógica de negocio con reglas fijas,
    -- ya que la distribución de frecuencia suele ser muy sesgada (97% de clientes con 1 pedido, pocos con muchos pedidos).
    CASE 
        WHEN frequency >= 5 THEN 1  -- Super Fiel
        WHEN frequency >= 3 THEN 2  -- Fiel
        WHEN frequency = 2 THEN 3   -- Prometedor
        ELSE 4                      -- Un solo pedido (Normal)
    END AS f_tier,
    
    -- MONETARIO: Tier 1 es el que gasta más dinero
    NTILE(5) OVER (ORDER BY monetary_value DESC) AS m_tier

FROM rfm_metrics
-- Ordenamos por valor monetario para identificar a los clientes más valiosos
ORDER BY monetary_value DESC;