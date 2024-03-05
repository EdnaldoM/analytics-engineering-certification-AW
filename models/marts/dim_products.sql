with 
    order_detail as (
        select *
        from {{ ref('stg_erp__salesorderdetail') }}
    )

    , product as (
        select *
        from {{ ref('stg_erp__product') }}
    )

    , join_orderdetail_product as (
        select
            order_detail.salesorderdetail_id
            , order_detail.salesorder_id
            , order_detail.product_id
            , order_detail.order_qty
            , order_detail.unitprice
            , order_detail.unitprice_discount

            , order_detail.order_qty*order_detail.unitprice*(1 - order_detail.unitprice_discount) as total_per_item

            , product.name_product

        from order_detail
        left join product on order_detail.product_id = product.product_id
        order by salesorderdetail_id
    )

select *
from join_orderdetail_product