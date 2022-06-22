{{
  config(
    materialized='table'
  )
}}

with base as (
    SELECT
        u.user_id
        , u.first_name
        , u.last_name
        , u.email
        , u.phone_number
        , a.address
        , a.zipcode
        , a.state
        , a.country
        , u.created_at
        , u.updated_at
    from {{ ref('stg_users') }} as u
    left join {{ ref('stg_addresses') }} as a
        on u.address_id = a.address_id
)

select * from base