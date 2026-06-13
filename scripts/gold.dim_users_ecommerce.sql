IF OBJECT_ID('gold.dim_users', 'U') IS NOT NULL
    DROP TABLE gold.dim_users;

SELECT
    user_id,
    name,
    email,
    gender,
    city,
    signup_date
INTO gold.dim_users
FROM silver.users;