-- Impacto Logístico Integral
-- Este análisis se centra en evaluar el impacto de la logística integral en la satisfacción del cliente

SELECT 
    -- Situación de entrega (Puntual vs Tardío):
    CASE 
        WHEN julianday(o.order_delivered_customer_date) <= julianday(o.order_estimated_delivery_date) 
        THEN 'Puntual'
        ELSE 'Tardío'
    END AS situacion_entrega,

    -- Volumen total por cada situación:
    COUNT(DISTINCT o.order_id) AS total_pedidos,

    -- Score promedio de los pedidos en cada situación:
    ROUND(AVG(r.review_score), 2) AS nota_promedio,

    -- ¿Cuántos pedidos recibieron una calificación menor a 2?
    SUM(CASE WHEN r.review_score < 2 THEN 1 ELSE 0 END) AS 'total_score_<_2',

    -- % de clientes insatisfechos (score < 2) en cada situación:
    ROUND(CAST(SUM(CASE WHEN r.review_score < 2 THEN 1 ELSE 0 END) AS FLOAT) 
    / COUNT(DISTINCT o.order_id) * 100, 2) || '%' AS '%_insatisfaction'

-- Unimos las tablas de pedidos y reseñas para evaluar la relación entre la puntualidad de la entrega y la satisfacción del cliente
FROM olist_orders_dataset o
JOIN olist_order_reviews_dataset r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered' 
  AND o.order_delivered_customer_date IS NOT NULL 
  AND o.order_estimated_delivery_date IS NOT NULL

-- Agrupamos por la situación de entrega para comparar la eficiencia de los envíos con la satisfacción del cliente
GROUP BY situacion_entrega
ORDER BY nota_promedio DESC;