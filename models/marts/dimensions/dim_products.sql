with
    products_raw as (
        select
            product_id
            , product_name
            , product_number
            , color as product_color
            , standard_cost
            , list_price
            , size as product_size
            , weight as product_weight
            , subcategory_id
            , last_update_date
        from {{ ref('stg_products') }}
    )

    , products_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_sk
            , *
        from products_raw
    )

select
    product_sk
    , product_id
    , product_name
    , product_number
    , product_color
    , standard_cost
    , list_price
    , product_size
    , product_weight
    , subcategory_id
    , last_update_date
from products_with_sk
