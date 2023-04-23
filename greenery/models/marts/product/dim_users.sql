{{
  config(
    materialized='table'
  )
}}
with
  total_orders as (
    select
      user_id,
      count(distinct order_id) over (
        partition by
          user_id
      ) as user_orders
    from
      {{ ref('stg_orders') }}
    where
      order_id IS NOT NULL
  ),
  order_summary as (
    select
      user_id,
      SUM(user_orders) as order_sum
    from
      total_orders
    group by
      1
  )
select
  os.user_id, 
  u.first_name, 
  u.last_name, 
  u.email,
  u.country, 
  u.state, 
  u.zipcode,
  u.created_at, 
  u.updated_at,
  order_sum as total_orders
from
  order_summary os

left join {{ ref('int_users') }} u on u.user_id = os.user_id
order by first_name asc