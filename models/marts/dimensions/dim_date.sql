with
    staging_data as (
        select
            date
        from {{ ref('stg_date') }}
    ),

    calendar as (
        select
            date,
            year(date) as year,
            quarter(date) as quarter,
            month(date) as month,
            to_char(date, 'Month') as month_name,
            day(date) as day,
            dayofweek(date) as day_of_week,
            to_char(date, 'Day') as day_name,
            case 
                when dayofweek(date) in (1, 7) then true
                else false
            end as is_weekend,
            dateadd(day, -(dayofweek(date) - 1), date) as week_start_date,
            weekofyear(date) as week_number,
            dayofyear(date) as day_of_year
        from staging_data
    )

select
    date,
    year,
    quarter,
    month,
    month_name,
    day,
    day_of_week,
    day_name,
    is_weekend,
    week_start_date,
    week_number,
    day_of_year
from calendar
