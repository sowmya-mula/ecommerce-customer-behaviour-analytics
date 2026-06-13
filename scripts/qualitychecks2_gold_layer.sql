--Null checks (Gold layer)
--Orders
SELECT *
FROM gold.fact_orders
WHERE order_id IS NULL
   OR user_id IS NULL
   OR total_amount IS NULL;

--Order Items
SELECT *
FROM gold.fact_order_items
WHERE order_id IS NULL
   OR product_id IS NULL
   OR quantity IS NULL
   OR item_total IS NULL;
--Reviews
SELECT *
FROM gold.fact_reviews
WHERE review_id IS NULL
   OR rating IS NULL;
--Referential integrity checks
--Orders → Users
SELECT f.*
FROM gold.fact_orders f
LEFT JOIN gold.dim_users u
ON f.user_id = u.user_id
WHERE u.user_id IS NULL;
--Order Items → Products
SELECT f.*
FROM gold.fact_order_items f
LEFT JOIN gold.dim_products p
ON f.product_id = p.product_id
WHERE p.product_id IS NULL;
--Reviews → Products
SELECT r.*
FROM gold.fact_reviews r
LEFT JOIN gold.dim_products p
ON r.product_id = p.product_id
WHERE p.product_id IS NULL;
--Business sanity checks
--Negative revenue check
SELECT *
FROM gold.fact_orders
WHERE total_amount < 0;
--Invalid ratings
SELECT *
FROM gold.fact_reviews
WHERE rating < 1 OR rating > 5;
--Duplicate check in Gold
SELECT order_id, COUNT(*) AS cnt
FROM gold.fact_orders
GROUP BY order_id
HAVING COUNT(*) > 1;