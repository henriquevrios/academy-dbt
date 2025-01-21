with
    base_source as (
        select
            1 as reference
        from {{ source('adventureworks', 'salesorderheader') }}
        limit 1
    )
    
    , generated_dates as (
        select
            dateadd(day, seq4(), '2000-01-01') as date
        from table(generator(rowcount => 36525)) 
    )

select
    date
from
    generated_dates
