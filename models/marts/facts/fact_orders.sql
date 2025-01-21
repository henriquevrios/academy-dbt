with
    enriched_orders as (
        select
            o.order_sk as order_sk
            , o.order_id
            , o.customer_id
            , o.salesperson_id
            , o.total_amount
            , dd_order.date_sk as order_date_sk
            , dd_order.date as order_date
            , dd_due.date_sk as due_date_sk
            , dd_due.date as due_date
            , dd_ship.date_sk as ship_date_sk
            , dd_ship.date as ship_date
            , o.territory_id
            , o.is_online_order
            , o.tax_amount
            , o.freight_cost
        from {{ ref('dim_orders') }} o
        left join {{ ref('dim_date') }} dd_order
            on o.order_date = dd_order.date
        left join {{ ref('dim_date') }} dd_due
            on o.due_date = dd_due.date
        left join {{ ref('dim_date') }} dd_ship
            on o.ship_date = dd_ship.date
    )

select
    order_sk
    , order_id
    , customer_id
    , salesperson_id
    , total_amount
    , order_date_sk
    , order_date
    , due_date_sk
    , due_date
    , ship_date_sk
    , ship_date
    , territory_id
    , is_online_order
    , tax_amount
    , freight_cost
from enriched_orders
