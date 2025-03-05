select
    -- ids
    id_loja as shop_id,

    -- strings
    nome as shop_name,

-- numerics
-- booleans
-- dates
-- timestamps
from {{ source("postgre_public", "lojas") }}
where virtual = 0
