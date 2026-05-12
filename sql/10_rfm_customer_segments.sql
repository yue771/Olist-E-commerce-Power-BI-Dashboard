USE olist_ecommerce;

-- RFM 用户分层

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
),

rfm_segments AS (

    SELECT
        *,
        CASE
            WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'High-value Customers'
            WHEN r_score >= 4 AND f_score <= 3 AND m_score >= 4 THEN 'Potential High-value Customers'
            WHEN r_score <= 2 AND f_score >= 4 AND m_score >= 4 THEN 'At-risk High-value Customers'
            WHEN r_score <= 2 AND f_score <= 2 THEN 'Inactive Customers'
            ELSE 'Regular Customers'
        END AS customer_segment

    FROM rfm_scores
)

SELECT
    customer_segment,
    COUNT(*) AS customer_count,
    AVG(frequency) AS avg_frequency,
    AVG(monetary) AS avg_monetary,
    SUM(monetary) AS total_monetary

FROM rfm_segments

GROUP BY
    customer_segment

ORDER BY
    total_monetary DESC;