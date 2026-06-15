select
    doctor_id,
    specialty,
    clinic_id,
    created_at
from {{ ref('stg_doctors') }}