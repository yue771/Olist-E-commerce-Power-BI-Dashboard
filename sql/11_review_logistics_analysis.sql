USE olist_ecommerce;

-- 物流是否延迟与用户评分分析

WITH delivery_analysis AS (

    SELECT
        o.order_id,
        r.review_score,

        DATEDIFF(
            DAY,
            o.order_purchase_timestamp,
            o.order_delivered_customer_date
        ) AS actual_delivery_days,

        DATEDIFF(
            DAY,
            o.order_purchase_timestamp,
            o.order_estimated_delivery_date
        ) AS estimated_delivery_days,

        CASE
            WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
                THEN 'Delayed'
            ELSE 'On Time'
        END AS delivery_status

    FROM dbo.orders o

    JOIN dbo.reviews r
        ON o.order_id = r.order_id

    WHERE o.order_delivered_customer_date IS NOT NULL
      AND o.order_estimated_delivery_date IS NOT NULL
)

SELECT
    delivery_status,
    COUNT(*) AS order_count,
    AVG(CAST(review_score AS FLOAT)) AS avg_review_score,
    AVG(actual_delivery_days) AS avg_actual_delivery_days,
    AVG(estimated_delivery_days) AS avg_estimated_delivery_days

FROM delivery_analysis

GROUP BY
    delivery_status

ORDER BY
    avg_review_score DESC;