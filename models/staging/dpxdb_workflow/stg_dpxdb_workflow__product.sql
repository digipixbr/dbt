with 

source as (

    select * from {{ source('dpxdb_workflow', 'Product') }}

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
        unitaryimposition

    from source

)

select * from renamed
