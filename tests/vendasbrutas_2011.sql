with
    vendasbrutas_2011 as (
        select
            round(sum(gross_subtotal_by_order)) as vendas_brutas_2011

        from {{ ref('fct_orders') }}
        where order_year = 2011
    )

select *
from vendasbrutas_2011
where vendas_brutas_2011 != 12646112