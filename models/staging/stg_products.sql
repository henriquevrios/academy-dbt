with
    products_raw as (
        select
            productid as product_id
            , name as product_name
            , productnumber as product_number
            , color
            , standardcost as standard_cost
            , listprice as list_price
            , size
            , weight
            , productsubcategoryid as subcategory_id
            , modifieddate as last_update_date
        from {{ source('adventureworks', 'product') }}
    )

select
    product_id
    , product_name
    , product_number
    , color
    , standard_cost
    , list_price
    , size
    , weight
    , subcategory_id
    , last_update_date
from
    products_raw
