with 

source as (

    select * from {{ source('ttps_ttps', 'productionorderitem') }}

),

renamed as (

    select
        productionorderitemid,
        productreferencecovermcid,
        productreferencecasemcid,
        productreferencedustmcid,
        amostra,
        productcase,
        productcategoryid,
        itemqty,
        productionorderid,
        numorderitem,
        productid,
        productreferenceid,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
