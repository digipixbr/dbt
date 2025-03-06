with 

source as (

    select * from {{ source('dpxdb_digipix', 'salesorder') }}

),

renamed as (

    select
        salesorderid,
        insertdate,
        internalproductiondate,
        subtotaldiscount,
        updatedate,
        approvalreasonid,
        originalsystemcarrierid,
        storeid,
        shippingdiscount,
        customershippingperiod_calendardays,
        customershippingperiod_withoutproduction,
        customershippingdate,
        updateuserid,
        shipping,
        photoindigo,
        customerproductiondate,
        workflowimportdate,
        originalsystemreference,
        subtotal,
        partnersalesorderid,
        insertuserid,
        customerproductionperiod,
        approvaldate,
        orderdate,
        singleitemorder,
        internalproductionperiod,
        package,
        applicationid,
        accountingadjustment,
        salescustomerid,
        customershippingperiod,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
