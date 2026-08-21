-- Retention Analysis 
-- What percentage of customers are repeat customers?
WITH customer_orders AS (
    SELECT
        customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM olist_orders o
    JOIN olist_customers c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY customer_unique_id
)


SELECT
    COUNT(*) FILTER (WHERE order_count = 1) AS one_time_customers,
    COUNT(*) FILTER (WHERE order_count > 1) AS repeat_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE order_count > 1)
        / COUNT(*),
        2
    ) AS repeat_customer_rate
FROM customer_orders;

-- How many purchases does the average customer make?
SELECT
    ROUND(
        COUNT(DISTINCT o.order_id)::numeric
        / COUNT(DISTINCT c.customer_unique_id),
        2
    ) AS avg_orders_per_customer
FROM olist_orders o
JOIN olist_customers c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered';

-- How many customers return and purchase again?
SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT
        c.customer_unique_id
    FROM olist_orders o
    JOIN olist_customers c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
    HAVING COUNT(DISTINCT o.order_id) > 1
) x;

-- What is the monthly retention rate?

WITH monthly_customers AS (
    SELECT DISTINCT
        c.customer_unique_id,
        DATE_TRUNC('month', o.order_purchase_timestamp) AS month
    FROM olist_orders o
    JOIN olist_customers c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
),
retention AS (
    SELECT
        a.month,
        COUNT(DISTINCT a.customer_unique_id) AS customers,
        COUNT(DISTINCT b.customer_unique_id) AS retained_customers
    FROM monthly_customers a
    LEFT JOIN monthly_customers b
        ON a.customer_unique_id = b.customer_unique_id
        AND b.month = a.month + INTERVAL '1 month'
    GROUP BY a.month
)
SELECT
    month,
    customers,
    retained_customers,
    ROUND(
        100.0 * retained_customers / NULLIF(customers, 0),
        2
    ) AS retention_rate
FROM retention
ORDER BY month;

