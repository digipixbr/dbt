with 

source as (

    select * from {{ source('dpxdb_workflow', 'RefacaoRequest_Part') }}

),

renamed as (

    select
        partid,
        refacaorequestid,
        insertuserid,
        insertdate

    from source

)

select * from renamed
