with
    reasons as (
        select
            *
        from {{ source('adventureworks', 'salesreason') }}
    )

    , processed_reasons as (
        select
            reasontype as reason_type
            , name as reason_name
            , salesreasonid as reason_id
        from reasons
    )

select
    reason_id
    , reason_name
    , reason_type
from processed_reasons
