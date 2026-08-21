-- product_category_name_translation Table
-- Row count
SELECT COUNT(*) AS total_rows
FROM product_category_name_translation;

-- NULL check
SELECT
    COUNT(*) FILTER (WHERE product_category_name IS NULL)
        AS null_portuguese_category,
    COUNT(*) FILTER (WHERE product_category_name_english IS NULL)
        AS null_english_category
FROM product_category_name_translation;

-- Duplicate categories
SELECT product_category_name, COUNT(*)
FROM product_category_name_translation
GROUP BY product_category_name
HAVING COUNT(*) > 1;

-- Empty category names
SELECT *
FROM product_category_name_translation
WHERE TRIM(product_category_name) = ''
   OR TRIM(product_category_name_english) = '';
