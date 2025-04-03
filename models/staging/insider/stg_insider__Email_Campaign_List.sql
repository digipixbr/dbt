with

    source as (select * from {{ source("insider", "Email_Campaign_List") }}),

    renamed as (

        select
            -- _airbyte_raw_id,
            -- _airbyte_extracted_at,
            -- _airbyte_meta,
            -- _airbyte_generation_id,
            id as campaign_id,
            name,
            tags,
            type,
            subject,
            utm_medium,
            utm_source,
            utm_status,
            senderdomain as sender_domain,
            starttimeutc as start_time_utc,
            utm_campaign

        from source

    )

select *
from renamed
