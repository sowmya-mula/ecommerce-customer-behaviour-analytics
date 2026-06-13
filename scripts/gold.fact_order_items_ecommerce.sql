IF OBJECT_ID('gold.fact_order_items', 'U') IS NOT NULL
    DROP TABLE gold.fact_order_items;

SELECT
    order_item_id,
    order_id,
    product_id,
    user_id,
    quantity,
    item_price,
    item_total
INTO gold.fact_order_items
FROM silver.order_items;