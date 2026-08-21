-- customer lifetime value analysis 
-- What is the lifetime value of each customer?
SELECT
    c.customer_unique_id,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS customer_lifetime_value
FROM olist_orders o
JOIN olist_customers c
    ON o.customer_id = c.customer_id
JOIN olist_order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
ORDER BY customer_lifetime_value DESC;

-- What is the average customer lifetime value?
WITH customer_clv AS (
    SELECT
        c.customer_unique_id,
        SUM(oi.price + oi.freight_value) AS clv
    FROM olist_orders o
    JOIN olist_customers c
        ON o.customer_id = c.customer_id
    JOIN olist_order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)

SELECT
    ROUND(AVG(clv), 2) AS average_clv,
    ROUND(MIN(clv), 2) AS minimum_clv,
    ROUND(MAX(clv), 2) AS maximum_clv,
    ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY clv), 2) AS median_clv
FROM customer_clv;

-- Which customers have the highest lifetime value?
SELECT
    c.customer_unique_id,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS lifetime_value
FROM olist_orders o
JOIN olist_customers c
    ON o.customer_id = c.customer_id
JOIN olist_order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
ORDER BY lifetime_value DESC
LIMIT 20;

