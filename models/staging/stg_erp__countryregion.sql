with
    countryregion as (
        select 
            cast(countryregioncode as string) as countryregion_code
            , cast(name as string) as name_country
        from {{ source('sap_adw', 'countryregion') }}
    )
select *
from countryregion