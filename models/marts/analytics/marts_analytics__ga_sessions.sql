select  -- deduplicate session-scoped data ...
    distinct  -- window functions will produce multiple equivalent records
    session_id,
    client_id,
    -- apply window calculations
    last_value(geo_country) over (session_window) as geo_country,
    last_value(device_type) over (session_window) as device_type,
    last_value(device_browser) over (session_window) as device_browser,
    last_value(device_operating_system) over (session_window) as device_operating_system,
    first_value(event_date) over (session_window) as session_date,
    first_value(event_timestamp) over (session_window) as session_initiated,
    first_value(page_location) over (session_window) as landing_page,
    last_value(page_location) over (session_window) as exit_page,
    first_value(traffic_source) over (session_window) as traffic_source,
    first_value(traffic_campaign) over (session_window) as traffic_campaign,
    first_value(traffic_medium) over (session_window) as traffic_medium,
    first_value(traffic_referrer) over (session_window) as traffic_referrer,
from {{ ref("intermediate_google_analytics_fr__events_wide_format") }}
window  --
    session_window as (
        partition by session_id
        order by event_timestamp
        rows between unbounded preceding and unbounded following
    )
