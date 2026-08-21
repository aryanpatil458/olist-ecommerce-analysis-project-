-- olist_customers Table 
-- Row count
SELECT COUNT(*) AS total_rows
FROM olist_customers;

-- NULLs check : NO NULLS PRESENT 
SELECT
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS null_customer_id,
    COUNT(*) FILTER (WHERE customer_unique_id IS NULL) AS null_customer_unique_id,
    COUNT(*) FILTER (WHERE customer_zip_code_prefix IS NULL) AS null_zip,
    COUNT(*) FILTER (WHERE customer_city IS NULL) AS null_city,
    COUNT(*) FILTER (WHERE customer_state IS NULL) AS null_state
FROM olist_customers;

-- Duplicate customer_ids : NO DUPLICATE IDs
SELECT customer_id, COUNT(*)
FROM olist_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Duplicate customer_unique_ids
SELECT customer_unique_id, COUNT(*)
FROM olist_customers
GROUP BY customer_unique_id
HAVING COUNT(*) > 1;

-- Check states
SELECT customer_state, COUNT(*)
FROM olist_customers
GROUP BY customer_state
ORDER BY COUNT(*) DESC;

-- Check empty/whitespace cities : NO EMPTY/WHITESPACES 
SELECT *
FROM olist_customers
WHERE customer_city IS NULL
   OR TRIM(customer_city) = '';

-- Check ZIP codes : ALL CHECKED 
SELECT *
FROM olist_customers
WHERE customer_zip_code_prefix < 0;

-- not much of data cleaning needed 
