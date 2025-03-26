with 

source as (

    select * from {{ source('dpxdb_workflow', 'product') }}

),

renamed as (

    select
        productid,
        updatedate,
        updateuserid,
        productstageid,
        insertdate,
        professionalpackage,
        preshipment,
        priority,
        producttypeid,
        insertuserid,
        name,
        status,
        unitaryimposition,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
