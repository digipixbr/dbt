select
    -- surrogate key (unique for each event/param pair):
    {{ dbt_utils.generate_surrogate_key(["event_id", "params.key"]) }} as param_id,
    -- event data:
    event_id,
    event_date,
    event_timestamp,
    client_id,
    user_id,
    event_name,
    -- fields extracted from various struct fields:
    geo.continent as continent,
    geo.country as country,
    device.category as device_type,
    device.web_info.browser as browser,
    device.operating_system as operating_system,
    traffic_source.source as traffic_source,
    traffic_source.name as traffic_campaign,
    traffic_source.medium as traffic_medium,
    -- cross-joined parameter key/value pairs:
    params.key as param_key,
    coalesce(
        params.value.string_value,
        cast(params.value.int_value as string),
        cast(params.value.float_value as string),
        cast(params.value.double_value as string)
    ) as param_value,
from
    (  -- subquery allows us to efficiently build this table incrementally
        select * from {{ ref("stg_analytics__events") }}
    )
left join
    -- unwrap the event parameters: every event/parameter pair is a record
    -- (plus any events without parameters, hence LEFT JOIN)
    unnest(event_params) as params
