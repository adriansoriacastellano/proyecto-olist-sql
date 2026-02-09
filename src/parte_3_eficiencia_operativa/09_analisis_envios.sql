-- Análisis de envios por Estado
-- Este análisis se centra en evaluar la eficiencia de los envios por estado


SELECT 
    c.customer_state AS estado,
    COUNT(DISTINCT o.order_id) AS total_pedidos,
    
    -- Calculamos la eficiencia promedio de los envios (Fecha Real - Fecha Prometida)

    -- Si es negativo, significa que llegó ANTES de tiempo.
    -- Si es positivo, llegó TARDE.
    ROUND(AVG(
        julianday(o.order_delivered_customer_date) - 
        julianday(o.order_estimated_delivery_date)
    ), 2) AS promedio_dias_retraso,
    
    -- Calculamos el % de pedidos que llegaron tarde (Real > Estimada)

    ROUND(SUM(
        CASE 
            WHEN julianday(o.order_delivered_customer_date) > julianday(o.order_estimated_delivery_date) THEN 1 
            ELSE 0 
        END
    ) * 100.0 / COUNT(o.order_id), 2) AS porcentaje_pedidos_tardios

-- Unimos las tablas de pedidos y clientes para obtener el estado del cliente
FROM olist_orders_dataset o
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id

-- Filtramos solo los pedidos que fueron entregados para evaluar la eficiencia real de los envios
WHERE o.order_status = 'delivered' 
  AND o.order_delivered_customer_date IS NOT NULL 
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY c.customer_state
-- Filtramos estados con pocos datos para evitar distorsiones
HAVING total_pedidos > 50 
ORDER BY porcentaje_pedidos_tardios DESC;