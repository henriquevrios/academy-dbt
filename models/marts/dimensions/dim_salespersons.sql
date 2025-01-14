with
    salespersons_raw as (
        select
            *
        from {{ source('adventureworks', 'salesperson') }}
    )

    , salespersons_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['businessentityid']) }} as salesperson_sk
            , businessentityid as salesperson_id
            , territoryid as territory_id
            , salesquota as sales_quota
            , bonus as bonus_amount
            , commissionpct as commission_percentage
            , salesytd as sales_year_to_date
            , saleslastyear as sales_last_year
            , modifieddate as last_update_date
        from salespersons_raw
    )

select
    salesperson_sk
    , salesperson_id
    , territory_id
    , sales_quota
    , bonus_amount
    , commission_percentage
    , sales_year_to_date
    , sales_last_year
    , last_update_date
from salespersons_with_sk
