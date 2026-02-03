-- Evolución mensual de pedidos y facturación con ranking de ventas

SELECT 
    strftime('%Y-%m', o.order_purchase_timestamp) AS mes_anyo,
    COUNT(DISTINCT o.order_id) AS total_pedidos,
    SUM(p.payment_value) AS facturacion_total,
    -- Se le asigna un ranking basado en la facturación total mensual
    RANK() OVER (ORDER BY SUM(p.payment_value) DESC) as ranking_ventas
-- Unimos las tablas de pedidos y pagos    
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p 
    ON o.order_id = p.order_id
-- Filtramos pedidos cancelados y nulos en la fecha de compra
WHERE o.order_status <> 'canceled'
    AND o.order_purchase_timestamp IS NOT NULL
GROUP BY mes_anyo
ORDER BY mes_anyo;