with
    creditcard as (
        select 
            cast(creditcardid as int) as creditcard_id
            , cast(cardtype as string) as card_type
        from {{ source('sap_adw', 'creditcard') }}
    )
select *
from creditcard