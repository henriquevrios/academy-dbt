with
    salesperson_data as (
        select
            sp.sales_person_id
            , sp.territory_id
            , 'N/A' as full_name 
            , 'N/A' as email_address 
            , 'N/A' as phone_number 
            , current_date as hire_date 
        from {{ ref('stg_salesperson') }} sp
    )

select
    sales_person_id
    , territory_id
    , full_name
    , email_address
    , phone_number
    , hire_date
from salesperson_data
