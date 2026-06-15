select
    patient_id,
    created_at,
    country
from {{ source('raw', 'BBDD_patients') }}