with
    salespersons_raw as (
        select
            businessentityid as salesperson_id
            , territoryid as territory_id
            , salesquota as sales_quota
            , bonus as bonus_amount
            , commissionpct as commission_percentage
            , salesytd as sales_year_to_date
            , saleslastyear as sales_last_year
            , modifieddate as last_update_date
        from {{ source('adventureworks', 'salesperson') }}
    )

select
    salesperson_id
    , territory_id
    , sales_quota
    , bonus_amount
    , commission_percentage
    , sales_year_to_date
    , sales_last_year
    , last_update_date
from
    salespersons_raw
