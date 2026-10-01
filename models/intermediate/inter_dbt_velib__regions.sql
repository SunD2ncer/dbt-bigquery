with source as (
   select * from {{ ref('stg_dbt_velib__regions') }}
), 

final as (
    select distinct region,
    region_code,
    commune_code,
    department_code,
    commune,
    department from source s 
)

select * from final