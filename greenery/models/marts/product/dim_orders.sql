{{
  config(
    materialized='table'
  )
}}
select
  order_id,
  product_id,
  quantity,
  user_id,
  first_name, 
  last_name,
  address,
  promo_id,
  address_id,
  created_at,
  shipping_cost,
  order_total,
  tracking_id,
  shipping_service,
  estimated_delivery_at,
  delivered_at,
  status
from {{ ref( 'int_orders') }} 

  