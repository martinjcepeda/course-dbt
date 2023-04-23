{{
  config(
    materialized='table'
  )
}}

SELECT 
    order_id
    , o.user_id
    , u.first_name
    , u.last_name
    , u.address
    , promo_id
    , address_id
    , created_at
    , order_cost
    , shipping_cost
    , order_total
    , tracking_id
    , shipping_service
    , estimated_delivery_at
    , delivered_at
    , status
FROM {{ ref( 'stg_orders') }}

LEFT JOIN {{ ref('int_users')}} u ON u.user_id = o.user_id
