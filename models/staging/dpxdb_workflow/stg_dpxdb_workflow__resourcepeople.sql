with 

source as (

    select * from {{ source('dpxdb_workflow', 'resourcepeople') }}

),

renamed as (

    select
        resourcepeopleid,
        resourceid,
        referenceuserid,
        updatedate,
        updateuserid,
        insertuserid,
        insertdate,
        name,
        proficiency,
        status,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
