with

    source as (

        select * from {{ source("insider", "Email_Campaign_Analytics___Summary") }}

    ),

    renamed as (

        select
            --_airbyte_raw_id,
            --_airbyte_extracted_at,
            --_airbyte_meta,
            --_airbyte_generation_id,
            sent,
            blocks,
            bounce,
            revenue,
            openrate as open_rate,
            spamdrop as spam_drop,
            delivered,
            bouncedrop as bounce_drop,
            bouncerate as bounce_rate,
            campaignid as campaign_id,
            totalopens as total_opens,
            conversions,
            invaliddrop as invalid_drop,
            spamreports as spam_reports,
            systemdrops as system_drops,
            totalclicks as total_clicks,
            uniqueopens as unique_opens,
            unsubscribe,
            deliveryrate as delivery_rate,
            sendingdrops as sending_drops,
            uniqueclicks as unique_clicks,
            frequencydrop as frequency_drop,
            conversionrate as conversion_rate,
            clicktoopenrate as click_to_open_rate,
            uniqueuseropens as unique_user_opens,
            unsubscribedrop as unsubscribe_drop,
            clickthroughrate as click_through_rate,
            linkclickactivity as link_click_activity,
            uniquemachineopens as unique_machine_opens,
            uniqueuseropenrate as unique_user_open_rate,
            uniquemachineopenrate as unique_machine_open_rate

        from source

    )

select *
from renamed
