with
    sales_data as (
        select
            s.order_id
            , s.sales_person_id
            , s.total_due
            , s.taxamt
            , s.freight
            , sp.full_name as sales_person_name
        from {{ ref('stg_salesorder') }} s
        left join {{ ref('dim_salesperson') }} sp
            on s.sales_person_id = sp.sales_person_id
    )

    , aggregated_salesperson as (
        select
            sales_person_id
            , sales_person_name
            , count(order_id) as total_orders
            , sum(total_due) as total_sales
            , sum(taxamt) as total_tax
            , sum(freight) as total_freight
        from sales_data
        group by sales_person_id, sales_person_name
    )

select
    sales_person_id
    , sales_person_name
    , total_orders
    , total_sales
    , total_tax
    , total_freight
from aggregated_salesperson
