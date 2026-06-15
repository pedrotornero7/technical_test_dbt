select
    event_id,
    patient_id,
    event_type,
    event_timestamp
from {{ ref('stg_events') }}