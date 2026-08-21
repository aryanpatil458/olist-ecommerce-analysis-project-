-- addng primary keys 
ALTER TABLE olist_customers
ADD PRIMARY KEY (customer_id);

ALTER TABLE olist_orders
ADD PRIMARY KEY (order_id);

ALTER TABLE olist_products
ADD PRIMARY KEY (product_id);

ALTER TABLE olist_sellers
ADD PRIMARY KEY (seller_id);

ALTER TABLE olist_order_items
ADD PRIMARY KEY (order_id, order_item_id);

ALTER TABLE olist_order_payments
ADD PRIMARY KEY (order_id, payment_sequential);

ALTER TABLE product_category_name_translation
ADD PRIMARY KEY (product_category_name);

-- adding foreign keys 

ALTER TABLE olist_orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id)
REFERENCES olist_customers(customer_id);

ALTER TABLE olist_order_items
ADD CONSTRAINT fk_items_order
FOREIGN KEY (order_id)
REFERENCES olist_orders(order_id);

ALTER TABLE olist_order_items
ADD CONSTRAINT fk_items_product
FOREIGN KEY (product_id)
REFERENCES olist_products(product_id);

ALTER TABLE olist_order_items
ADD CONSTRAINT fk_items_seller
FOREIGN KEY (seller_id)
REFERENCES olist_sellers(seller_id);

ALTER TABLE olist_order_payments
ADD CONSTRAINT fk_payments_order
FOREIGN KEY (order_id)
REFERENCES olist_orders(order_id);

ALTER TABLE olist_order_reviews
ADD CONSTRAINT fk_reviews_order
FOREIGN KEY (order_id)
REFERENCES olist_orders(order_id);