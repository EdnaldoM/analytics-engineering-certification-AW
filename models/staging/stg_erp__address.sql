with
    address as (
        select
            cast(addressid as int) as address_id
            , cast(city as string) as city
            , cast(stateprovinceid as int) as stateprovince_id

        from {{ source('sap_adw', 'address') }}
    )

select *
from  address