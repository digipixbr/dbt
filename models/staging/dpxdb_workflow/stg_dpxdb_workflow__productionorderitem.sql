with 

source as (

    select * from {{ source('dpxdb_workflow', 'ProductionOrderItem') }}

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
        applicationid

    from source

)

select * from renamed
