with
    sessions_with_utm as (
        select user_pseudo_id, ga_source, ga_session_id
        from {{ ref("intermediate_google_analytics_fr__events_wide_format") }}
        where event_name = 'session_start'
    )

select p.* except(ga_source), s.ga_source
from {{ ref("intermediate_google_analytics_fr__events_wide_format") }} p
left join
    sessions_with_utm s
    on p.user_pseudo_id = s.user_pseudo_id
    and p.ga_session_id = s.ga_session_id
where p.event_name = 'purchase'


