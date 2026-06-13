IF OBJECT_ID('gold.fact_orders', 'U') IS NOT NULL
    DROP TABLE gold.fact_orders;

SELECT
    order_id,
    user_id,
    order_date,
    order_status,
    total_amount
INTO gold.fact_orders
FROM silver.orders;