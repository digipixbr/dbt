with 

source as (

    select * from {{ source('dpxdb_workflow', 'ResourcePeople') }}

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
        status

    from source

)

select * from renamed
