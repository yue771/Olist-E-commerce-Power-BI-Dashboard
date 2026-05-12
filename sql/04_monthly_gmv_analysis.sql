USE olist_ecommerce;

-- 每月 GMV 分析

SELECT
    YEAR(o.order_purchase_timestamp) AS order_year,
    MONTH(o.order_purchase_timestamp) AS order_month,

    COUNT(DISTINCT o.order_id) AS total_orders,

    SUM(oi.price) AS total_gmv,

    AVG(oi.price) AS avg_order_value

FROM dbo.orders o

JOIN dbo.order_items oi
    ON o.order_id = oi.order_id

GROUP BY
    YEAR(o.order_purchase_timestamp),
    MONTH(o.order_purchase_timestamp)

ORDER BY
    order_year,
    order_month;