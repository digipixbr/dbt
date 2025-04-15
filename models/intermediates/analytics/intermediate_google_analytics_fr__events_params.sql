select
    -- surrogate key (unique for each event/param pair):
    {{ dbt_utils.generate_surrogate_key(["event_id", "params.key"]) }} as param_id,
    -- event data:
    event_id,
    event_date,
    event_timestamp,
    user_pseudo_id,
    SAFE_CAST(user_id as INTEGER) as user_id,
    event_name,
    -- fields extracted from various struct fields:
    geo.country as geo_country,
    geo.region as geo_region,
    geo.city as geo_city,

    device.category as device_type,
    device.web_info.browser as device_browser,
    device.operating_system as device_operating_system,
    device.operating_system_version as device_operating_system_version,
    device.mobile_brand_name as device_mobile_brand_name,
    device.web_info.browser_version as device_browser_version,

    traffic_source.source as traffic_source,
    traffic_source.name as traffic_campaign,
    traffic_source.medium as traffic_medium,

    ecommerce.total_item_quantity as ecommerce_total_item_quantity,
    ecommerce.purchase_revenue as ecommerce_purchase_revenue,
    ecommerce.shipping_value as ecommerce_shipping_value,
    SAFE_CAST(ecommerce.transaction_id as INTEGER) as ecommerce_transaction_id,

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
        select * from {{ ref("stg_google_analytics_fr__events") }}
    )
left join
    -- unwrap the event parameters: every event/parameter pair is a record
    -- (plus any events without parameters, hence LEFT JOIN)
    unnest(event_params) as params
