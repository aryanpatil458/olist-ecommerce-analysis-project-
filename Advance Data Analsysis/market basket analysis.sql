-- market basket analysis 
-- Which product categories are purchased together?
SELECT
    p1.product_category_name AS category_1,
    p2.product_category_name AS category_2,
    COUNT(DISTINCT oi1.order_id) AS orders_together
FROM olist_order_items oi1
JOIN olist_order_items oi2
    ON oi1.order_id = oi2.order_id
    AND oi1.product_id < oi2.product_id

JOIN olist_products p1
    ON oi1.product_id = p1.product_id

JOIN olist_products p2
    ON oi2.product_id = p2.product_id

WHERE p1.product_category_name IS NOT NULL
  AND p2.product_category_name IS NOT NULL

GROUP BY
    p1.product_category_name,
    p2.product_category_name

ORDER BY orders_together DESC
LIMIT 20;

-- Which product category pairs have the highest association?
WITH category_orders AS (
    SELECT DISTINCT
        oi.order_id,
        p.product_category_name
    FROM olist_order_items oi
    JOIN olist_products p
        ON oi.product_id = p.product_id
    WHERE p.product_category_name IS NOT NULL
),

total_orders AS (
    SELECT COUNT(DISTINCT order_id) AS total
    FROM category_orders
),

pairs AS (
    SELECT
        a.product_category_name AS category_1,
        b.product_category_name AS category_2,
        COUNT(DISTINCT a.order_id) AS pair_orders
    FROM category_orders a
    JOIN category_orders b
        ON a.order_id = b.order_id
       AND a.product_category_name < b.product_category_name
    GROUP BY 1, 2
),

category_counts AS (
    SELECT
        product_category_name,
        COUNT(DISTINCT order_id) AS category_orders
    FROM category_orders
    GROUP BY 1
)

SELECT
    p.category_1,
    p.category_2,
    p.pair_orders,

    ROUND(
        p.pair_orders::numeric / t.total,
        4
    ) AS support,

    ROUND(
        p.pair_orders::numeric / c1.category_orders,
        4
    ) AS confidence,

    ROUND(
        (p.pair_orders::numeric / c1.category_orders)
        /
        (c2.category_orders::numeric / t.total),
        2
    ) AS lift

FROM pairs p

CROSS JOIN total_orders t

JOIN category_counts c1
    ON p.category_1 = c1.product_category_name

JOIN category_counts c2
    ON p.category_2 = c2.product_category_name

WHERE p.pair_orders >= 20

ORDER BY lift DESC
LIMIT 20;