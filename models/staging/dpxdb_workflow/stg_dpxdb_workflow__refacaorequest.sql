with 

source as (

    select * from {{ source('dpxdb_workflow', 'refacaorequest') }}

),

renamed as (

    select
        refacaorequestid,
        updatedate,
        approvaldate,
        updateuserid,
        productionbatchitemid,
        insertuserid,
        insertdate,
        refacaoapprovalreasonid,
        planned,
        approvaluserid,
        refacaorequeststatusid,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
