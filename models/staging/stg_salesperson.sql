with
    sales_people as (
        select
            *
        from {{ source('adventureworks', 'salesperson') }}
    )

    , processed_sales_people as (
        select
            territoryid as territory_id
            , businessentityid as sales_person_id
        from sales_people
    )

select
    *
from processed_sales_people
