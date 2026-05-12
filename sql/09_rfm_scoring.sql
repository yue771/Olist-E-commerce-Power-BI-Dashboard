USE olist_ecommerce;

-- RFM 用户评分：分数越高，用户价值越高

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

        NTILE(5) OVER (ORDER BY last_purchase_date ASC) AS r_score,

        NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,

        NTILE(5) OVER (ORDER BY monetary ASC) AS m_score

    FROM rfm_base
)

SELECT TOP 50 *

FROM rfm_scores

ORDER BY
    m_score DESC,
    f_score DESC,
    r_score DESC;