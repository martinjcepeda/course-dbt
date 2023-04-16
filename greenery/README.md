Week 1 - Project Questions and Answers 

#### 1. How many users do we have? 

130 Users 

```
select 
count(distinct user_id)
from DEV_DB.DBT_MCEPEDAINSTAWORKCOM.USERS
```

#### 2. On average, how many orders do we receive per hour? 
7.52 orders per hour 

select
  AVG(order_id)
from
  (
    select
      DATE_TRUNC (hour, created_at),
      count(distinct order_id) as order_id
    from
      DEV_DB.DBT_MCEPEDAINSTAWORKCOM.orders
    group by
      1
    order by
      DATE_TRUNC (hour, created_at)
  ) 

#### 3. On average, how long does an order take from being placed to being delivered? 

3.89 days 

```
    select 
        order_id, 
        created_at, 
        delivered_at, 
        TIMESTAMPDIFF(DAY, created_at, delivered_at) AS difference, 
        AVG(TIMESTAMPDIFF(DAY, created_at, delivered_at)) OVER() AS avg_difference
    from DEV_DB.DBT_MCEPEDAINSTAWORKCOM.orders

    where delivered_at IS NOT NULL
```
#### 4. How many users have only made one purchase? Two purchases? Three+ purchases? 
- 25 users have made only 1 purchase 
- 28 users have made only 2 purchases 
- 71 users have made 3 or more purchases 

```
with
  order_sum as (
    select
      user_id,
      count(distinct order_id) over (
        partition by
          user_id
      ) as user_orders
    from
      DEV_DB.DBT_MCEPEDAINSTAWORKCOM.ORDERS
  )
select
  case
    when user_orders = 1 then '1'
    when user_orders = 2 then '2'
    when user_orders > 2 then '3+'
    else ''
  end as sum_class,
  count(distinct user_id)
from
  order_sum
group by
  1
ORDER BY 2
```

#### 5. On average, how many unique sessions do we have per hour? 

16.32 unique sessions per hour

select
  avg(session_count)
from
  (
    select
      DATE_TRUNC (hour, created_at),
      count(distinct session_id) as session_count
    from
      DEV_DB.DBT_MCEPEDAINSTAWORKCOM.events
    group by
      1
    order by
      DATE_TRUNC (hour, created_at)
  )