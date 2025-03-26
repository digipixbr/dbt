with 

source as (

    select * from {{ source('dpxdb_workflow', 'task') }}

),

renamed as (

    select
        taskid,
        tasktypeid,
        updatedate,
        resourcepeoplequantityrecurrenttask,
        updateuserid,
        insertuserid,
        insertdate,
        name,
        description,
        team,
        status,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
