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

| Product Name        | Orders | Views | Conversion |
|---------------------|--------|-------|------------|
| String of pearls    | 39     | 64    | 0.609375   |
| Arrow Head          | 35     | 63    | 0.555556   |
| Pilea Peperomioides | 28     | 59    | 0.474576   |
| Money Tree          | 26     | 56    | 0.464286   |
| Angel Wings Begonia | 24     | 61    | 0.393443   |
| Boston Fern         | 26     | 63    | 0.412698   |
| Pink Anthurium      | 31     | 74    | 0.418919   |
| Calathea Makoyana   | 27     | 53    | 0.509434   |
| Alocasia Polly      | 21     | 51    | 0.411765   |
| Snake Plant         | 29     | 73    | 0.39726    |
| Orchid              | 34     | 75    | 0.453333   |
| Spider Plant        | 28     | 59    | 0.474576   |
| Monstera            | 25     | 49    | 0.510204   |
| Pothos              | 21     | 61    | 0.344262   |
| Peace Lily          | 27     | 66    | 0.409091   |
| ZZ Plant            | 34     | 63    | 0.539683   |
| Fiddle Leaf Fig     | 28     | 56    | 0.5        |
| Devil's Ivy         | 22     | 45    | 0.488889   |
| Philodendron        | 30     | 62    | 0.483871   |
| Birds Nest Fern     | 33     | 78    | 0.423077   |
| Cactus              | 30     | 55    | 0.545455   |
| Majesty Palm        | 33     | 67    | 0.492537   |
| Dragon Tree         | 29     | 62    | 0.467742   |
| Rubber Plant        | 28     | 54    | 0.518519   |
| Bird of Paradise    | 27     | 60    | 0.45       |
| Jade Plant          | 22     | 46    | 0.478261   |
| Aloe Vera           | 32     | 65    | 0.492308   |
| Bamboo              | 36     | 67    | 0.537313   |
| Ponytail Palm       | 28     | 70    | 0.4        |
| Ficus               | 29     | 68    | 0.426471   |

with
  total_sessions as (
    select
      *
    from
      DEV_DB.DBT_MCEPEDAINSTAWORKCOM.FCT_CONVERSION
  ),
  product_orders as (
    select
      *
    from
      total_sessions
    where
      order_id IS NOT NULL
      and event_type = 'checkout'
  )
select
  ts.product_name,
  COUNT(DISTINCT po.session_ID) as orders,
  COUNT(DISTINCT ts.session_ID) as views,
  COUNT(DISTINCT po.session_ID) / COUNT(DISTINCT ts.session_ID) as conversion
from
  total_sessions ts
  left join product_orders po on po.product_name = ts.product_name
group by
  1