{{
  config(
    materialized='table'
  )
}}

SELECT
    product_id
    , name as product_name
    , price
    , inventory
status
FROM {{ source('greenery', 'products') }}