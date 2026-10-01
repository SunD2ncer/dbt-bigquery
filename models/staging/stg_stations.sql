with source as (

    select * from {{ source('dbt_velib', 'raw_velib_stations') }}

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
    station.name as station_name, 
    station.capacity as capacity,
    station.lon as lon,
    station.lat as lat, 
    station.stationCode as station_code

    from unnested
)


select * from final