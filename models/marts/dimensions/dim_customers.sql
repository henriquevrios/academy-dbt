with
    customer_data as (
        select
            *
        from {{ ref('stg_customers') }}
    )

    , person_data as (
        select
            *
        from {{ ref('stg_persons') }}
    )

    , store_data as (
        select
            *
        from {{ ref('stg_store') }}
    )

    , enriched_customers as (
        select
            {{ dbt_utils.generate_surrogate_key(['customer_data.customer_id', 'customer_data.person_id']) }} as sk_customer
            , customer_data.customer_id
            , coalesce(person_data.full_name, 'Unknown') as full_name
            , customer_data.person_id
            , coalesce(store_data.store_name, 'No Store') as store_name
            , customer_data.store_id
        from customer_data
        left join person_data
            on customer_data.person_id = person_data.business_entity_id
        left join store_data
            on customer_data.store_id = store_data.entity_id -- Substituído o nome da coluna
    )

select
    sk_customer
    , customer_id
    , full_name
    , person_id
    , store_name
    , store_id
from enriched_customers
