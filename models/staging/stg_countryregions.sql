with
    regions as (
        select
            *
        from {{ source('adventureworks', 'countryregion') }}
    )

    , processed_regions as (
        select
            name as country_name
            , countryregioncode as country_code
        from regions
    )

select
    country_code
    , country_name
from processed_regions
