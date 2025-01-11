select 
    customer_id,
    customer_name,
    customer_email,
    customer_region
from {{ ref('stg_customers') }}
