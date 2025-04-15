select
    -- ids    
    coalesce(
        (
            select params.value.string_value
            from unnest(event_params) as params
            where params.key = 'event_id'
        ),
        null
    ) as event_id,
    user_pseudo_id,
    user_id,
    -- strings
    event_name,
    -- numerics
    -- booleans
    -- dates
    parse_date('%Y%m%d', event_date) as event_date,  -- partitioning key; equivalent to _table_suffix; 
    -- timestamps
    timestamp_micros(event_timestamp) as event_timestamp,
    -- structures
    collected_traffic_source,
    ecommerce,
    event_params,
    device,
    geo,
    traffic_source

from {{ source("ga_fotoregistro", "events") }}
