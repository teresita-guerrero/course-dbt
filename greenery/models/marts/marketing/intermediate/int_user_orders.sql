{{
  config(
    materialized='table'
  )
}}

with base as (
    select
        o.order_id,
        o.user_id,
        u.first_name,
        u.last_name,
        p.product_name,
        oi.quantity,
        o.created_at,
        o.delivered_at,
        o.order_cost,
        o.shipping_cost,
        o.order_total,
        o.shipping_service,
        o.order_status
    from {{ ref('stg_orders')}} as o
    left join {{ ref('stg_users') }} as u
        on o.user_id = u.user_id
    left join{{ ref('stg_addresses') }} as a
        on o.address_id = a.address_id
    left join {{ ref('stg_order_items') }} as oi
        on o.order_id = oi.order_id
    left join {{ ref('stg_products') }} as p
        on oi.product_id = p.product_id
)

select * from base