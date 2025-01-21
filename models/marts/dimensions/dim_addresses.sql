with
    addresses_raw as (
        select
            addressid as address_id
            , addressline1 as address_line_1
            , addressline2 as address_line_2
            , city
            , stateprovinceid as state_province_id
            , postalcode as postal_code
            , modifieddate as last_update_date
        from {{ ref('stg_addresses') }}
    )

    , addresses_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['address_id']) }} as address_sk
            , address_id
            , address_line_1
            , address_line_2
            , city
            , state_province_id
            , postal_code
            , last_update_date
        from addresses_raw
    )

select
    address_sk
    , address_id
    , address_line_1
    , address_line_2
    , city
    , state_province_id
    , postal_code
    , last_update_date
from addresses_with_sk
