WITH base_events AS (
  SELECT
    user_pseudo_id,
    (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS session_id,
    COALESCE(
      (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'source'),
      (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'utm_source'),
      traffic_source.source
    ) AS utm_source,
    event_name,
    TIMESTAMP_MICROS(event_timestamp) AS event_timestamp,
    ecommerce.purchase_revenue AS revenue
  FROM (
    SELECT * FROM {{ source('ga_fotoregistro', 'events') }}
    WHERE _TABLE_SUFFIX IN ('20250411', '20250412')
  )
  WHERE TIMESTAMP_MICROS(event_timestamp) BETWEEN TIMESTAMP('2025-04-11 03:00:00 UTC')  
      AND TIMESTAMP('2025-04-12 02:59:59 UTC')
),

-- Get first UTM source per session
session_utm AS (
  SELECT
    user_pseudo_id,
    session_id,
    ARRAY_AGG(utm_source IGNORE NULLS ORDER BY event_timestamp)[OFFSET(0)] AS utm_source
  FROM base_events
  GROUP BY user_pseudo_id, session_id
),

-- Aggregate metrics per session
session_metrics AS (
  SELECT
    user_pseudo_id,
    session_id,
    COUNTIF(event_name = 'purchase') AS transaction_count,
    SUM(CASE WHEN event_name = 'purchase' THEN revenue ELSE 0 END) AS total_revenue
  FROM base_events
  WHERE session_id IS NOT NULL
  GROUP BY user_pseudo_id, session_id
),

-- Get last known non-direct UTM source per user
user_last_utm AS (
  SELECT
    user_pseudo_id,
    ARRAY_AGG(utm_source IGNORE NULLS ORDER BY event_timestamp DESC)[OFFSET(0)] AS last_known_utm_source
  FROM base_events
  WHERE utm_source IS NOT NULL AND utm_source NOT IN ('(direct)', 'unknown')
  GROUP BY user_pseudo_id
),

-- Combine session and user attribution
sessions_combined AS (
  SELECT
    COALESCE(su.utm_source, ula.last_known_utm_source, 'unknown') AS utm_source,
    sm.transaction_count,
    sm.total_revenue
  FROM session_metrics sm
  LEFT JOIN session_utm su
    ON sm.user_pseudo_id = su.user_pseudo_id
    AND sm.session_id = su.session_id
  LEFT JOIN user_last_utm ula
    ON sm.user_pseudo_id = ula.user_pseudo_id
)

-- ✅ Final result
SELECT
  utm_source,
  COUNT(*) AS sessions,
  SUM(transaction_count) AS total_transactions,
  SUM(total_revenue) AS total_revenue
FROM sessions_combined
GROUP BY utm_source
ORDER BY total_revenue DESC