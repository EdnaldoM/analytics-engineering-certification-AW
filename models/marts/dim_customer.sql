with 
    customer as (
        select *
        from {{ ref('stg_erp__customer') }}
    )   

    , person as (
        select
            businessentity_id
            , full_name
        from {{ ref('stg_erp__person') }}
    )

    , join_customer_person as (
        select
            customer.customer_id
            , coalesce(person.full_name, 'Not registered') as name_customer
        from customer
        left join person on customer.person_id = person.businessentity_id
    )

select *
from join_customer_person