{{
  config(
    materialized='table'
  )
}}

SELECT
    order_id
    , product_id
    , quantity
status
FROM {{ source('greenery', 'order_items') }}