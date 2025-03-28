with 

source as (

    select * from {{ source('dpxdb_workflow', 'RefacaoApprovalReason') }}

),

renamed as (

    select
        refacaoapprovalreasonid,
        updatedate,
        updateuserid,
        insertuserid,
        name,
        insertdate,
        status

    from source

)

select * from renamed
