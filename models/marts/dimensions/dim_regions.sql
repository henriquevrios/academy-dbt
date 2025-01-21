with 
    regions_raw as (
        select
            region_id
            , region_name
        from {{ ref('stg_regions') }}
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
