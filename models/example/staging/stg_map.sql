select
    Valor_posible,
    Valor_mapeo
from {{ source('raw', 'map_status') }}