## Week 3 Project 

##### Conversion Rate 
Total Sessions = 578 
Checkout Sessions = 361 
Conversion Rate = 0.624

with
  total_sessions as (
    select
      session_id,
      event_type,
      product_name,
      count(distinct session_id) as total_count
    from
      DEV_DB.DBT_MCEPEDAINSTAWORKCOM.FCT_CONVERSION
    group by
      1,
      2,
      3
  ),
  checkout_sessions as (
    select
      session_id,
      product_name
    from
      total_sessions
    where
      event_type = 'checkout'
  )
select
  count(distinct ts.session_id) as total_sessions,
  count(distinct cs.session_id) as checkout_sessions,
  count(distinct cs.session_id) / count(distinct ts.session_id) as conversion_rate
from
  total_sessions ts
  left join checkout_sessions cs on cs.session_id = ts.session_id

##### Conversion Rate by Product 

