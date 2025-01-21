with
    sales_with_regions as (
        select
            dr.region_name as region
            , fs.sales_amount
            , fs.order_id
        from {{ ref('fact_sales') }} fs
        left join {{ ref('dim_regions') }} dr
            on fs.product_id = dr.region_id
    )
    , aggregated_data as (
        select
            region
            , sum(sales_amount) as total_sales
            , count(order_id) as total_orders
        from sales_with_regions
        group by region
    )

select
    region
    , total_sales
    , total_orders
from aggregated_data
