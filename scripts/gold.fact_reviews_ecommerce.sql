IF OBJECT_ID('gold.fact_reviews', 'U') IS NOT NULL
    DROP TABLE gold.fact_reviews;

SELECT
    review_id,
    user_id,
    product_id,
    order_id,
    rating,
    review_text,
    review_date
INTO gold.fact_reviews
FROM silver.reviews;