with
    stateprovince as (
        select
            cast(stateprovinceid as int) as stateprovince_id
            , cast(territoryid as int) as territory_id
            , cast(stateprovincecode as string) as stateprovince_code
            , cast(countryregioncode as string) as countryregion_code
            , cast(name as string) as name_stateprovince


        from {{ source('sap_adw', 'stateprovince') }}
    )
select *
from stateprovince