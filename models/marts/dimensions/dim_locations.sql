with
    address_data as (
        select
            *
        from {{ ref('stg_address') }}
    )

    , province_data as (
        select
            *
        from {{ ref('stg_stateprovince') }}
    )

    , country_data as (
        select
            *
        from {{ ref('stg_countryregions') }}
    )

    , enriched_location as (
        select
            {{ dbt_utils.generate_surrogate_key(['address_data.address_id', 'address_data.postalcode']) }} as sk_address
            , address_data.address_id
            , address_data.full_address
            , address_data.city
            , address_data.postalcode
            , case
                when province_data.is_province_flag = true then 'true'
                else 'false'
              end as is_province_flag
            , province_data.province_name as state_or_province_name
            , province_data.territory_id
            , country_data.country_code
            , country_data.country_name
        from address_data
        left join province_data
            on address_data.stateprovince_id = province_data.state_province_id
        left join country_data
            on province_data.country_region_code = country_data.country_code
    )

select
    sk_address
    , address_id
    , full_address
    , city
    , postalcode
    , is_province_flag
    , state_or_province_name
    , territory_id
    , country_code
    , country_name
from enriched_location
