with ranked as (

    select *,
           row_number() over (
               partition by appointment_id
               order by created_at desc, appointment_id
           ) as rn

    from {{ source('raw', 'BBDD_appointments') }}

)

select 
    r.appointment_id,
    r.patient_id,
    r.doctor_id,
    strptime(r.scheduled_at, '%d/%m/%Y') as scheduled_at,
    strptime(r.created_at, '%d/%m/%Y') as created_at,
    coalesce(m.valor_mapeo, lower(trim(r.status))) as status,
    r.consultation_type
from ranked r
left join {{ ref('stg_map') }} m
    on lower(trim(r.status)) = lower(trim(m.valor_posible))
where r.rn = 1