-- olist_geolocation 
-- Row count
SELECT COUNT(*) AS total_rows
FROM olist_geolocation;

-- NULL check
SELECT
    COUNT(*) FILTER (WHERE geolocation_zip_code_prefix IS NULL) AS null_zip,
    COUNT(*) FILTER (WHERE geolocation_lat IS NULL) AS null_lat,
    COUNT(*) FILTER (WHERE geolocation_lng IS NULL) AS null_lng,
    COUNT(*) FILTER (WHERE geolocation_city IS NULL) AS null_city,
    COUNT(*) FILTER (WHERE geolocation_state IS NULL) AS null_state
FROM olist_geolocation;

-- Duplicate ZIP prefixes
SELECT
    geolocation_zip_code_prefix,
    COUNT(*)
FROM olist_geolocation
GROUP BY geolocation_zip_code_prefix
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

-- Latitude range
SELECT *
FROM olist_geolocation
WHERE geolocation_lat NOT BETWEEN -90 AND 90;

-- Longitude range
SELECT *
FROM olist_geolocation
WHERE geolocation_lng NOT BETWEEN -180 AND 180;

-- Invalid ZIP
SELECT *
FROM olist_geolocation
WHERE geolocation_zip_code_prefix < 0;