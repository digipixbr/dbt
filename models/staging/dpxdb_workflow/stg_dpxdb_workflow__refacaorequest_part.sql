with 

source as (

    select * from {{ source('dpxdb_workflow', 'refacaorequest_part') }}

),

renamed as (

    select
        partid,
        refacaorequestid,
        insertuserid,
        insertdate,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
