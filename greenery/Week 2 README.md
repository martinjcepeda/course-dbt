## Week 2 Project 

##### What is our user repeat rate?

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

#### What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

Good indicators that a user will likely purchase again: 
- Long-term customers, the users who have repeat purchases already are probably more likely to buy again. This can be the case with seasonal or recurring purchase items (i.e. household supplies)
- Quick delivery time is another likely leading indicator for a repeat purchase. This factors in customer satisfaction. 
- Promotional use / discount might indicate that a user has interest in the product and will repeat a purchase 

Possible indicators that a user will not purchase again: 
- Historically old user, but no purchases since creation. This might indicate a weak buying intent. 
- Long delivery times or lost delivery is a negative signal for repeat purchases. 

I would also be interested in doing an EDA on demographic data covering gender, location, income, and other attributes. 

#### Explain the product mart models you added. Why did you organize the models in the way you did?
I only added one intermediate model - users, this was a simple join to get more user information in one place. I felt like the other staging models would require more complicated joins/transformations to have more value-add. I'd leave that to be a fact or dimension model. 

image.png

For my dimension models, I had two - orders and users. dim_orders showed a summary of the order information over time. dim_users built on top of the intermediate model and added order totals. 

For my fact models, I had fact_page_views and fact_products. 

Page Views: I summarized page views for each day there was a page view. 
Products: I summarized product revenue, count of orders each product was in, and total quantity per product ordered. 

I found the organization to be challenging and thought to keep it simple by organizing it this way. It was hard for me to visualize the correct DAG without understanding my business stakeholders and questions. I'd probably want to organize the directory in a cleaner fashion once I had a better understanding of stakeholders. 

#### What assumptions are you making about each model? (i.e. why are you adding each test?)
Most of my assumptions were around checking if the model had a null or incorrect number behavior (positive values). 

#### Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
I did run a test on created_at for users to check the data type and found that it wasn't a date or datetime. I amended the query to change the data type after seeing the test fail. 

#### Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

You could test freshness to see if sources are up-to-date and concurrently run the data tests. 

#### Run the product snapshot model using dbt snapshot and query it in snowflake to see how the data has changed since last week. Which products had their inventory change from week 1 to week 2? 
```
select * from DEV_DB.DBT_MCEPEDAINSTAWORKCOM.INVENTORY_SNAPSHOT
where DBT_VALID_TO IS NOT NULL
```
Products that changed: 
Pothos
Philodendron
Monstera
String of pearls