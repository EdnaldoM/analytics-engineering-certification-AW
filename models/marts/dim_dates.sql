with 
    date_spine as (
        {{ dbt_utils.date_spine(
            datepart="day"
            , start_date="cast('1970-01-01' as date)"
         , end_date="cast('2014-12-31' as date)"
        )}}
    )

    , datetime as (
        select
            cast(date_day as timestamp) as date_time
        from date_spine
    )

    , date_only as (
        select
            extract(date from date_time) as full_date
        from datetime
    )

    , calendar as (
        select
            full_date
            , extract(year from full_date) as year
            , extract(day from full_date) as day
            , extract(month from full_date) as month
        from date_only
    )

    , full_calendar as (
        select 
            full_date
            , year
            , day
            , month 

            ,  CASE
                WHEN month = 1 THEN 'Janeiro'
                WHEN month = 2 THEN 'Fevereiro'
                WHEN month = 3 THEN 'Março'
                WHEN month = 4 THEN 'Abril'
                WHEN month = 5 THEN 'Maio'
                WHEN month = 6 THEN 'Junho'
                WHEN month = 7 THEN 'Julho'
                WHEN month = 8 THEN 'Agosto'
                WHEN month = 9 THEN 'Setembro'
                WHEN month = 10 THEN 'Outubro'
                WHEN month = 11 THEN 'Novembro'
                WHEN month = 12 THEN 'Dezembro'
            END AS month_name
        from calendar
    )

    , moth_year_calendar as (
        select
            full_date
            , year
            , day
            , month
            , month_name
            , month_name || '/' || year as month_year
        from full_calendar
    )

select *
from moth_year_calendar
order by full_date desc