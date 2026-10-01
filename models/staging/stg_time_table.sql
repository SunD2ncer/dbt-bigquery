with spine as (
    {{ dbt_utils.date_spine(
        datepart='hour',
        start_date = " cast('2026-09-10' as timestamp)",
        end_date = " current_timestamp"
    )}}
)

select * from spine