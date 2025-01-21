with
    orders_raw as (
        select
            salesorderid as order_id
            , customerid as customer_id
            , salespersonid as salesperson_id
            , totaldue as total_amount
            , orderdate as order_date
            , duedate as due_date
            , shipdate as ship_date
            , territoryid as territory_id
            , onlineorderflag as is_online_order
            , taxamt as tax_amount
            , freight as freight_cost
        from {{ source('adventureworks', 'salesorderheader') }}
    )

select
    order_id
    , customer_id
    , salesperson_id
    , total_amount
    , order_date
    , due_date
    , ship_date
    , territory_id
    , cast(coalesce(is_online_order, 0) as boolean) as is_online_order
    , tax_amount
    , freight_cost
from
    orders_raw
