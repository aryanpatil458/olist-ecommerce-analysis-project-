-- olist_products Table 
-- Row count
SELECT COUNT(*) AS total_rows
FROM olist_products;

-- NULL check
SELECT
    COUNT(*) FILTER (WHERE product_id IS NULL) AS null_product_id,
    COUNT(*) FILTER (WHERE product_category_name IS NULL) AS null_category,
    COUNT(*) FILTER (WHERE product_weight_g IS NULL) AS null_weight,
    COUNT(*) FILTER (WHERE product_length_cm IS NULL) AS null_length,
    COUNT(*) FILTER (WHERE product_height_cm IS NULL) AS null_height,
    COUNT(*) FILTER (WHERE product_width_cm IS NULL) AS null_width
FROM olist_products;

-- Duplicate product IDs
SELECT product_id, COUNT(*)
FROM olist_products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Category distribution
SELECT product_category_name, COUNT(*)
FROM olist_products
GROUP BY product_category_name
ORDER BY COUNT(*) DESC;

-- Negative weight
SELECT *
FROM olist_products
WHERE product_weight_g < 0;

-- Negative dimensions
SELECT *
FROM olist_products
WHERE product_length_cm < 0
   OR product_height_cm < 0
   OR product_width_cm < 0;

-- Negative photo count
SELECT *
FROM olist_products
WHERE product_photos_qty < 0;

-- Invalid name/description lengths
SELECT *
FROM olist_products
WHERE product_name_lenght < 0
   OR product_description_lenght < 0;
