with
    salesorder as (
        select *
        from {{ ref('stg_erp__salesorderheadersalesreason') }}
    )
    , salesreason as (
        select *
        from {{ ref('stg_erp__salesreason') }}
    )

    , salesheader as (
        select *
        from {{ ref('stg_erp__salesorderheader') }}
    )

    , join_order_reason as (
        select
            salesorder.salesorder_id
            , salesorder.salesreason_id

            , salesreason.reason_name
            , salesreason.reason_type

        from salesorder
        left join salesreason on salesorder.salesreason_id = salesreason.salesreason_id
        order by salesorder_id
    )

    , join_header_reason as (
        select
            salesheader.salesorder_id

            , join_order_reason.salesreason_id 
            , join_order_reason.reason_name 
            , join_order_reason.reason_type

        from salesheader
        left join join_order_reason on salesheader.salesorder_id = join_order_reason.salesorder_id
    )

    , coalececolumns as (
        select 
            salesorder_id

            , coalesce(salesreason_id, 0) as salesreason_id
            , coalesce(reason_name, 'No Sales Reason') as reason_name
            , coalesce(reason_type, 'No Reason Type') as reason_type

        from join_header_reason
    )

select *
from coalececolumns