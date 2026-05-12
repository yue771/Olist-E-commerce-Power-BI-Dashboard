USE olist_ecommerce;

-- 用户城市分布分析

SELECT TOP 10

    c.customer_city,

    COUNT(DISTINCT c.customer_unique_id) AS total_customers,

    COUNT(DISTINCT o.order_id) AS total_orders,

    SUM(oi.price) AS total_gmv

FROM dbo.customers c

JOIN dbo.orders o
    ON c.customer_id = o.customer_id

JOIN dbo.order_items oi
    ON o.order_id = oi.order_id

GROUP BY
    c.customer_city

ORDER BY
    total_gmv DESC;