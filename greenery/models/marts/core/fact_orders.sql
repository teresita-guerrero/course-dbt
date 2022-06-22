{{
  config(
    materialized='table'
  )
}}

with base as (
    SELECT
        o.order_id
        , o.user_id
        , oi.product_id
        , oi.quantity
        , p.promo_discount
        , p.promo_status
        , o.order_cost
        , o.shipping_cost
        , o.order_total
        , o.tracking_id
        , o.shipping_service
        , o.estimated_delivery_at
        , o.delivered_at
        , o.order_status
        , o.created_at
    from {{ ref('stg_orders') }} as o
    left join {{ ref('stg_order_items') }} as oi
        on o.order_id = oi.order_id
    left join {{ ref('stg_promos') }} as p
        on o.promo_id = p.promo_id
)

select * from base