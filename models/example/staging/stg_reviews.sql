select
    review_id,
    appointment_id,
    rating,
    cast(created_at as timestamp) as created_at
from {{ source('raw', 'BBDD_reviews') }}