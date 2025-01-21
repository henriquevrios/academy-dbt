with
    raw_order_details as (
        select
            sod.salesorderid as order_id
            , sod.productid as product_id
            , so.customerid as customer_id
            , so.orderdate as order_date
            , sod.orderqty as quantity
            , sod.unitprice as unit_price
            , sod.unitprice * sod.orderqty as total_price
        from {{ source('adventureworks', 'salesorderdetail') }} sod
        inner join {{ source('adventureworks', 'salesorderheader') }} so
            on sod.salesorderid = so.salesorderid
    )

select
    order_id
    , product_id
    , customer_id
    , order_date
    , quantity
    , unit_price
    , total_price
from raw_order_details
