IF OBJECT_ID('gold.fact_events', 'U') IS NOT NULL
    DROP TABLE gold.fact_events;

SELECT
    event_id,
    user_id,
    product_id,
    event_type,
    event_timestamp
INTO gold.fact_events
FROM silver.events;


