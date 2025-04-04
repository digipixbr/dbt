select
    -- generate surrogate 'event' ID
    {{
        dbt_utils.generate_surrogate_key(
            [
                "event_timestamp",
                "event_name",
                "user_pseudo_id",
                'ARRAY_TO_STRING(ARRAY(SELECT CONCAT(p.key, "::", COALESCE(p.value.string_value, CAST(p.value.int_value AS STRING), CAST(p.value.float_value AS STRING), CAST(p.value.double_value AS STRING))) FROM UNNEST(event_params) AS p), "; ")',
            ]
        )
    }}
    as event_id,
    -- partitioning key:
    parse_date('%Y%m%d', event_date) as event_date,  -- equivalent to _table_suffix; convert to DATE type
    -- other fields:
    timestamp_micros(event_timestamp) as event_timestamp,
    event_name,
    event_params,  -- Structure { key, value }
    event_previous_timestamp,
    event_value_in_usd,
    event_bundle_sequence_id,
    event_server_timestamp_offset,
    user_pseudo_id as client_id,
    user_id,
    privacy_info,  -- Structure { analytics_storage, ads_storage, users_transient_token }
    user_properties,  -- Structure { key, value }
    user_first_touch_timestamp,
    user_ltv,  -- Structure { revenue, currency }
    device,  -- Structure containing many fields
    geo,  -- Structure containing many fields
    app_info,  -- Structure containing many fields
    traffic_source,  -- Structure { name, medium, source}
    stream_id,
    platform,
    event_dimensions,  -- Structure { hostname }
    ecommerce,  -- Structure containing many fields
    items,  -- Structure containing many fields
from {{ source("ga_fotoregistro", "events") }}
