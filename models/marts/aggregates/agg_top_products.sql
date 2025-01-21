with
    product_sales as (
        select
            fp.product_id
            , sum(fs.sales_quantity) as total_quantity_sold
            , sum(fs.sales_amount) as total_sales_amount
        from adventureworks.dbt_henriquerios.fact_sales fs
        inner join adventureworks.dbt_henriquerios.dim_products fp
            on fs.product_id = fp.product_id
        group by fp.product_id
    )

    , top_products as (
        select
            ps.product_id
            , dp.product_name
            , ps.total_quantity_sold
            , ps.total_sales_amount
        from product_sales ps
        inner join adventureworks.dbt_henriquerios.dim_products dp
            on ps.product_id = dp.product_id
        order by ps.total_sales_amount desc
    )

select
    product_id
    , product_name
    , total_quantity_sold
    , total_sales_amount
from top_products
