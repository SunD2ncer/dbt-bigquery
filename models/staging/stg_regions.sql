with source as (
    select * from {{ source('dbt_velib', 'raw_velib_regions') }}
)

select * from source