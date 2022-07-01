{{ 
    config(
        materialized = 'table'
    )  
}}

with base as (
    select
        session_id
        , user_id
        , min(created_at) as session_start
        , max(created_at) as session_end
        , count(event_id) as events_per_session
        , count(distinct order_id) as orders_placed
        , count(distinct product_id) as products_purchased
        {% for event_type in get_events() %}
        , sum(case 
            when event_type = '{{event_type[0]}}' 
            then 1 else 0 end) 
            as {{event_type[0]}}
	    {% endfor %} 
    from  {{ ref('fact_events') }}
    group by 1, 2
)

select
    *
from base