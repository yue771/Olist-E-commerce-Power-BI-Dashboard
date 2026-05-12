USE olist_ecommerce;

-- 用户复购分析

WITH customer_orders AS (

    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.price) AS total_spent

    FROM dbo.customers c

    JOIN dbo.orders o
        ON c.customer_id = o.customer_id

    JOIN dbo.order_items oi
        ON o.order_id = oi.order_id

    GROUP BY
        c.customer_unique_id
)

SELECT

    CASE
        WHEN total_orders = 1 THEN 'One-time Customers'
        ELSE 'Repeat Customers'
    END AS customer_type,

    COUNT(*) AS customer_count,

    AVG(total_spent) AS avg_spent,

    SUM(total_spent) AS total_revenue

FROM customer_orders

GROUP BY
    CASE
        WHEN total_orders = 1 THEN 'One-time Customers'
        ELSE 'Repeat Customers'
    END;