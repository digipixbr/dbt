select
    -- ids
    id_loja as shop_id,

    -- strings
    nome as shop_name,

-- numerics
-- booleans
-- dates
-- timestamps
from {{ source("postgres_public", "loja") }}
where virtual = 0
