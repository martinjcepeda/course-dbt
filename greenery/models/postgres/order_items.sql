{{
  config(
    materialized='table'
  )
}}

SELECT 
    *
FROM {{ source('postgres', 'order_items') }}
