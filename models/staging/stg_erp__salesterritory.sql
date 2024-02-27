with
    salesterritory as (
        select
            cast(territoryid as int) as territory_id
            , cast(name as string) as name_territory
            , cast(countryregioncode as string) as countryregion_code
            , cast(salesterritory.group as string) as group_territory
        from {{ source('sap_adw', 'salesterritory') }}
    )
select *
from salesterritory