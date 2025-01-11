select 
    order_id,
    customer_id,
    product_id,
    sales_date,
    region,
    sales_amount,
    sales_quantity
from {{ source('adventureworks', 'sales') }}
