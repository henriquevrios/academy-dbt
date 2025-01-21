with
    stores as (
        select
            *
        from {{ source('adventureworks', 'store') }}
    )

    , processed_stores as (
        select
            name as store_name
            , businessentityid as entity_id
            , salespersonid as person_id
        from stores
    )

select
    entity_id
    , store_name
    , person_id
from processed_stores
