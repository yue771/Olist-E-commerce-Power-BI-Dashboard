USE olist_ecommerce;

-- RFM 用户评分

WITH rfm_base AS (

    SELECT

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
),

rfm_scores AS (

    SELECT

        *,

        NTILE(5) OVER (ORDER BY last_purchase_date DESC) AS r_score,

        NTILE(5) OVER (ORDER BY frequency DESC) AS f_score,

        NTILE(5) OVER (ORDER BY monetary DESC) AS m_score

    FROM rfm_base
)

SELECT TOP 50 *

FROM rfm_scores

ORDER BY
    m_score DESC,
    f_score DESC;