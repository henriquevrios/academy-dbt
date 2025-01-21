with
    salespersons_raw as (
        select
            salesperson_id
            , territory_id
            , sales_quota
            , bonus_amount
            , commission_percentage
            , sales_year_to_date
            , sales_last_year
            , last_update_date
        from {{ ref('stg_salespersons') }}
    )

    , salespersons_with_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['salesperson_id']) }} as salesperson_sk
            , *
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
