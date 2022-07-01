{{
  config(
    materialized='table'
  )
}}

with base as (
    select
        distinct event_type
    from {{ ref('stg_events') }}
)
select
    *
from base