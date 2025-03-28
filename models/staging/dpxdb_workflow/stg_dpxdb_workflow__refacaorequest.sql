with 

source as (

    select * from {{ source('dpxdb_workflow', 'RefacaoRequest') }}

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
        refacaorequeststatusid

    from source

)

select * from renamed
