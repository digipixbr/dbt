with 

source as (

    select * from {{ source('dpxdb_workflow', 'productionbatchitem_taskactual_resource') }}

),

renamed as (

    select
        productionbatchitem_taskactualid,
        resourceid,
        updatedate,
        totalquantity,
        updateuserid,
        insertuserid,
        insertdate,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
