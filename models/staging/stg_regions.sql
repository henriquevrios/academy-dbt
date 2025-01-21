with
    regions_raw as (
        select
            territoryid as region_id
            , name as region_name
            , countryregioncode as country_code
            , group_name as group_name
            , modifieddate as last_update_date
        from {{ source('adventureworks', 'salesterritory') }}
    )

select
    region_id
    , region_name
    , country_code
    , group_name
    , last_update_date
from
    regions_raw
