with
    orders as (
        select
            *
        from {{ source('adventureworks', 'salesorderheader') }}
    )

    , processed_orders as (
        select
            salesorderid as order_id
            , customerid as customer_id
            , to_date(orderdate) as order_date
            , billtoaddressid as bill_to_address_id
            , shiptoaddressid as ship_to_address_id
            , salespersonid as sales_person_id
            , creditcardid as creditcard_id
            , onlineorderflag as online_flag
            , territoryid as territory_id
            , subtotal
            , taxamt
            , freight
            , totaldue as total_due
        from orders
    )

select
    order_id
    , customer_id
    , order_date
    , bill_to_address_id
    , ship_to_address_id
    , sales_person_id
    , creditcard_id
    , online_flag
    , territory_id
    , subtotal
    , taxamt
    , freight
    , total_due
from processed_orders
