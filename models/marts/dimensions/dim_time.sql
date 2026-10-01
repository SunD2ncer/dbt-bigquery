WITH time_spine AS (

    SELECT
        timestamp
    FROM UNNEST(
        GENERATE_TIMESTAMP_ARRAY(
            TIMESTAMP('2026-09-10 00:00:00'),
            CURRENT_TIMESTAMP(),
            INTERVAL 30 MINUTE
        )
    ) AS timestamp

)

SELECT

    FORMAT_TIMESTAMP('%Y%m%d%H%M', timestamp) AS time_id,

    timestamp,

    DATE(timestamp) AS date,

    EXTRACT(YEAR FROM timestamp) AS year,
    EXTRACT(QUARTER FROM timestamp) AS quarter,
    EXTRACT(MONTH FROM timestamp) AS month,
    EXTRACT(WEEK FROM timestamp) AS week,

    EXTRACT(DAY FROM timestamp) AS day,
    EXTRACT(DAYOFWEEK FROM timestamp) AS day_of_week,

    EXTRACT(HOUR FROM timestamp) AS hour,
    EXTRACT(MINUTE FROM timestamp) AS minute,

    EXTRACT(DAYOFWEEK FROM timestamp) IN (1, 7)
        AS is_weekend

FROM time_spine