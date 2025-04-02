with
    analytics as (select * from {{ ref("stg_insider__Email_Campaign_Analytics___Summary") }}),

    campaigns as (select * from {{ ref("stg_insider__Email_Campaign_List") }}),

    insider_campaigns as (
        select *
            --count(*) as order_items_qty,
            --round(sum(orders.order_value), 2) as order_total_value
        from analytics
        left join campaigns using (campaign_id)
        --where orders.order_date is not null
        --group by orders.shop_id, shops.shop_name, orders.order_date
        order by start_time_utc DESC, campaign_id DESC
    )

select *
from insider_campaigns
