with 

source as (

    select * from {{ source('dpxdb_workflow', 'Part') }}

),

renamed as (

    select
        partid,
        updatedate,
        updateuserid,
        insertuserid,
        insertdate,
        name,
        status,
        referenceproductid

    from source

)

select * from renamed
