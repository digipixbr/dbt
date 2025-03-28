with 

source as (

    select * from {{ source('dpxdb_workflow', 'ProductionBatchItem_TaskActual_Resource') }}

),

renamed as (

    select
        productionbatchitem_taskactualid,
        resourceid,
        updatedate,
        totalquantity,
        updateuserid,
        insertuserid,
        insertdate

    from source

)

select * from renamed
