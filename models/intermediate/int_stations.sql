with source as (
    select * from {{ ref('stg_stations') }}
), 

---- Adding Commune Codes to link to a single commune 

regions as (
    select commune_code, 
    longitude as lon, 
    latitude as lat
    from {{ ref('stg_regions') }}
),

final as (
    select information_life_expectancy
            last_updated_at,
            extracted_at, 
            station_name,
            capacity,
            station_id,
            s.lon,
            s.lat,
            station_code,
            commune_code,from source s
    join regions r
    on r.lon = s.lon and r.lat = s.lat
)

select * from final