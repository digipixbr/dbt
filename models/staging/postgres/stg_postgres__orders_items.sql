select
    -- ids
    id_pedido as order_id,
    id_pedido_item as order_item_id,
    id_produto as product_id,
    -- strings
    -- numerics
    round(preco_unitario, 2) as order_item_unit_price,
    round(desconto_unitario, 2) as order_item_unit_discount,
    round(coalesce(adiant_receita_unitario, 0), 2) as order_item_unit_prepayment,
    num_copias as order_item_unit_quantity,
    -- booleans
    -- dates
    -- timestamps
from {{ source("postgres_public", "pedido_item") }}