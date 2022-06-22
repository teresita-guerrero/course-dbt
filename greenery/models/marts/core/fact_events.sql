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
        , event_type
        , order_id
        , created_at
    from {{ ref('stg_events') }}
)

select * from base