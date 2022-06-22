{{
  config(
    materialized='table'
  )
}}

with base as (
    SELECT
        event_id
        , session_id
        , user_id
        , product_id
        , page_url
        , created_at
    from {{ ref('stg_events') }}
    where event_type = 'page_view'
)

select * from base