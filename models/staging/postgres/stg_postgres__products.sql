select
    -- ids
    id_produto as product_id,
    -- strings
    nome as product_name
    -- numerics
    -- booleans
    -- dates
    -- timestamps
from {{ source("postgres_public", "produto") }}