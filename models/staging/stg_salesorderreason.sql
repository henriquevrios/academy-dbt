with
    order_reasons as (
        select
            *
        from {{ source('adventureworks', 'salesorderheadersalesreason') }}
    )

    , processed_order_reasons as (
        select
            salesreasonid as sales_reason_id
            , salesorderid as order_id
        from order_reasons
    )

select
    sales_reason_id
    , order_id
from processed_order_reasons
