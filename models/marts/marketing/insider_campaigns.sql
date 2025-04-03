with
    analytics as (
        select * from {{ ref("stg_insider__Email_Campaign_Analytics___Summary") }}
    ),

    campaigns as (select * from {{ ref("stg_insider__Email_Campaign_List") }}),

    insider_campaigns as (
        select *
        from analytics
        left join campaigns using (campaign_id)
        order by start_time_utc desc, campaign_id desc
    )

select *
from insider_campaigns
