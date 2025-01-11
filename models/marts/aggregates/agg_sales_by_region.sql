with sales_facts as (
    select *
    from {{ ref('fact_sales') }}
)
select 
    region,
    salesperson_id,
    sum(sales_amount) as total_sales,
    count(distinct order_id) as total_orders
from sales_facts
group by region, salesperson_id
