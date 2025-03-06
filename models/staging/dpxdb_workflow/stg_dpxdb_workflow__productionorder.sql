with 

source as (

    select * from {{ source('dpxdb_workflow', 'productionorder') }}

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
        orderdate,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
