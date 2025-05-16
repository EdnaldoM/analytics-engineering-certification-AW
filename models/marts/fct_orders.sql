with 
    orders as (
        select *
        from {{ ref('stg_erp__salesorderheader') }}
    )

    , order_detail as (
        select
            salesorderdetail_id
            , salesorder_id
            , product_id
            , order_qty
            , unitprice
            , unitprice_discount

        from {{ ref('stg_erp__salesorderdetail') }}
    )

    , creditcard as (
        select *
        from {{ ref('stg_erp__creditcard') }}
    )

    , salesreason as (
        select *
        from {{ ref('dim_salesreason') }}
    )

    , partition_details_by_orders as (
        select
            orders.salesorder_id
            , row_number () over (partition by orders.salesorder_id order by order_detail.salesorderdetail_id) as row_order_details   
            , order_detail.unitprice*order_detail.order_qty as gross_subtotal
            , order_detail.order_qty

        from orders
        left join order_detail on orders.salesorder_id = order_detail.salesorder_id
    )

    , sales_orders as (
        select
            salesorder_id
            , count(row_order_details) as qty_products
            , sum(gross_subtotal) as gross_subtotal_by_order
            , sum(order_qty) as qty_items

        from partition_details_by_orders
        group by salesorder_id
    )

    , sales as (
        select
            orders.salesorder_id
            , orders.customer_id
            , orders.shiptoaddress_id
            , orders.order_date
            , orders.order_month
            , orders.order_year
            , orders.subtotal
            , orders.totaldue
            , coalesce(orders.status, 'No Status') as order_status
            , sales_orders.qty_products
            , sales_orders.qty_items
            , sales_orders.gross_subtotal_by_order
            , coalesce(creditcard.card_type, 'No Creditcard') as card_type

        from orders
        left join sales_orders on orders.salesorder_id = sales_orders.salesorder_id
        left join creditcard on orders.creditcard_id = creditcard.creditcard_id
        order by orders.salesorder_id
    )

select *
from sales