{{
  config(
    materialized='table'
  )
}}

with table_init as (
SELECT 
  e.event_id,
  e.session_id, 
  e.user_id, 
  e.page_url, 
  e.created_at,
  e.event_type, 
  e.order_id, 
  e.product_id, 
  o.name as product_name
FROM {{ ref('int_session_events') }} e 
LEFT JOIN {{ ref('int_orders') }} o on o.order_id = e.order_id
) 

select 

  e.event_id,
  e.session_id, 
  e.user_id, 
  e.page_url, 
  e.created_at,
  e.event_type, 
  e.order_id, 
  e.product_id, 
  COALESCE(name, o.name) as product_name
FROM table_init e 
LEFT JOIN {{ ref('int_orders') }} o on o.order_id = e.order_id