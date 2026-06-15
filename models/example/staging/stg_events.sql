with ranked as (

    select *,
           row_number() over (
               partition by event_id
               order by event_id desc
           ) as rn

    from {{ source('raw', 'BBDD_events') }}

)

select 
    event_id,
    patient_id,
    event_type,
    strptime(event_timestamp, '%d/%m/%Y') as event_timestamp
from ranked
where rn = 1