with
    inventory_data as (
        select
            fi.product_id
            , dp.product_name
            , sum(fi.stock_level) as total_stock_level
        from adventureworks.dbt_henriquerios.fact_inventory fi
        inner join adventureworks.dbt_henriquerios.dim_products dp
            on fi.product_id = dp.product_id
        group by fi.product_id, dp.product_name
    )

    , inventory_analysis as (
        select
            product_id
            , product_name
            , total_stock_level as stock_level
            , case
                when total_stock_level <= 10 then 'Low Stock'
                when total_stock_level between 11 and 50 then 'Medium Stock'
                else 'High Stock'
              end as stock_status
        from inventory_data
    )

select
    product_id
    , product_name
    , stock_level
    , stock_status
from inventory_analysis
