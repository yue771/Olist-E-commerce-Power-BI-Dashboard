USE olist_ecommerce;

-- 热门商品品类分析

SELECT TOP 10

    p.product_category_name,

    COUNT(*) AS total_items_sold,

    SUM(oi.price) AS total_sales,

    AVG(oi.price) AS avg_price

FROM dbo.order_items oi

JOIN dbo.products p
    ON oi.product_id = p.product_id

GROUP BY
    p.product_category_name

ORDER BY
    total_sales DESC;