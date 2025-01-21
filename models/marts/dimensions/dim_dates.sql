with
    raw_dates as (
        {{ dbt_date.get_date_dimension("2011-01-01", "2015-01-01") }}
    )

    , processed_dates as (
        select
            raw_dates.date_day as day_date
            , raw_dates.month_start_date as start_date_month
            , raw_dates.year_start_date as start_date_year
            , raw_dates.year_number as year_number
            , raw_dates.month_name_short as short_month_name
            , (raw_dates.month_name_short || '/' || raw_dates.year_number) as month_year
        from raw_dates
    )

    , enriched_dates as (
        select
            to_varchar(date(processed_dates.day_date), 'YYYYMMDD') as date_sk
            , day_date
            , start_date_month
            , short_month_name
            , month_year
            , start_date_year
            , year_number
        from processed_dates
    )

select
    date_sk
    , day_date
    , start_date_month
    , short_month_name
    , month_year
    , start_date_year
    , year_number
from enriched_dates
