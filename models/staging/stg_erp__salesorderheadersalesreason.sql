with
    salesorderheadersalesreason as (
        select
        cast(salesorderid as int) as salesorder_id
        , cast(salesreasonid as int) as salesreason_id
        from {{ source('sap_adw', 'salesorderheadersalesreason') }}
    )
select *
from salesorderheadersalesreason