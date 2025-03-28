with 

source as (

    select * from {{ source('dpxdb_workflow', 'ProductionOrder') }}

),

renamed as (

    select
        productionorderid,
        shippingcity,
        updatedate,
        pendingproductionbatch,
        insertdate,
        newfile,
        originalsystemreference,
        shippingaddresscomplement,
        ignoretaskactivationpercent,
        shippingcountry,
        shippingaddressnumber,
        insertuserid,
        deliverydate,
        shippingzip,
        package,
        updateuserid,
        weight,
        storeid,
        liberationdate,
        deadlinetoproducedate,
        deadlinetoproducedays,
        shippingaddress,
        shippingstate,
        shippingneighborhood,
        applicationid,
        orderdate

    from source

)

select * from renamed
