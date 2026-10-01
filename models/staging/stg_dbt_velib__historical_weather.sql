with weather as (
    SELECT
    -- Location / station context
    commune,
    location_id,
    latitude,
    longitude,
    elevation,

    -- Timezone / API metadata
    timezone,
    timezone_abbreviation,
    utc_offset_seconds,
    generationtime_ms,

    -- Hourly weather observation
    weather_time AS weather_timestamp,
    hourly.wind_direction_10m[SAFE_OFFSET(i)] AS wind_direction_10m,
    hourly.wind_speed_10m[SAFE_OFFSET(i)] AS wind_speed_10m,
    hourly.weather_code[SAFE_OFFSET(i)] AS weather_code,
    hourly.precipitation[SAFE_OFFSET(i)] AS precipitation,
    hourly.apparent_temperature[SAFE_OFFSET(i)] AS apparent_temperature,
    hourly.cloud_cover[SAFE_OFFSET(i)] AS cloud_cover,
    hourly.relative_humidity_2m[SAFE_OFFSET(i)] AS relative_humidity_2m,
    hourly.rain[SAFE_OFFSET(i)] AS rain,
    hourly.temperature_2m[SAFE_OFFSET(i)] AS temperature_2m, 
    hourly_units.temperature_2m AS temperature_2m_unit,
    hourly_units.apparent_temperature AS apparent_temperature_unit,
    hourly_units.relative_humidity_2m AS relative_humidity_2m_unit,
    hourly_units.precipitation AS precipitation_unit,
    hourly_units.rain AS rain_unit,
    hourly_units.cloud_cover AS cloud_cover_unit,
    hourly_units.wind_speed_10m AS wind_speed_10m_unit,
    hourly_units.wind_direction_10m AS wind_direction_10m_unit,
    hourly_units.weather_code AS weather_code_unit

    FROM {{ source('historical_weather', 'raw_historical_weather') }},
    UNNEST(hourly.time) AS weather_time WITH OFFSET AS i
    
)

select * from weather