with
    product as (
        select
            cast(productid as int) as product_id
            , cast(name as string) as name_product
        from {{ source('sap_adw', 'product') }}
    )
select *
from product