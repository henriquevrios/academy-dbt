with
    inventory_raw as (
        select
            productid as product_id
            , locationid as warehouse_id
            , quantity as stock_level
            , modifieddate as last_update_date
        from {{ source('adventureworks', 'productinventory') }}
    )

select
    product_id
    , warehouse_id
    , stock_level
    , last_update_date
from
    inventory_raw
