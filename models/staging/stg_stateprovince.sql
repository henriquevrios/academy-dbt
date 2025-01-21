with
    provinces as (
        select
            *
        from {{ source('adventureworks', 'stateprovince') }}
    )

    , processed_provinces as (
        select
            countryregioncode as country_region_code
            , stateprovinceid as state_province_id
            , stateprovincecode as state_province_code
            , isonlystateprovinceflag as is_province_flag
            , territoryid as territory_id
            , name as province_name
        from provinces
    )

select
    state_province_id
    , state_province_code
    , country_region_code
    , is_province_flag
    , province_name
    , territory_id
from processed_provinces
