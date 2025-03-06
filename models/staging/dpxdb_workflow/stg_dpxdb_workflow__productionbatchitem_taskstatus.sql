with 

source as (

    select * from {{ source('dpxdb_workflow', 'productionbatchitem_taskstatus') }}

),

renamed as (

    select
        productionbatchitem_taskstatusid,
        updatedate,
        updateuserid,
        insertuserid,
        insertdate,
        name,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
