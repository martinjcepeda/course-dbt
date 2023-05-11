{{
  config(
    materialized='table'
  )
}}
select
  o.order_id,
  oi.product_id,
  p.name,
  oi.quantity,
  o.user_id,
  u.first_name, 
  u.last_name,
  promo_id,
  o.address_id,
  o.created_at,
  shipping_cost,
  order_total,
  tracking_id,
  shipping_service,
  estimated_delivery_at,
  delivered_at,
  status
from {{ ref( 'stg_orders') }} o
  left join {{ ref( 'stg_order_items') }} oi on oi.order_id = o.order_id
  left join {{ ref('stg_users')}} u ON u.user_id = o.user_id
  left join {{ ref('stg_products')}} p ON p.product_id = oi.product_id