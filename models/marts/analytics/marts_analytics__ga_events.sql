select
    event_id,
    event_date,
    event_timestamp,
    client_id,
    session_id,
    user_id,
    event_name,
    regexp_extract(
        page_location, r'(?:[a-zA-Z]+://)?(?:[a-zA-Z0-9-.]+){1}(/[^\?#;&]+)'  -- any protocol, any host, capture /path
    ) as page_path,
    regexp_extract(page_location, r'\?([^#]*)') as query_params,
    regexp_extract(page_location, r'#(.*)') as fragment,
    link_click_target,
from {{ ref("intermediate_analytics__events_wide_format") }}