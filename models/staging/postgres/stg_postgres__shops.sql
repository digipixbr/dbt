with
    source as (select * from {{ source("postgres_public", "loja") }}),

    renamed as (

        select
            -- ids
            id_loja as shop_id,

            -- strings
            nome as shop_name,

            -- numerics
            -- booleans
            -- dates
            -- timestamps
        from source
        where virtual = 0

    )

select *
from renamed
