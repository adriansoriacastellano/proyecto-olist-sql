-- ¿Cuánto ha vendido Olist en total en toda su historia según este dataset?
SELECT 
    SUM(price) AS ventas_totales_historicas,
    COUNT(*) AS numero_total_productos_vendidos,
    AVG(price) AS precio_promedio_producto
FROM olist_order_items_dataset;