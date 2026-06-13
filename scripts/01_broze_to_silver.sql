/*===============================================================================
SILVER LAYER – DATA CLEANING & TRANSFORMATION
=============================================

Project     : E-Commerce Customer Behaviour Analytics
Layer       : Silver
Purpose     : Transform raw bronze data into cleaned and standardized tables
for analytical modeling and reporting.

Operations Performed:
✓ Trim leading/trailing spaces
✓ Standardize text formatting
✓ Convert data types
✓ Normalize values
✓ Prepare structured datasets

Tables Processed:
├── silver.users
├── silver.orders
├── silver.order_items
├── silver.products
├── silver.reviews
└── silver.events

Source Layer : bronze
Target Layer : silver

=================================================================================*/


/*===============================================================================
LOAD : SILVER.USERS
================================================================================*/

DROP TABLE IF EXISTS silver.users;
SELECT
    user_id,
    TRIM(name) AS name,
    LOWER(email) AS email,
    gender,
    city,
    CAST(signup_date AS DATE) AS signup_date
INTO silver.users
FROM bronze.users 


/*===============================================================================
LOAD : SILVER.ORDERS
================================================================================*/

DROP TABLE IF EXISTS silver.orders;
SELECT
    order_id,
    user_id,
    TRY_CONVERT(DATETIME2, order_date) AS order_date,
    LOWER(order_status) AS order_status,
    CAST(total_amount AS DECIMAL(10,2)) AS total_amount
INTO silver.orders
FROM bronze.orders;



/*===============================================================================
LOAD : SILVER.ORDER_ITEMS
================================================================================*/

DROP TABLE IF EXISTS silver.order_items;
SELECT
    order_item_id,
    order_id,
    product_id,
    user_id,
    CAST(quantity AS INT) AS quantity,
    CAST(item_price AS DECIMAL(10,2)) AS item_price,
    CAST(item_total AS DECIMAL(10,2)) AS item_total
INTO silver.order_items
FROM bronze.order_items;



/*===============================================================================
LOAD : SILVER.PRODUCTS
================================================================================*/
DROP TABLE IF EXISTS silver.products;
SELECT
    product_id,
    TRIM(product_name) AS product_name,
    category,
    brand,
    CAST(price AS DECIMAL(10,2)) AS price,
    CAST(rating AS DECIMAL(3,2)) AS rating
INTO silver.products
FROM bronze.products;



/*===============================================================================
LOAD : SILVER.REVIEWS
================================================================================*/
DROP TABLE IF EXISTS silver.reviews;
SELECT
    review_id,
    order_id,
    product_id,
    user_id,
    CAST(rating AS INT) AS rating,
    TRIM(review_text) AS review_text,
    CAST(review_date AS DATE) AS review_date
INTO silver.reviews
FROM bronze.reviews;



/*===============================================================================
LOAD : SILVER.EVENTS
================================================================================*/
DROP TABLE IF EXISTS silver.events;
SELECT
    event_id,
    user_id,
    product_id,
    LOWER(event_type) AS event_type,
    CAST(event_timestamp AS DATETIME2) AS event_timestamp
INTO silver.events
FROM bronze.events;












