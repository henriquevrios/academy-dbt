with
    aggregated_inventory as (
        select
            product_id
            , sum(stock_level) as total_stock_level
            , max(last_update_date) as last_update_date
        from {{ ref('int_inventory_movements') }}
        group by product_id
    )

select
    product_id
    , total_stock_level as stock_level
    , last_update_date
from aggregated_inventory
