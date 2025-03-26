with 

source as (

    select * from {{ source('dpxdb_workflow', 'refacaoapprovalreason') }}

),

renamed as (

    select
        refacaoapprovalreasonid,
        updatedate,
        updateuserid,
        insertuserid,
        name,
        insertdate,
        status,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
