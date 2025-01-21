with
    details as (
        select
            *
        from {{ source('adventureworks', 'salesorderdetail') }}
    )

    , processed_details as (
        select
            salesorderdetailid as order_detail_id
            , salesorderid as order_id
            , productid as product_id
            , orderqty as order_qty
            , unitprice as unit_price
            , unitpricediscount as unit_price_discount
            , specialofferid as special_offer_id
        from details
    )

select
    order_detail_id
    , order_id
    , product_id
    , order_qty
    , unit_price
    , unit_price_discount
    , special_offer_id
from processed_details
