{{
  config(
      materialized='table'
  )
}}

with base as (
    select
        user_id,
        count(distinct(order_id)) as total_orders,
        sum(quantity) as total_products_ordered,
        sum(order_total) as total_spent
    from {{ ref('int_user_orders') }}
    group by user_id
)

select * from base

