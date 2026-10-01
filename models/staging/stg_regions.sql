with source as (
    select * from {{ source('velib_regions', 'raw_velib_regions') }}
)

select * from source