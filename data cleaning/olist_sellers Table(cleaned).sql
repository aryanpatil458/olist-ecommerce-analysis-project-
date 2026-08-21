-- olist_sellers Table
-- Row count
SELECT COUNT(*) AS total_rows
FROM olist_sellers;

-- NULL check
SELECT
    COUNT(*) FILTER (WHERE seller_id IS NULL) AS null_seller_id,
    COUNT(*) FILTER (WHERE seller_zip_code_prefix IS NULL) AS null_zip,
    COUNT(*) FILTER (WHERE seller_city IS NULL) AS null_city,
    COUNT(*) FILTER (WHERE seller_state IS NULL) AS null_state
FROM olist_sellers;

-- Duplicate seller IDs
SELECT seller_id, COUNT(*)
FROM olist_sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;

-- State distribution
SELECT seller_state, COUNT(*)
FROM olist_sellers
GROUP BY seller_state
ORDER BY COUNT(*) DESC;

-- Empty cities
SELECT *
FROM olist_sellers
WHERE seller_city IS NULL
   OR TRIM(seller_city) = '';

-- Invalid ZIP
SELECT *
FROM olist_sellers
WHERE seller_zip_code_prefix < 0;
