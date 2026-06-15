with business_days as (

    select
        anio,
        mes,
        count(*) as working_days
    from {{ ref('dim_fecha') }}
    where es_dia_habil = true
    group by 1, 2

),

monthly_appointments as (

    select
        a.doctor_id,
        f.anio,
        f.mes,
        count(*) as appointments_completed

    from {{ ref('fct_appointments') }} a
    inner join {{ ref('dim_fecha') }} f
        on a.date_id = f.date_id
    where a.status = 'completed'
    group by 1, 2, 3

)

select
    m.doctor_id,
    m.anio,
    m.mes,
    m.appointments_completed,
    bd.working_days * 8 as capacity,
    1.0 * m.appointments_completed / nullif(bd.working_days * 8, 0) as utilization_rate

from monthly_appointments m
join business_days bd
    on bd.anio = m.anio
   and bd.mes = m.mes