with
    persons as (
        select
            *
        from {{ source('adventureworks', 'person') }}
    )

    , processed_persons as (
        select
            persontype as person_type
            , firstname || ' ' || lastname as full_name
            , businessentityid as business_entity_id
            , namestyle as name_style
        from persons
    )

select
    business_entity_id
    , person_type
    , name_style
    , full_name
from processed_persons
