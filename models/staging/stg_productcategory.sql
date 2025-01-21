with
    categories as (
        select
            *
        from {{ source('adventureworks', 'productcategory') }}
    )

    , processed_categories as (
        select
            name as category_name
            , productcategoryid as category_id
        from categories
    )

select
    category_id
    , category_name
from processed_categories
