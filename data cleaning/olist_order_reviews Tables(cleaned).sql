-- olist_order_reviews Tables 
-- Row count
SELECT COUNT(*) AS total_rows
FROM olist_order_reviews;

-- NULL check
SELECT
    COUNT(*) FILTER (WHERE review_id IS NULL) AS null_review_id,
    COUNT(*) FILTER (WHERE order_id IS NULL) AS null_order_id,
    COUNT(*) FILTER (WHERE review_score IS NULL) AS null_score,
    COUNT(*) FILTER (WHERE review_creation_date IS NULL) AS null_creation_date,
    COUNT(*) FILTER (WHERE review_answer_timestamp IS NULL) AS null_answer_date
FROM olist_order_reviews;

-- Duplicate review IDs
SELECT review_id, COUNT(*)
FROM olist_order_reviews
GROUP BY review_id
HAVING COUNT(*) > 1;

-- Review score distribution
SELECT review_score, COUNT(*)
FROM olist_order_reviews
GROUP BY review_score
ORDER BY review_score;

-- Invalid review scores
SELECT *
FROM olist_order_reviews
WHERE review_score NOT BETWEEN 1 AND 5;

-- Empty review titles
SELECT COUNT(*)
FROM olist_order_reviews
WHERE review_comment_title IS NULL
   OR TRIM(review_comment_title) = '';

-- Empty review messages
SELECT COUNT(*)
FROM olist_order_reviews
WHERE review_comment_message IS NULL
   OR TRIM(review_comment_message) = '';

-- Review date problems
SELECT *
FROM olist_order_reviews
WHERE review_answer_timestamp < review_creation_date;
