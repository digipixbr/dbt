with 

source as (

    select * from {{ source('dpxdb_workflow', 'part') }}

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
        referenceproductid,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
