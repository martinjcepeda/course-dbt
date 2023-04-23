{{
  config(
    materialized='table'
  )
}}

with
  product_numbers as (
    select
      product_id,
      count(distinct order_id) as total_orders,
      SUM(quantity) as total_product_orders
    from
      {{ ref( 'stg_order_items') }}
    group by
      1
  )
select
  p.product_id,
  name,
  price,
  inventory,
  pn.total_orders,
  pn.total_product_orders,
  pn.total_product_orders * price as total_product_revenue
from
  {{ ref( 'stg_products') }} p
  left join product_numbers pn on pn.product_id = p.product_id