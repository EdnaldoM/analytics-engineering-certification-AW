with
    salesreason as (
        select
            cast(salesreasonid as int) as salesreason_id
            , cast(name as string) as reason_name
            , cast(reasontype as string) as reason_type
        from {{ source('sap_adw', 'salesreason') }}
    )
select *
from salesreason