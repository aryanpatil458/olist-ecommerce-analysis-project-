-- olist_order_payments Table 
-- Row count
SELECT COUNT(*) AS total_rows
FROM olist_order_payments;

-- NULL check
SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL) AS null_order_id,
    COUNT(*) FILTER (WHERE payment_sequential IS NULL) AS null_sequence,
    COUNT(*) FILTER (WHERE payment_type IS NULL) AS null_payment_type,
    COUNT(*) FILTER (WHERE payment_installments IS NULL) AS null_installments,
    COUNT(*) FILTER (WHERE payment_value IS NULL) AS null_payment_value
FROM olist_order_payments;

-- Composite-key duplicates
SELECT
    order_id,
    payment_sequential,
    COUNT(*)
FROM olist_order_payments
GROUP BY order_id, payment_sequential
HAVING COUNT(*) > 1;

-- Payment types
SELECT payment_type, COUNT(*)
FROM olist_order_payments
GROUP BY payment_type
ORDER BY COUNT(*) DESC;

-- Invalid payment values
SELECT *
FROM olist_order_payments
WHERE payment_value < 0;

-- Invalid installments
SELECT *
FROM olist_order_payments
WHERE payment_installments < 0;

-- Payment statistics
SELECT
    MIN(payment_value),
    MAX(payment_value),
    AVG(payment_value)
FROM olist_order_payments;
