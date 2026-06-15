select
    a.appointment_id,
    a.patient_id,
    a.doctor_id,
    a.created_at,
    a.scheduled_at,
    a.status,

    -- enriquecimiento desde dimensiones
    d.specialty,
    p.country,
    cast(strftime(scheduled_at, '%d%m%Y') as int) as date_id

from {{ ref('stg_appointments') }} a

left join {{ ref('stg_doctors') }} d
    on a.doctor_id = d.doctor_id

left join {{ ref('stg_patients') }} p
    on a.patient_id = p.patient_id