with 

source as (

    select * from {{ source('dpxdb_workflow', 'productionbatchitem_taskactual') }}

),

renamed as (

    select
        productionbatchitem_taskactualid,
        datecheck,
        updatedate,
        productid,
        updateuserid,
        isrefacao,
        partid,
        insertdate,
        speciallabelid,
        check,
        dateend,
        productionbatchitem_taskstatusid,
        resourcepeoplequantity,
        previousrefacaorequestproductionbatchitem_taskstatusid,
        daterefacao,
        defaultprinterid,
        productionbatchitemid,
        datestart,
        insertuserid,
        taskid,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
