with
    staging_orders as (
        select
            order_id
            , customer_id
            , salesperson_id
            , total_amount
            , order_date
            , due_date
            , ship_date
            , territory_id
            , is_online_order
            , tax_amount
            , freight_cost
        from {{ ref('stg_orders') }}
    ),

    orders_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['order_id']) }} as order_sk
            , order_id
            , customer_id
            , salesperson_id
            , total_amount
            , order_date
            , due_date
            , ship_date
            , territory_id
            , is_online_order
            , tax_amount
            , freight_cost
        from staging_orders
    )

select
    order_sk
    , order_id
    , customer_id
    , salesperson_id
    , total_amount
    , order_date
    , due_date
    , ship_date
    , territory_id
    , is_online_order
    , tax_amount
    , freight_cost
from orders_with_sk
