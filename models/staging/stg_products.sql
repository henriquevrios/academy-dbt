with
    products as (
        select
            *
        from {{ source('adventureworks', 'product') }}
    )

    , processed_products as (
        select
            name as product_name
            , productid as product_id
            , productnumber as product_number
            , makeflag as make_flag
            , finishedgoodsflag as finished_goods_flag
            , safetystocklevel as safety_stock_level
            , reorderpoint as reorder_point
            , standardcost as standard_cost
            , listprice as list_price
            , color
            , size
            , sizeunitmeasurecode as size_unit_measure_code
            , weight
            , weightunitmeasurecode as weight_unit_measure_code
            , daystomanufacture as days_to_manufacture
            , productline as product_line
            , class
            , style
            , productmodelid as product_model_id
            , productsubcategoryid as product_subcategory_id
            , sellstartdate as sell_start_date
        from products
    )

select
    product_id
    , product_name
    , product_number
    , make_flag
    , finished_goods_flag
    , safety_stock_level
    , reorder_point
    , standard_cost
    , list_price
    , color
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
from processed_products
