select
    -- ids
    id_tiposestadopedido as order_status_type_id,
    id_pedido_item as order_item_id,
    -- strings
    -- numerics
    -- booleans
    -- dates
    -- timestamps
from {{ source("postgres_public", "pedido_estado") }}