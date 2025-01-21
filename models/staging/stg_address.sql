with
    addr as (
        select
            *
        from {{ source('adventureworks', 'address') }}
    )

    , transformed_addr as (
        select
            addressid as address_id
            , stateprovinceid as stateprovince_id
            , coalesce(addressline1, '') || ' ' || coalesce(addressline2, '') as full_address
            , city
            , postalcode
            , spatiallocation
        from addr
    )

select
    address_id
    , stateprovince_id
    , full_address
    , city
    , postalcode
    , spatiallocation
from transformed_addr
