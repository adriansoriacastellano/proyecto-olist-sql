-- Evaluación sobre si los envios gratuitos son rentables

SELECT 
    c.customer_state AS estado,
    COUNT(DISTINCT o.order_id) AS total_pedidos,
    SUM(i.price) AS total_ventas_producto,
    ROUND(AVG(i.price), 2) AS ticket_medio_producto,
    ROUND(AVG(i.freight_value), 2) AS coste_medio_envio,
    ROUND((SUM(i.freight_value) / SUM(i.price)) * 100, 2) AS impacto_envio_porcentaje
--  Tripe join entre las tablas de pedidos, clientes y items de pedido
FROM olist_orders_dataset o
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
JOIN olist_order_items_dataset i ON o.order_id = i.order_id
-- Filtrado para excluir pedidos cancelados
WHERE o.order_status <> 'canceled'
-- Agrupación por estado del cliente
GROUP BY c.customer_state
-- Filtramos estados con pocos pedidos para mayor relevancia
HAVING total_pedidos > 50
-- Se podría por cualquier otro criterio, aquí se ordena por el impacto del coste de envío
ORDER BY impacto_envio_porcentaje ASC;