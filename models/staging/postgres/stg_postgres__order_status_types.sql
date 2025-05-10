select
    -- ids
    id_tiposestadopedido as order_status_type_id,
    -- strings
    nome as status_label,
    -- numerics
    -- booleans
    -- dates
    -- timestamps
from {{ source("postgres_public", "tipos_estado_pedido") }}