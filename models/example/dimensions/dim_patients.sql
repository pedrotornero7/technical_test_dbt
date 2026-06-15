select distinct
    patient_id,
    created_at,
    country
from {{ ref('stg_patients') }}