-- TOTAL REVENUE
SELECT 
    SUM(total_amount) AS total_revenue
FROM gold.fact_orders;
--TOTAL ORDERS
SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM gold.fact_orders;
--TOTAL CUSTOMERS (ACTIVE USERS)
SELECT 
    COUNT(DISTINCT user_id) AS total_customers
FROM gold.fact_orders;
--AVERAGE ORDER VALUE (AOV)
SELECT 
    SUM(total_amount) * 1.0 / COUNT(DISTINCT order_id) AS avg_order_value
FROM gold.fact_orders;
--AVERAGE PRODUCT RATING
SELECT 
    AVG(rating) AS avg_rating
FROM gold.fact_reviews;


--REVENUE ANALYTICS
--Revenue by Order Status
SELECT 
    order_status,
    SUM(total_amount) AS revenue
FROM gold.fact_orders
GROUP BY order_status;
--Daily Revenue Trend
SELECT 
    CAST(order_date AS DATE) AS order_day,
    SUM(total_amount) AS revenue
FROM gold.fact_orders
GROUP BY CAST(order_date AS DATE)
ORDER BY order_day;
--Monthly Revenue Trend
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(total_amount) AS revenue
FROM gold.fact_orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

--CUSTOMER ANALYTICS
--Revenue per Customer
SELECT 
    user_id,
    SUM(total_amount) AS total_spent
FROM gold.fact_orders
GROUP BY user_id
ORDER BY total_spent DESC;
--Top Customers (Top 10)
SELECT TOP 10
    user_id,
    SUM(total_amount) AS total_spent
FROM gold.fact_orders
GROUP BY user_id
ORDER BY total_spent DESC;
--Orders per Customer
SELECT 
    user_id,
    COUNT(order_id) AS total_orders
FROM gold.fact_orders
GROUP BY user_id
ORDER BY total_orders DESC;

--PRODUCT ANALYTICS
--Top Selling Products (Revenue)
SELECT 
    product_id,
    SUM(item_total) AS revenue
FROM gold.fact_order_items
GROUP BY product_id
ORDER BY revenue DESC;
--Most Sold Products (Quantity)
SELECT 
    product_id,
    SUM(quantity) AS total_units_sold
FROM gold.fact_order_items
GROUP BY product_id
ORDER BY total_units_sold DESC;
--Average Product Rating
SELECT 
    product_id,
    AVG(rating) AS avg_rating
FROM gold.fact_reviews
GROUP BY product_id
ORDER BY avg_rating DESC;

--REVIEW ANALYTICS
--Rating Distribution
SELECT 
    rating,
    COUNT(*) AS total_reviews
FROM gold.fact_reviews
GROUP BY rating
ORDER BY rating;
--Low Rated Products (Risk Analysis)
SELECT 
    product_id,
    AVG(rating) AS avg_rating
FROM gold.fact_reviews
GROUP BY product_id
HAVING AVG(rating) < 3
ORDER BY avg_rating;

--EVENT / BEHAVIOR ANALYTICS
--Event Type Distribution
SELECT 
    event_type,
    COUNT(*) AS total_events
FROM gold.fact_events
GROUP BY event_type;
--User Activity (Engagement)
SELECT 
    user_id,
    COUNT(*) AS activity_count
FROM gold.fact_events
GROUP BY user_id
ORDER BY activity_count DESC;