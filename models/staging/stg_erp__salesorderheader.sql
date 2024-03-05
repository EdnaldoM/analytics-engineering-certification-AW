with
    firstsalesorderheader as (
        select *, cast(orderdate as timestamp) as ordertimestamp
        from {{ source('sap_adw', 'salesorderheader') }}
    )
    
    , extractdate as (
        select *, extract(date from ordertimestamp) as order_date
        from firstsalesorderheader
    )
    
    , salesorderheader as (
        select
            cast(salesorderid as int) as salesorder_id

            , order_date
            , extract(year from order_date) as order_year
            , extract(month from order_date) as order_month
            , extract(day from order_date) as order_day


            , case when status = 5 then 'Shipped' end as status
            , cast(customerid as int) as customer_id
            , cast(salespersonid as int) as salesperson_id
            , cast(territoryid as int) as territory_id
            , cast(shiptoaddressid as int) as shiptoaddress_id
            , cast(creditcardid as int) as creditcard_id
            , cast(subtotal as int) as subtotal
            , cast(taxamt as int) as taxes
            , cast(freight as int) as freight
            , cast(totaldue as int) as totaldue
        from extractdate
    )


select *
from salesorderheader