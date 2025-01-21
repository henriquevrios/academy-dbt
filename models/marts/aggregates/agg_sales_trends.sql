with
    sales_data as (
        select
            date_part('month', to_timestamp(sales_date)) as sales_month
            , date_part('year', to_timestamp(sales_date)) as sales_year
            , sum(sales_amount) as total_sales_amount
            , count(order_id) as total_orders
        from adventureworks.dbt_henriquerios.fact_sales
        group by
            date_part('month', to_timestamp(sales_date))
            , date_part('year', to_timestamp(sales_date))
    )

    , trends_analysis as (
        select
            sales_month
            , sales_year
            , total_sales_amount
            , total_orders
            , coalesce(
                total_sales_amount / nullif(total_orders, 0)
                , 0
            ) as average_sales_per_order
        from sales_data
    )

select
    sales_month
    , sales_year
    , total_sales_amount
    , total_orders
    , average_sales_per_order
from trends_analysis
