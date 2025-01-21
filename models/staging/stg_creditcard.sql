with
    cards as (
        select
            *
        from {{ source('adventureworks', 'creditcard') }}
    )

    , processed_cards as (
        select
            cardtype as card_type
            , creditcardid as creditcard_id
        from cards
    )

select
    creditcard_id
    , card_type
from processed_cards
