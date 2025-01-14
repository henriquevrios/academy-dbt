with
    products_raw as (
        select
            *
        from {{ source('adventureworks', 'product') }}
    )

    , products_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['productid']) }} as product_sk
            , *
        from products_raw
    )

select
    product_sk
    , productid as product_id
    , name as product_name
    , productnumber as product_number
    , color as product_color
    , standardcost as standard_cost
    , listprice as list_price
    , size as product_size
    , weight as product_weight
    , modifieddate as last_update_date
from
    products_with_sk
