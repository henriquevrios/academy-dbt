with 
    regions_raw as (
        select
            distinct territoryid as region_id
            , name as region_name
        from {{ source('adventureworks', 'salesterritory') }}
    )

    , regions_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['region_id']) }} as region_sk
            , *
        from regions_raw
    )

select
    region_sk
    , region_id
    , region_name
from regions_with_sk
