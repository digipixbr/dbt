with
    utm_by_session as (
        select
            user_pseudo_id,
            ga_session_id,
            ga_source as ga_source_u,
            event_timestamp,
            row_number() over (
                partition by user_pseudo_id, ga_session_id order by event_timestamp
            ) as rn
        from {{ ref("intermediate_google_analytics_fr__events_wide_format") }}
        where event_name is not null
    ),

    purchases as (
        select *
        from {{ ref("intermediate_google_analytics_fr__events_wide_format") }}
        where event_name = 'purchase'
    )

select p.*, u.ga_source_u
from purchases p
left join
    utm_by_session u
    on p.user_pseudo_id = u.user_pseudo_id
    and p.ga_session_id = u.ga_session_id
