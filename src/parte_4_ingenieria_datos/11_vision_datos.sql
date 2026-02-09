-- VISTA 1: Tabla Maestra de KPIs de E-commerce

CREATE VIEW v_ecommerce_stats AS
SELECT 
    strftime('%Y-%m', o.order_purchase_timestamp) AS mes_anyo,

    COUNT(DISTINCT o.order_id) AS total_pedidos,
    COUNT(DISTINCT c.customer_unique_id) AS total_clientes,
    ROUND(SUM(p.payment_value), 2) AS ingresos_totales,
    ROUND(AVG(p.payment_value), 2) AS ticket_medio,
    ROUND(SUM(p.payment_value) / COUNT(DISTINCT c.customer_unique_id), 2) AS ingreso_por_usuario

FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p ON o.order_id = p.order_id
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
WHERE o.order_status <> 'canceled'
GROUP BY mes_anyo;

-- VISTA 2: Tabla de Clientes VIP

CREATE VIEW v_clientes_rfm AS
WITH rfm_real AS (
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
rfm_tiers AS (
    SELECT 
        *,
        NTILE(5) OVER (ORDER BY recency_days ASC) AS r_tier,
        CASE 
            WHEN frequency >= 5 THEN 1
            WHEN frequency >= 3 THEN 2
            WHEN frequency = 2 THEN 3
            ELSE 4
        END AS f_tier, 
        NTILE(5) OVER (ORDER BY monetary_value DESC) AS m_tier
    FROM rfm_real
)

SELECT 
    customer_unique_id,
    recency_days,
    frequency,
    monetary_value,
    r_tier, f_tier, m_tier,
    CASE 
        WHEN f_tier <= 2 OR m_tier = 1 THEN 'VIP Customer'
        WHEN r_tier <= 2 THEN 'Catchable Customer'
        WHEN r_tier >= 4 THEN 'Unretained / Lost'
        ELSE 'Standard Customer' END AS customer_segment
FROM rfm_tiers;

-- VISTA 3: Tabla de Logística

CREATE VIEW IF NOT EXISTS v_logistic_stack AS
SELECT 

    CASE 
        WHEN julianday(o.order_delivered_customer_date) <= julianday(o.order_estimated_delivery_date) 
        THEN 'Puntual'
        ELSE 'Tardío'
    END AS situacion_entrega,

    COUNT(DISTINCT o.order_id) AS total_pedidos,
    ROUND(AVG(r.review_score), 2) AS nota_promedio,
    SUM(CASE WHEN r.review_score < 2 THEN 1 ELSE 0 END) AS total_score_menor_2,
    ROUND(CAST(SUM(CASE WHEN r.review_score < 2 THEN 1 ELSE 0 END) AS FLOAT) 
    / COUNT(DISTINCT o.order_id) * 100, 2) || '%' AS porcentaje_insatisfaccion

FROM olist_orders_dataset o
JOIN olist_order_reviews_dataset r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered' 
  AND o.order_delivered_customer_date IS NOT NULL 
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY situacion_entrega
ORDER BY nota_promedio DESC;