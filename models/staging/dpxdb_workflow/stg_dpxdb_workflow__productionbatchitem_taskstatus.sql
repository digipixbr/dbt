with 

source as (

    select * from {{ source('dpxdb_workflow', 'ProductionBatchItem_TaskStatus') }}

),

renamed as (

    select
        productionbatchitem_taskstatusid,
        updatedate,
        updateuserid,
        insertuserid,
        insertdate,
        name

    from source

)

select * from renamed
