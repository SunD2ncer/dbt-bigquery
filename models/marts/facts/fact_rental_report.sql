with maximum as (

    select
        station_name,
        s.station_id,
        max(capacity) as capacity,
        max(num_bikes_available) as estimated_capacity,
        max(num_ebike_available) as estimated_ebike_capacity,
        max(num_mechanical_bikes_available) as estimated_mechanical_bike_capacity

    from {{ ref('stg_station_status') }} ss

    join {{ ref('int_stations') }} s
        on s.station_id = ss.station_id

    group by
        station_name,
        station_id

),

maximum_with_ratio as (

    select
        *,
        {{ function('division') }}(capacity, estimated_capacity) as capacity_ratio

    from maximum

),


station_data AS (

    SELECT
        station_name,
        m.station_id,

        TIMESTAMP_SECONDS(
            CAST(
            300 * ROUND(UNIX_SECONDS(last_reported) / 300.0)
            AS INT64 )
        ) AS last_reported,

        capacity - num_bikes_available AS optimistic_num_bikes_rented,

        estimated_capacity - num_bikes_available AS estimated_num_bikes_rented

    FROM maximum_with_ratio m

    JOIN {{ ref('stg_station_status') }} ss
        ON m.station_id = ss.station_id
    WHERE EXTRACT(MINUTE FROM last_reported) IN (0, 30)
), 

half_hour_rent as 

(

SELECT
    station_name,
    station_id,
    last_reported,
    optimistic_num_bikes_rented,
    estimated_num_bikes_rented,

    CONCAT(
        FORMAT_TIMESTAMP(
            '%H:%M',
            TIMESTAMP_SUB(last_reported, INTERVAL 30 MINUTE)
        ),
        ' - ',
        FORMAT_TIMESTAMP('%H:%M', last_reported)
    ) AS time_window

FROM station_data 
)

select *
from half_hour_rent