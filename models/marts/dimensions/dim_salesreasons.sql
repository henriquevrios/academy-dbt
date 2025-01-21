with
    product_data as (
        select
            *
        from {{ ref('stg_products') }}
    )

    , processed_product as (
        select
            product_id
            , product_name
            , product_number
            , color
            , make_flag
            , finished_goods_flag
            , safety_stock_level
            , reorder_point
            , standard_cost
            , list_price
            , size
            , size_unit_measure_code
            , weight
            , weight_unit_measure_code
            , days_to_manufacture
            , product_line
            , class
            , style
            , product_model_id
            , product_subcategory_id
            , sell_start_date
        from product_data
    )

select
    product_id
    , product_name
    , product_number
    , color
    , make_flag
    , finished_goods_flag
    , safety_stock_level
    , reorder_point
    , standard_cost
    , list_price
    , size
    , size_unit_measure_code
    , weight
    , weight_unit_measure_code
    , days_to_manufacture
    , product_line
    , class
    , style
    , product_model_id
    , product_subcategory_id
    , sell_start_date
from processed_product
