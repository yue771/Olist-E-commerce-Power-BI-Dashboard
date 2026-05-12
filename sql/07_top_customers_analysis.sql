USE olist_ecommerce;

-- 高价值用户分析

SELECT TOP 20

    c.customer_unique_id,

    COUNT(DISTINCT o.order_id) AS total_orders,

    SUM(oi.price) AS total_spent,

    AVG(oi.price) AS avg_spent

FROM dbo.customers c

JOIN dbo.orders o
    ON c.customer_id = o.customer_id

JOIN dbo.order_items oi
    ON o.order_id = oi.order_id

GROUP BY
    c.customer_unique_id

ORDER BY
    total_spent DESC;