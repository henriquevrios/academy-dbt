with
    customers_raw as (
        select
            customer_id
            , person_id
            , store_id
            , territory_id
            , rowguid
            , last_update_date
        from {{ ref('stg_customers') }}
    )

    , customers_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_sk
            , customer_id
            , person_id
            , store_id
            , territory_id
            , rowguid
            , last_update_date
        from customers_raw
    )

select
    customer_sk
    , customer_id
    , person_id
    , store_id
    , territory_id
    , rowguid
    , last_update_date
from customers_with_sk
