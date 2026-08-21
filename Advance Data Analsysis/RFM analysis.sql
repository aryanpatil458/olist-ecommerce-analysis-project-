RFM analysis
-- Who are the most valuable customers based on Recency, Frequency and Monetary value?
WITH customer_rfm AS (
    SELECT
        c.customer_unique_id,

        MAX(o.order_purchase_timestamp::date) AS last_purchase,

        COUNT(DISTINCT o.order_id) AS frequency,

        ROUND(SUM(oi.price + oi.freight_value), 2) AS monetary

    FROM olist_orders o
    JOIN olist_customers c
        ON o.customer_id = c.customer_id
    JOIN olist_order_items oi
        ON o.order_id = oi.order_id

    WHERE o.order_status = 'delivered'

    GROUP BY c.customer_unique_id
),

rfm AS (
    SELECT
        *,
        CURRENT_DATE - last_purchase AS recency
    FROM customer_rfm
)

SELECT
    *,
    NTILE(5) OVER (ORDER BY recency DESC) AS recency_score,
    NTILE(5) OVER (ORDER BY frequency) AS frequency_score,
    NTILE(5) OVER (ORDER BY monetary) AS monetary_score
FROM rfm;

-- What are the different customer segments?
WITH customer_rfm AS (
    SELECT
        c.customer_unique_id,
        MAX(o.order_purchase_timestamp::date) AS last_purchase,
        COUNT(DISTINCT o.order_id) AS frequency,
        SUM(oi.price + oi.freight_value) AS monetary
    FROM olist_orders o
    JOIN olist_customers c
        ON o.customer_id = c.customer_id
    JOIN olist_order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),

rfm_scores AS (
    SELECT
        *,
        NTILE(5) OVER (ORDER BY last_purchase DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency) AS f_score,
        NTILE(5) OVER (ORDER BY monetary) AS m_score
    FROM customer_rfm
)

SELECT
    *,
    CASE
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4
            THEN 'Champions'
        WHEN f_score >= 4
            THEN 'Loyal Customers'
        WHEN m_score >= 4
            THEN 'Big Spenders'
        WHEN r_score >= 4
            THEN 'Recent Customers'
        WHEN r_score <= 2 AND f_score >= 3
            THEN 'At Risk'
        ELSE 'Lost Customers'
    END AS customer_segment
FROM rfm_scores;

