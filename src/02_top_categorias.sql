-- Análisis de las 10 categorías de productos con mayores ingresos totales

SELECT 
    -- Se utiliza la traducción al inglés para mayor claridad
    t.product_category_name_english AS categoria,
    COUNT(*) AS total_ventas,
    SUM(i.price) AS ingresos_totales
    -- Se unen las tablas necesarias para obtener la información requerida
FROM olist_order_items_dataset i
JOIN olist_products_dataset p 
    ON i.product_id = p.product_id
JOIN product_category_name_translation t 
    ON p.product_category_name = t.product_category_name
    -- Se agrupan los resultados por categoría de producto y se ordenan por ingresos totales para obtener las top 10
GROUP BY 
    t.product_category_name_english
ORDER BY 
    ingresos_totales DESC
LIMIT 10;