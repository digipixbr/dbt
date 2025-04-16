select
    -- traffic_source, -- Group by traffic source
    -- traffic_campaign,
    -- traffic_medium,
    -- lohn_utm_source,
    --ga_source,
    ga_source_u,
    --traffic_source,
    count(distinct session_id) as unique_sessions,  -- Count of unique session IDs
    round(sum(ecommerce_purchase_revenue), 2) as total_purchase_revenue,  -- Sum of purchase revenue
    count(distinct ecommerce_transaction_id) as unique_transactions  -- Count of unique transaction IDs
from {{ ref("intermediate_google_analytics_fr__utm") }}  -- Reference the staging table for GA4 events
where
    event_name = 'purchase' -- Filter for purchase events
    and 
    event_timestamp between timestamp('2025-04-11T00:00:00-00:00') and timestamp(
        '2025-04-11T23:59:59-00:00'
    )
-- and event_timestamp >= timestamp_add(current_timestamp(), interval -1 hour)
group by
    --traffic_source,--, 
    ga_source_u
   -- ga_source  -- Group by traffic source
order by total_purchase_revenue desc
