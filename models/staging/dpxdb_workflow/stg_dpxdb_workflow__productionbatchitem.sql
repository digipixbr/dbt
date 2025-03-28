with 

source as (

    select * from {{ source('dpxdb_workflow', 'ProductionBatchItem') }}

),

renamed as (

    select
        productionbatchitemid,
        updatedate,
        productionbatchitemstatusid,
        updateuserid,
        sendproductionbatchitemstatusiddate,
        insertdate,
        lastexecutedtaskdate,
        priority,
        productionorderitemid,
        sendproductionbatchitemstatusid,
        insertuserid,
        previousrefacaorequestproductionbatchitemstatusid,
        productionbatchitemstatusidtosend,
        productionbatchid

    from source

)

select * from renamed
