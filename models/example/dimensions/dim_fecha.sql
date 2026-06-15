{{
  config(
    materialized='table'
  )
}}

with date_spine as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2023-01-01' as date)",
        end_date="cast('2026-12-31' as date)"
    ) }}
)

select
    cast(date_day as date)                              as fecha,
    cast(strftime(date_day, '%d%m%Y') as int)           as date_id,
    extract(day from date_day)::int                     as dia,
    extract(month from date_day)::int                   as mes,
    strftime(date_day, '%B')                            as nombre_mes,
    extract(quarter from date_day)::int                 as trimestre,
    extract(year from date_day)::int                    as anio,
    extract(isodow from date_day)::int                  as dia_semana,
    strftime(date_day, '%A')                            as nombre_dia,
    extract(isodow from date_day) in (6,7)              as es_fin_de_semana,
    extract(isodow from date_day) not in (6,7)          as es_dia_habil,
    false                                                as es_feriado

from date_spine