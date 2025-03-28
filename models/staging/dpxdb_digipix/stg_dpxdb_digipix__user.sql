with 

source as (

    select * from {{ source('dpxdb_digipix', 'User') }}

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
        status

    from source

)

select * from renamed
