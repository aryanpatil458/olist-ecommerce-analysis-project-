-- Trend / Time-Series Analysis
-- How is monthly revenue changing over time?
SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS revenue
FROM olist_orders o
JOIN olist_order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY 1;

-- How is the number of orders changing over time?
SELECT
    DATE_TRUNC('month', order_purchase_timestamp) AS month,
    COUNT(DISTINCT order_id) AS total_orders
FROM olist_orders
WHERE order_status = 'delivered'
GROUP BY 1
ORDER BY 1;

-- Which months generate the highest revenue?
SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS revenue
FROM olist_orders o
JOIN olist_order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY revenue DESC;

-- How does Average Order Value change over time?
SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    ROUND(
        SUM(oi.price + oi.freight_value) / COUNT(DISTINCT o.order_id),
        2
    ) AS avg_order_value
FROM olist_orders o
JOIN olist_order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY 1;
