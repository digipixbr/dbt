select
    date,
    transaction_id,
    ifnull(session_source, first_user_source) as session_source,
    ifnull(session_medium, first_user_medium) as session_medium,
    ifnull(session_campaign_name, first_user_campaign_name) as session_campaign_name,
    sum(purchases) as purchases

from
    (
        select
            event_date as date,
            ecommerce.transaction_id as transaction_id,
            -- Session source
            (
                select value.string_value
                from unnest(event_params)
                where key = 'source'
                limit 1
            ) as session_source,
            -- Fallback: first user source
            traffic_source.source as first_user_source,
            -- Session medium
            (
                select value.string_value
                from unnest(event_params)
                where key = 'medium'
                limit 1
            ) as session_medium,
            -- Fallback: first user medium
            traffic_source.medium as first_user_medium,
            -- Session campaign name
            (
                select value.string_value
                from unnest(event_params)
                where key = 'campaign'
                limit 1
            ) as session_campaign_name,
            -- Fallback: first user campaign name
            traffic_source.name as first_user_campaign_name,
            -- Purchase count
            countif(event_name = 'purchase') as purchases

        from {{ source("ga_fotoregistro", "events") }}
        where ecommerce.transaction_id is not null
        group by
            date,
            transaction_id,
            session_source,
            first_user_source,
            session_medium,
            first_user_medium,
            session_campaign_name,
            first_user_campaign_name
    )

group by date, transaction_id, session_source, session_medium, session_campaign_name
