with source as (
    
    select * from {{ source('raw', 'raw_station_status') }}

), 
unnested as (

    select
    ttl, 
    lastUpdatedOther,
    extracted_at,
    station

    from source,
    unnest(data.stations) as station

), 
final as (

    select 
    ttl as information_life_expectancy, 
    TIMESTAMP_SECONDS(lastUpdatedOther) as last_updated_at,
    extracted_at, 
    station.station_id as station_id,
    station.num_docks_available as num_docks_available,
    station.num_bikes_available as num_bikes_available,

    (
        SELECT bike_type.ebike
        FROM UNNEST(station.num_bikes_available_types) AS bike_type
        WHERE bike_type.ebike IS NOT NULL
    ) AS num_ebike_available,

    (
        SELECT bike_type.mechanical
        FROM UNNEST(station.num_bikes_available_types) AS bike_type
        WHERE bike_type.mechanical IS NOT NULL
    ) AS num_mechanical_bikes_available,

    station.is_renting as is_renting,
    station.is_returning as is_returning,
    station.is_installed as is_installed,
    station.last_reported as last_reported

from unnested
)

select * from final