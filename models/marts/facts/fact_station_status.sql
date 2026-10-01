{{
    config(
        materialized='incremental',
        incremental_strategy= 'merge'
    )
}}

with source as (
    select * from {{ ref('stg_station_status') }}
    {% if is_incremental()%}
    where extracted_at > select max(extracted_at) from {{ this }}
    {% endif%}
)

select * from source
order by extracted_at desc