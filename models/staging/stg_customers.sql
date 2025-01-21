with
    customers as (
        select
            *
        from {{ source('adventureworks', 'customer') }}
    )

    , processed_customers as (
        select
            territoryid as territory_id
            , storeid as store_id
            , personid as person_id
            , customerid as customer_id
        from customers
    )

select
    customer_id
    , person_id
    , store_id
    , territory_id
from processed_customers
