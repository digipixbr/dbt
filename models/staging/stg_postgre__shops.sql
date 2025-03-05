with
    source as (select * from postgres_public.loja where virtual = 0),

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

    )

select *
from renamed
