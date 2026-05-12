USE olist_ecommerce;

-- RFM 基础分析

SELECT TOP 20

    c.customer_unique_id,

    MAX(o.order_purchase_timestamp) AS last_purchase_date,

    COUNT(DISTINCT o.order_id) AS frequency,

    SUM(oi.price) AS monetary

FROM dbo.customers c

JOIN dbo.orders o
    ON c.customer_id = o.customer_id

JOIN dbo.order_items oi
    ON o.order_id = oi.order_id

GROUP BY
    c.customer_unique_id

ORDER BY
    monetary DESC;