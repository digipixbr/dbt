with 

source as (

    select * from {{ source('dpxdb_workflow', 'Task') }}

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
        status

    from source

)

select * from renamed
