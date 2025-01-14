with
    customers_raw as (
        select
            customerid
            , personid
            , storeid
            , territoryid
            , rowguid
            , modifieddate as last_update_date
        from {{ source('adventureworks', 'customer') }}
    )

    , customers_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['customerid']) }} as customer_sk
            , *
        from customers_raw
    )

select
    customer_sk
    , customerid
    , personid
    , storeid
    , territoryid
    , rowguid
    , last_update_date
from customers_with_sk
