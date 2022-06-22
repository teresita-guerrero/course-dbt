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
FROM {{ source('greenery', 'products') }}