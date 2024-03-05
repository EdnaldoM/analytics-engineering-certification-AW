with 
    address as (
        select
            address_id
            , city
            , stateprovince_id
        from {{ ref('stg_erp__address') }}
    )

    , shippedto as (
        select
            salesorder_id
            , shiptoaddress_id
            , territory_id
        from {{ ref('stg_erp__salesorderheader') }}
    )

    , stateprovince as (
        select
            stateprovince_id
            , name_stateprovince
            , territory_id
            , countryregion_code
        from {{ ref('stg_erp__stateprovince') }}
    )

    , countryregion as (
        select
            countryregion_code
            , name_country
        from {{ ref('stg_erp__countryregion') }}
    )

    , territory as (
        select
            territory_id
            , name_territory
            , countryregion_code
        from {{ ref('stg_erp__salesterritory') }}
    )

    , join_shipped_address as (
        select
            shippedto.shiptoaddress_id
            , shippedto.salesorder_id
            , row_number () over (partition by shippedto.shiptoaddress_id order by shippedto.salesorder_id) as row_address_id

            , address.city
            , address.stateprovince_id

        from shippedto
        left join address on shippedto.shiptoaddress_id = address.address_id
    )

    , join_address_state as (
        select
            join_shipped_address.shiptoaddress_id
            , join_shipped_address.row_address_id
            , join_shipped_address.city

            , stateprovince.name_stateprovince
            , stateprovince.countryregion_code
            , stateprovince.territory_id
        from join_shipped_address
        left join stateprovince on join_shipped_address.stateprovince_id = stateprovince.stateprovince_id
        where join_shipped_address.row_address_id = 1
    )

    , join_country_territory as (
        select
            join_address_state.shiptoaddress_id
            , join_address_state.city
            , join_address_state.name_stateprovince

            , countryregion.name_country

            , territory.name_territory

        from join_address_state
        left join countryregion on join_address_state.countryregion_code = countryregion.countryregion_code
        left join territory on join_address_state.territory_id = territory.territory_id
    )

select *
from join_country_territory