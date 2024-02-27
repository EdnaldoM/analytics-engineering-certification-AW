with
    salesorderdetail as (
        select 
            cast(salesorderdetailid as int) as salesorderdetail_id
            , cast(salesorderid as int) as salesorder_id
            , cast(orderqty as int) as orderqty_id
            , cast(productid as int) as product_id
            , cast(specialofferid as int) as specialoffer_id
            , cast(unitprice as int) as unitprice
            , cast(unitpricediscount as int) as unitprice_discount
        from {{ source('sap_adw', 'salesorderdetail') }}
    )
select *
from salesorderdetail