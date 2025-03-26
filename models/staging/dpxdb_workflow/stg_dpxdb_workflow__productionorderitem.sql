with 

source as (

    select * from {{ source('dpxdb_workflow', 'productionorderitem') }}

),

renamed as (

    select
        productionorderitemid,
        border,
        updatedate,
        imageid,
        productid,
        productionorderid,
        updateuserid,
        resourcematerialattributevalueid,
        pendingproductionbatch,
        insertdate,
        originalsystemreference,
        originalsystemproducttypereference,
        sample,
        fit,
        photoproducttheme,
        fotolivroid,
        covercolor,
        pages,
        itemunitweight,
        ignoretaskactivationpercent,
        imagefile,
        insertuserid,
        applicationid,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
