select
    -- ids
    id_loja as shop_id,
    id_pedido as order_id,
    id_usuario as user_id,

    -- strings
    -- numerics
    round(preco + frete - desconto - coalesce(adiant_receita, 0), 2) as order_value,

    -- booleans
    -- dates
    date(
        {{ dbt_date.convert_timezone("dt_liberacao", "America/Sao_Paulo", "UTC") }}
    ) as order_date

-- timestamps
from {{ source("postgres_public", "pedido") }}
where dt_liberacao is not null

union all

select
    -- ids
    id_loja as shop_id,
    id_pedido as order_id,
    id_usuario as user_id,

    -- strings
    -- numerics
    round(preco + frete - desconto - coalesce(adiant_receita, 0), 2) as order_value,

    -- booleans
    -- dates
    date(
        {{ dbt_date.convert_timezone("dt_liberacao", "America/Sao_Paulo", "UTC") }}
    ) as order_date

-- timestamps
from {{ source("postgres_archive", "pedido") }}
where dt_liberacao is not null
