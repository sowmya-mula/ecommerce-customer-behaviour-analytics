IF OBJECT_ID('gold.dim_products', 'U') IS NOT NULL
    DROP TABLE gold.dim_products;

SELECT
    product_id,
    product_name,
    category,
    brand,
    price,
    rating
INTO gold.dim_products
FROM silver.products;