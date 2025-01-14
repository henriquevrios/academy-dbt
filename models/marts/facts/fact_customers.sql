with
    customers_raw as (
        select
            customerid as customer_id
            , personid as person_id
            , storeid as store_id
            , territoryid as territory_id
            , modifieddate as last_update_date
        from {{ source('adventureworks', 'customer') }}
    )
select
    customer_id
    , person_id
    , store_id
    , territory_id
    , last_update_date
from
    customers_raw
