with
    orders as (
        select
            *
        from {{ ref('stg_salesorder') }}
    )

    , order_items as (
        select
            *
        from {{ ref('stg_salesorderdetail') }}
    )

    , credit_cards as (
        select
            *
        from {{ ref('stg_creditcard') }}
    )

    , enriched_orderlines as (
        select
            {{ dbt_utils.generate_surrogate_key(['orders.order_id', 'order_items.order_detail_id']) }} as sk_orderline
            , to_varchar(date(orders.order_date), 'YYYYMMDD') as date_sk
            , orders.order_date
            , orders.order_id
            , orders.customer_id
            , orders.bill_to_address_id
            , orders.sales_person_id
            , order_items.order_detail_id
            , order_items.product_id
            , order_items.order_qty
            , order_items.unit_price
            , order_items.unit_price_discount
            , credit_cards.card_type
            , order_items.unit_price * (1 - order_items.unit_price_discount) * order_items.order_qty as net_amount
            , orders.subtotal
            , orders.taxamt
            , orders.freight
            , orders.total_due
        from orders
        left join order_items
            on orders.order_id = order_items.order_id
        left join credit_cards
            on orders.creditcard_id = credit_cards.creditcard_id
    )

select
    sk_orderline
    , date_sk
    , order_date
    , order_id
    , customer_id
    , bill_to_address_id
    , sales_person_id
    , order_detail_id
    , product_id
    , order_qty
    , unit_price
    , unit_price_discount
    , card_type
    , net_amount
    , subtotal
    , taxamt
    , freight
    , total_due
from enriched_orderlines
