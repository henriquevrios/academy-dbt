with
    sales_raw as (
        select
            salesorderid as order_id
            , productid as product_id
            , orderqty as sales_quantity
            , unitprice * orderqty as sales_amount
            , modifieddate as sales_date
        from {{ source('adventureworks', 'salesorderdetail') }}
    )
select
    order_id
    , product_id
    , sales_quantity
    , sales_amount
    , sales_date
from
    sales_raw
