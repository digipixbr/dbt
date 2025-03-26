with 

source as (

    select * from {{ source('dpxdb_workflow', 'productionbatchitem') }}

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
        productionbatchid,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
