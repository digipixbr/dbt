select
    -- ids
    id_loja as shop_id,
    id_pedido as order_id,
    id_usuario as user_id,

    -- strings
    -- numerics
    round(preco + frete - desconto - adiant_receita, 2) as order_value,

    -- booleans
    -- dates
    date(dt_liberacao) as order_date

-- timestamps
from {{ source("postgre_public", "pedidos") }}
