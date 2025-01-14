with
    sales_with_salespersons as (
        select
            dsp.salesperson_id
            , dsp.sales_quota
            , dsp.bonus_amount
            , fs.sales_amount
            , fs.order_id
        from {{ ref('fact_sales') }} fs
        left join {{ ref('dim_salespersons') }} dsp
            on fs.product_id = dsp.salesperson_id
    )
    , aggregated_data as (
        select
            salesperson_id
            , sum(sales_amount) as total_sales
            , count(order_id) as total_orders
            , max(sales_quota) as max_sales_quota
            , sum(bonus_amount) as total_bonus
        from sales_with_salespersons
        group by salesperson_id
    )

select
    salesperson_id
    , total_sales
    , total_orders
    , max_sales_quota
    , total_bonus
from aggregated_data
