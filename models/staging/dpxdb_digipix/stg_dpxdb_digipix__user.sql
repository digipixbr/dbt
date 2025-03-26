with 

source as (

    select * from {{ source('dpxdb_digipix', 'user') }}

),

renamed as (

    select
        userid,
        updatedate,
        extension,
        updateuserid,
        insertuserid,
        insertdate,
        name,
        login,
        department,
        email,
        userconfigdigipixid,
        status,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
