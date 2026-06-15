SELECT
  doctor_id,
  COUNT(CASE WHEN status = 'completed' THEN 1 END) * 1.0
  / COUNT(CASE WHEN status IN ('completed','cancelled','no_show') THEN 1 END) AS completion_rate
FROM {{ ref('fct_appointments') }}
GROUP BY doctor_id