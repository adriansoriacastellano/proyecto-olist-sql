-- RFM Resumen final con segmentos

WITH rfm_calculo AS (
    -- Misma lógica del script anterior (07_rfm_calculo.sql)
    SELECT 
        c.customer_unique_id,
        CAST(julianday((SELECT MAX(order_purchase_timestamp) FROM olist_orders_dataset)) - julianday(MAX(o.order_purchase_timestamp)) 
        AS INTEGER) AS recency_days,
        COUNT(DISTINCT o.order_id) AS frequency,
        SUM(p.payment_value) AS monetary_value
    FROM olist_orders_dataset o
    JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
    JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
    WHERE o.order_status <> 'canceled'
    GROUP BY c.customer_unique_id
),
rfm_scores AS (
    -- Calculamos los Tiers o Top para cada métrica (recencia, frecuencia, monetario)
    SELECT 
        customer_unique_id,
        monetary_value,
        NTILE(5) OVER (ORDER BY recency_days ASC) AS r_tier,
        CASE 
            WHEN frequency >= 5 THEN 1
            WHEN frequency >= 3 THEN 2
            WHEN frequency = 2 THEN 3
            ELSE 4
        END AS f_tier,
        NTILE(5) OVER (ORDER BY monetary_value DESC) AS m_tier
    FROM rfm_calculo
)

-- INFORME FINAL
SELECT 
    CASE 
        WHEN f_tier <= 2 OR m_tier = 1 THEN 'VIP Customer'  -- Clientes con alta frecuencia o el más alto gasto
        WHEN r_tier <= 2 THEN 'Catchable Customer'  -- Clientes recientes
        WHEN r_tier >= 4 THEN 'Unretained Customer'  -- Clientes no fidelizados (no compran hace mucho)
        ELSE 'Standard Customer' END AS Customer_Type,
    COUNT(*) AS cantidad_clientes,
    ROUND(AVG(monetary_value), 2) AS ingreso_promedio,
    ROUND(SUM(monetary_value), 2) AS total_ingresos
FROM rfm_scores
GROUP BY Customer_Type
ORDER BY total_ingresos DESC;