--STRUCTURE CHECKS
--NULL CHECKS
--primary key
SELECT *
FROM silver.users
WHERE user_id IS NULL;

--foreign key 
--Orders without users
SELECT *
FROM silver.orders
WHERE user_id IS NULL;
--Order items without order or product
SELECT *
FROM silver.order_items
WHERE order_id IS NULL
   OR product_id IS NULL;

--users
SELECT *
FROM silver.users
WHERE user_id IS NULL
   OR email IS NULL;

--orders
SELECT *
FROM silver.orders
WHERE order_id IS NULL
OR user_id IS NULL;

--products
SELECT *
FROM silver.products
WHERE product_id IS NULL;

--Business checks
--Users
SELECT *
FROM silver.users
WHERE email IS NULL
   OR name IS NULL;
--Orders
SELECT *
FROM silver.orders
WHERE order_date IS NULL
   OR total_amount IS NULL;
--Products
SELECT *
FROM silver.products
WHERE product_name IS NULL
   OR price IS NULL;
--Reviews
SELECT *
FROM silver.reviews
WHERE rating IS NULL;

--conditional null cheks
SELECT *
FROM silver.reviews
WHERE rating IS NOT NULL
  AND review_text IS NULL;

--event tracking null cheks
SELECT *
FROM silver.events
WHERE event_type IS NULL
   OR event_timestamp IS NULL;

SELECT 'users' AS table_name,
       COUNT(*) AS total_rows,
       SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS null_user_id,
       SUM(CASE WHEN email IS NULL THEN 1 ELSE 0 END) AS null_email
FROM silver.users;


-- Duplicate Check
--USERS 
--Primary key: user_id
SELECT user_id, COUNT(*) AS cnt
FROM silver.users
GROUP BY user_id
HAVING COUNT(*) > 1;
-- ORDERS — Duplicate Check
--Primary key: order_id
SELECT order_id, COUNT(*) AS cnt
FROM silver.orders
GROUP BY order_id
HAVING COUNT(*) > 1;
--ORDER ITEMS — Duplicate Check
--Primary key: order_item_id
SELECT order_item_id, COUNT(*) AS cnt
FROM silver.order_items
GROUP BY order_item_id
HAVING COUNT(*) > 1;
--PRODUCTS — Duplicate Check
--Primary key: product_id
SELECT product_id, COUNT(*) AS cnt
FROM silver.products
GROUP BY product_id
HAVING COUNT(*) > 1;
-- REVIEWS — Duplicate Check
--Primary key: review_id
SELECT review_id, COUNT(*) AS cnt
FROM silver.reviews
GROUP BY review_id
HAVING COUNT(*) > 1;
--EVENTS — Duplicate Check
--Primary key: event_id
SELECT event_id, COUNT(*) AS cnt
FROM silver.events
GROUP BY event_id
HAVING COUNT(*) > 1;

-- Duplicate orders (same user + same time)
SELECT user_id, order_date, COUNT(*) AS cnt
FROM silver.orders
GROUP BY user_id, order_date
HAVING COUNT(*) > 1;
--Duplicate order items (same order + product)
SELECT order_id, product_id, COUNT(*) AS cnt
FROM silver.order_items
GROUP BY order_id, product_id
HAVING COUNT(*) > 1;
--Duplicate reviews (same user + product)
SELECT user_id, product_id, COUNT(*) AS cnt
FROM silver.reviews
GROUP BY user_id, product_id
HAVING COUNT(*) > 1;


--Business Rules checks
-- USERS TABLE 
--gender  should be valid values
SELECT DISTINCT gender
FROM silver.users;

--Email format basic validation (must contain @)
SELECT *
FROM silver.users
WHERE email NOT LIKE '%@%';
--Name should not be empty
SELECT *
FROM silver.users
WHERE name IS NULL OR LTRIM(RTRIM(name)) = '';
-- ORDERS TABLE 
--Total amount should never be negative
SELECT *
FROM silver.orders
WHERE total_amount < 0;
--Order date should not be in future
SELECT *
FROM silver.orders
WHERE order_date > GETDATE();
--Order date should not be NULL
SELECT *
FROM silver.orders
WHERE order_date IS NULL;
--Order status validation
SELECT DISTINCT order_status
FROM silver.orders;
--ORDER ITEMS 
--Quantity must be > 0
SELECT *
FROM silver.order_items
WHERE quantity <= 0;
--Item price must be positive
SELECT *
FROM silver.order_items
WHERE item_price <= 0;
--Item total must match logic (quantity × price)
SELECT *
FROM silver.order_items
WHERE item_total <> quantity * item_price;


--PRODUCTS TABLE 
--Price must be positive
SELECT *
FROM silver.products
WHERE price <= 0;
--Rating must be between 1 and 5
SELECT *
FROM silver.products
WHERE rating < 1 OR rating > 5;
--Product name should not be NULL
SELECT *
FROM silver.products
WHERE product_name IS NULL;
--REVIEWS TABLE 
--Rating range validation
SELECT *
FROM silver.reviews
WHERE rating < 1 OR rating > 5;
--Review text optional but rating required
SELECT *
FROM silver.reviews
WHERE rating IS NULL;
--Logical rule: review should relate to valid order/product
SELECT r.*
FROM silver.reviews r
LEFT JOIN silver.orders o
ON r.order_id = o.order_id
WHERE o.order_id IS NULL;
--EVENTS TABLE 
--Event type should not be NULL
SELECT *
FROM silver.events
WHERE event_type IS NULL;
--Timestamp must be valid
SELECT *
FROM silver.events
WHERE event_timestamp IS NULL;
--Event type validation (basic expected values)
SELECT DISTINCT event_type
FROM silver.events;
--CROSS-TABLE BUSINESS RULES 
--Orders must belong to valid users
SELECT o.*
FROM silver.orders o
LEFT JOIN silver.users u
ON o.user_id = u.user_id
WHERE u.user_id IS NULL;
--Order items must belong to valid orders + products
SELECT oi.*
FROM silver.order_items oi
LEFT JOIN silver.orders o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;
SELECT oi.*
FROM silver.order_items oi
LEFT JOIN silver.products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;
--Reviews must be linked correctly
SELECT r.*
FROM silver.reviews r
LEFT JOIN silver.products p
ON r.product_id = p.product_id
WHERE p.product_id IS NULL;


--REFERENTIAL CHECKS
SELECT o.*
FROM silver.orders o
LEFT JOIN silver.users u
ON o.user_id = u.user_id
WHERE u.user_id IS NULL;


--DATA VALIDATION CHECKS
SELECT *
FROM silver.products
WHERE price < 0;


--DATA VALIDATION PROOF

SELECT 'users' AS table_name, COUNT(*) AS total_rows FROM silver.users
UNION ALL
SELECT 'orders', COUNT(*) FROM silver.orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM silver.order_items
UNION ALL
SELECT 'products', COUNT(*) FROM silver.products
UNION ALL
SELECT 'reviews', COUNT(*) FROM silver.reviews
UNION ALL
SELECT 'events', COUNT(*) FROM silver.events;