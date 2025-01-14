with
    inventory_movements_raw as (
        select
            pi.productid as product_id
            , pi.locationid as warehouse_id
            , pi.quantity as stock_level
            , pi.modifieddate as last_update_date
            , coalesce(
                lag(pi.quantity) over (
                    partition by pi.productid, pi.locationid
                    order by pi.modifieddate
                )
                , pi.quantity
            ) as previous_stock_level
        from {{ source('adventureworks', 'productinventory') }} pi
    )

    , inventory_differences as (
        select
            product_id
            , warehouse_id
            , last_update_date
            , stock_level
            , previous_stock_level
            , stock_level - previous_stock_level as stock_change
        from inventory_movements_raw
    )

select
    product_id
    , warehouse_id
    , last_update_date
    , stock_level
    , previous_stock_level
    , stock_change
from inventory_differences
