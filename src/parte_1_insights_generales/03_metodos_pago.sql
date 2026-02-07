-- Análisis de los métodos de pago utilizados en los pedidos de Olist

SELECT 
    payment_type AS metodo_pago,
    COUNT(*) AS cantidad_pedidos,
    SUM(payment_value) AS facturacion_total,
    ROUND(AVG(payment_value), 2) AS ticket_medio,
    MAX(payment_installments) AS maximo_cuotas
FROM olist_order_payments_dataset
-- Se agrupan los resultados por método de pago, aunque solo se consideran aquellos con más de 100 pedidos
GROUP BY payment_type
HAVING cantidad_pedidos > 100
-- Aunque también se podría ordenar por cantidad de pedidos
ORDER BY facturacion_total DESC;