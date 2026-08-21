-- olist_order_items Table
-- Row count
SELECT COUNT(*) AS total_rows
FROM olist_order_items;

-- NULL check
SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL) AS null_order_id,
    COUNT(*) FILTER (WHERE order_item_id IS NULL) AS null_item_id,
    COUNT(*) FILTER (WHERE product_id IS NULL) AS null_product_id,
    COUNT(*) FILTER (WHERE seller_id IS NULL) AS null_seller_id,
    COUNT(*) FILTER (WHERE shipping_limit_date IS NULL) AS null_shipping_date,
    COUNT(*) FILTER (WHERE price IS NULL) AS null_price,
    COUNT(*) FILTER (WHERE freight_value IS NULL) AS null_freight
FROM olist_order_items;

-- Check composite-key duplicates
SELECT
    order_id,
    order_item_id,
    COUNT(*)
FROM olist_order_items
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;

-- Negative prices
SELECT *
FROM olist_order_items
WHERE price < 0;

-- Negative freight
SELECT *
FROM olist_order_items
WHERE freight_value < 0;

-- Zero prices
SELECT *
FROM olist_order_items
WHERE price = 0;

-- Zero freight
SELECT *
FROM olist_order_items
WHERE freight_value = 0;

-- Price statistics
SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(price) AS avg_price
FROM olist_order_items;

-- Freight statistics
SELECT
    MIN(freight_value) AS min_freight,
    MAX(freight_value) AS max_freight,
    AVG(freight_value) AS avg_freight
FROM olist_order_items;