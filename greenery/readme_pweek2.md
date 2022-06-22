# DBT Project week 2

### What is our user repeat rate?
```sql
with base as (
  select
    user_id
    , count(distinct order_id) as user_orders
  from dbt_teresita_g.stg_orders
  group by user_id
),
user_purchases as (
  select
    user_id
    , (user_orders = 1)::int as one_purchase
    , (user_orders >= 2)::int as two_purchases
    , (user_orders >= 1)::int as three_purchases
  from base
)
select 
  sum(two_purchases)::float / count(distinct user_id) as repeat_rate
from user_purchases
```
> 0.7983870967741935

### Explain the marts models you added. Why did you organize the models in the way you did?
> I added the users and products dimensions as I think they are entities and behave like a catalog.
> The facts that I added are growing constantly, and have user_id or product_id to be able to join to the dimensions in order to get full information
> I haven't have the chance to look at the project week 4 to see if I am in the right direction :P

### What assumptions are you making about each model? (i.e. why are you adding each test?)
> I assumed that every id in dim and fact models are unique and cannot be null. 
> I thought in more ways to test columns values but I haven't the time to implement this. I think that I can add more tests for the next week.

### Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
> Yes. I created the fact_orders but I believe it wasn't created correctly. I reviewed the data and my assumption of a unique order_id does not work here.
