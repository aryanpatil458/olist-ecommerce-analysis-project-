drop table if exists olist_customers;
CREATE TABLE olist_customers (
    customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INTEGER,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

drop table if exists olist_geolocation;
CREATE TABLE olist_geolocation (
    geolocation_zip_code_prefix INTEGER,
    geolocation_lat NUMERIC(10,6),
    geolocation_lng NUMERIC(10,6),
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(10)
);

drop table if exists olist_order_items;
CREATE TABLE olist_order_items (
    order_id VARCHAR(50),
    order_item_id INTEGER,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price NUMERIC(10,2),
    freight_value NUMERIC(10,2)
);

drop table if exists olist_order_payments;
CREATE TABLE olist_order_payments (
    order_id VARCHAR(50),
    payment_sequential INTEGER,
    payment_type VARCHAR(30),
    payment_installments INTEGER,
    payment_value NUMERIC(10,2)
);

drop table if exists olist_order_reviews;
CREATE TABLE olist_order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INTEGER,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

drop table if exists olist_orders;
CREATE TABLE olist_orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(30),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

drop table if exists olist_products;
CREATE TABLE olist_products (
    product_id VARCHAR(50),
    product_category_name VARCHAR(100),
    product_name_lenght INTEGER,
    product_description_lenght INTEGER,
    product_photos_qty INTEGER,
    product_weight_g INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER
);

drop table if exists olist_sellers;
CREATE TABLE olist_sellers (
    seller_id VARCHAR(50),
    seller_zip_code_prefix INTEGER,
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);

drop table if exists product_category_name_translation;
CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR(100),
    product_category_name_english VARCHAR(100)
);