-- olist_orders Table 
-- Row count
SELECT COUNT(*) AS total_rows
FROM olist_orders;

-- NULL check
SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL) AS null_order_id,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS null_customer_id,
    COUNT(*) FILTER (WHERE order_status IS NULL) AS null_status,
    COUNT(*) FILTER (WHERE order_purchase_timestamp IS NULL) AS null_purchase_date,
    COUNT(*) FILTER (WHERE order_approved_at IS NULL) AS null_approved_date,
    COUNT(*) FILTER (WHERE order_delivered_carrier_date IS NULL) AS null_carrier_date,
    COUNT(*) FILTER (WHERE order_delivered_customer_date IS NULL) AS null_delivery_date,
    COUNT(*) FILTER (WHERE order_estimated_delivery_date IS NULL) AS null_estimated_date
FROM olist_orders;

-- Duplicate order IDs
SELECT order_id, COUNT(*)
FROM olist_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Order status distribution
SELECT order_status, COUNT(*)
FROM olist_orders
GROUP BY order_status
ORDER BY COUNT(*) DESC;

-- Empty status
SELECT *
FROM olist_orders
WHERE order_status IS NULL
   OR TRIM(order_status) = '';

-- Check invalid date sequence
SELECT *
FROM olist_orders
WHERE order_approved_at < order_purchase_timestamp;

-- Delivered before purchase
SELECT *
FROM olist_orders
WHERE order_delivered_customer_date < order_purchase_timestamp;

-- Carrier delivery before purchase
SELECT *
FROM olist_orders
WHERE order_delivered_carrier_date < order_purchase_timestamp;

-- Actual delivery after estimated delivery
SELECT *
FROM olist_orders
WHERE order_delivered_customer_date > order_estimated_delivery_date;

-- Date range
SELECT
    MIN(order_purchase_timestamp) AS earliest_order,
    MAX(order_purchase_timestamp) AS latest_order
FROM olist_orders;