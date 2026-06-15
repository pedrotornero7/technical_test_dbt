with patient_funnel as (

    select
        patient_id,
        date_trunc('month', event_timestamp) as month,
        max(case when event_type = 'search' then 1 else 0 end) as did_search,
        max(case when event_type = 'book_appointment' then 1 else 0 end) as did_book,
        max(case when event_type = 'view_doctor' then 1 else 0 end) as did_view,
        max(case when event_type in ('search', 'view_doctor') then 1 else 0 end) as did_both,
    from {{ ref('fct_events') }}
    group by 1, 2

)

select
    month,
    sum(did_search) as patients_searched,
    sum(did_book) as patients_booked,
    1.0 * sum(did_book) / nullif(sum(did_search), 0) as conversion_rate_search,
    1.0 * sum(did_book) / nullif(sum(did_view), 0) as conversion_rate_view,
    1.0 * sum(did_book) / nullif(sum(did_both), 0) as conversion_rate_both
from patient_funnel
group by 1
order by 1