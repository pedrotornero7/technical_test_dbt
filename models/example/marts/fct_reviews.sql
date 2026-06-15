select
    review_id,
    appointment_id,
    rating,
    created_at as review_created_at

from {{ ref('stg_reviews') }}