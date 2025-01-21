with
    sales_with_customers as (
        select
            fc.customer_id
            , fs.order_id
            , fs.sales_amount
        from adventureworks.dbt_henriquerios.fact_sales fs
        left join adventureworks.dbt_henriquerios.fact_customers fc
            on fc.customer_id = fs.order_id
    )

    , customer_orders as (
        select
            customer_id
            , count(distinct order_id) as total_orders
        from sales_with_customers
        group by customer_id
    )

    , successful_sales as (
        select
            customer_id
            , count(distinct order_id) as successful_orders
        from sales_with_customers
        where sales_amount > 0
        group by customer_id
    )

    , conversion_data as (
        select
            co.customer_id
            , coalesce(co.total_orders, 0) as total_orders
            , coalesce(ss.successful_orders, 0) as successful_orders
            , coalesce(
                round((coalesce(ss.successful_orders, 0)::float / coalesce(co.total_orders, 1)::float) * 100, 2)
                , 0
            ) as conversion_rate
        from customer_orders co
        left join successful_sales ss
            on co.customer_id = ss.customer_id
    )

select
    customer_id
    , total_orders
    , successful_orders
    , conversion_rate
from conversion_data
where customer_id is not null 
