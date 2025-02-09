with
    person as (
        select
            cast(businessentityid as int) as businessentity_id
            , cast(firstname || ' ' || lastname as string) as full_name 
        from {{ source('sap_adw', 'person') }}
    )
select *
from person order by businessentity_id