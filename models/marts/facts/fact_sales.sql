select 
    s.order_id,
    s.customer_id,
    s.product_id,
    p.product_name,
    c.customer_name,
    s.sales_date,
    s.region,
    s.sales_amount,
    s.sales_quantity
from {{ ref('stg_sales') }} s
join {{ ref('stg_customers') }} c on s.customer_id = c.customer_id
join {{ ref('stg_products') }} p on s.product_id = p.product_id
