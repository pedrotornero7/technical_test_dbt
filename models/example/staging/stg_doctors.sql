select
    doctor_id,
    specialty,
    clinic_id,
    created_at
from {{ source('raw', 'BBDD_doctors') }}