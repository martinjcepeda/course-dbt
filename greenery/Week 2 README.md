## Week 2 Project 

##### Question 1 - What is our user repeat rate?

Repeat rate is ~80%
```
with
  total_orders as (
    select
      user_id,
      count(distinct order_id) over (
        partition by
          user_id
      ) as user_orders
    from
      DEV_DB.DBT_MCEPEDAINSTAWORKCOM.ORDERS
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
  SUM(
    case
      when order_sum >= 2 then 1
      else 0
    end
  ) / count(user_id) as repeat_rate
from
  order_summary
```

#### Question 2 - What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

Good indicators that a user will likely purchase again: 
- Long-term customers, the users who have repeat purchases already are probably more likely to buy again. This can be the case with seasonal or recurring purchase items (i.e. household supplies)
- Quick delivery time is another likely leading indicator for a repeat purchase. This factors in customer satisfaction. 
- Promotional use / discount might indicate that a user has interest in the product and will repeat a purchase 

Possible indicators that a user will not purchase again: 
- Historically old user, but no purchases since creation. This might indicate a weak buying intent. 
- Long delivery times or lost delivery is a negative signal for repeat purchases. 

I would also be interested in doing an EDA on demographic data covering gender, location, income, and other attributes. 


