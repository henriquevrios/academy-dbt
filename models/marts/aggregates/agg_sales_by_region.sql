with
    sales_data as (
        select
            s.order_id
            , s.sales_person_id
            , s.total_due
            , s.taxamt
            , s.freight
            , l.state_or_province_name
            , l.country_name
        from {{ ref('stg_salesorder') }} s
        left join {{ ref('dim_locations') }} l
            on s.bill_to_address_id = l.address_id
    )

    , aggregated_region as (
        select
            state_or_province_name
            , country_name
            , count(order_id) as total_orders
            , sum(total_due) as total_sales
            , sum(taxamt) as total_tax
            , sum(freight) as total_freight
        from sales_data
        group by state_or_province_name, country_name
    )

select
    state_or_province_name
    , country_name
    , total_orders
    , total_sales
    , total_tax
    , total_freight
from aggregated_region
