select
    *,

    -- rename various fields output by the pivot operation below:
    val_shipping_tier as ecommerce_shipping_tier
    val_page_location as page_location,
    val_page_referrer as page_referrer,
    -- note we append the client ID to the session ID to ensure that the session ID
    -- will be globally unique:
    concat(val_ga_session_id, '-', client_id) as session_id,
    regexp_extract(val_page_location, 'utm_content=([^&]+)') as traffic_referrer,

from
    (  -- Subquery allows WHERE + PIVOT in the same expression
        select distinct  -- ensure we get just one row per event in the pivot output
            * except (param_id)
        from {{ ref("intermediate_google_analytics_fr__events_params") }}
    ) pivot (
        any_value(param_value) as val
        for param_key in (
            -- list of keys for which we want corresponding values:
            'ga_session_id', 'page_location', 'page_referrer', 'shipping_tier'
        )
    )

    /*
        batch_ordering_id
        campaign
        campaign_id
        content
        country
        currency
        entrances
        event_id
        first_field_id
        first_field_name
        first_field_type
        form_id
        form_length
        ga_session_id
        ignore_referrer
        item_list_name
        link_classes
        link_domain
        link_url
        marketing_tactic
        outbound
        page_location
        page_referrer
        page_title
        page_url
        percent_scrolled
        rounded_total_with_shipping
        session_engaged
        shipping
        shipping_tier
        source
        srsltid
        term
        transaction_id
        unique_search_term
        value
        zipcode
*/
    
