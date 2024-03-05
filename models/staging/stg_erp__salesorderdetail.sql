with
    salesorderdetail as (
        select 
            cast(salesorderdetailid as int) as salesorderdetail_id
            , cast(salesorderid as int) as salesorder_id
            , cast(orderqty as int) as order_qty
            , cast(productid as int) as product_id
            , cast(specialofferid as int) as specialoffer_id
            , cast(unitprice as numeric) as unitprice
            , cast(unitpricediscount as numeric) as unitprice_discount
        from {{ source('sap_adw', 'salesorderdetail') }}
    )
select *
from salesorderdetail