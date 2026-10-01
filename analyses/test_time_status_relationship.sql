WITH modified AS (

    SELECT
        *,
        {{ function('organize_time') }}(last_updated_at) AS interval_timestamp
    FROM {{ ref('stg_dbt_velib__station_status') }}

)


SELECT
    COUNT(*) AS row_count
FROM modified AS s
JOIN {{ ref('dim_time') }} AS t
    ON t.timestamp = s.interval_timestamp