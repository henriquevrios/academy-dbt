with
    customers_fact_raw as (
        select
            customer_id
            , person_id
            , store_id
            , territory_id
            , rowguid
            , last_update_date
        from {{ ref('dim_customers') }}
    )

select
    customer_id
    , person_id
    , store_id
    , territory_id
    , rowguid
    , last_update_date
from customers_fact_raw
