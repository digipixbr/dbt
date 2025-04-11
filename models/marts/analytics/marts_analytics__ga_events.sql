select
    event_id,
    event_date,
    event_timestamp,
    event_name,
    client_id,
    session_id,
    user_id,
    regexp_extract(
        page_location, r'(?:[a-zA-Z]+://)?(?:[a-zA-Z0-9-.]+){1}(/[^\?#;&]+)'  -- any protocol, any host, capture /path
    ) as page_path,
    regexp_extract(page_location, r'\?([^#]*)') as query_params,
    regexp_extract(page_location, r'#(.*)') as fragment,
from {{ ref("intermediate_google_analytics_fr__events_wide_format") }}
