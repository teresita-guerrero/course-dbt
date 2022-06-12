# DBT Project week 1

### How many users do we have?

``` sql
select 
count(distinct user_id)
from dbt_teresita_g.src_users
```
> 130

### On average, how many orders do we receive per hour?

```sql
with orders_per_hour as (
  select
    date_trunc('hour', created_at) as order_hour
    , count(distinct order_id) as orders
  from dbt_teresita_g.src_orders
  group by 1
)
select round(avg(orders), 2) as avg_orders_per_hour
from orders_per_hour
```
> 7.52

### On average, how long does an order take from being placed to being delivered?

```sql
with base as (
  select 
    sum (delivered_at - created_at) as delivery_time,
    count(*) qty_deliveries 
    from dbt_teresita_g.src_orders
    where delivered_at is not null
)
select delivery_time/qty_deliveries
from base
```
> 3 days 21:24:11.803279

### How many users have only made one purchase? Two purchases? Three+ purchases?

```sql
with base as (
  select user_id, 
  case 
    when count(*) = 1 then ' 1 order'
    when count(*) = 2 then '2 orders'
    when count(*) >= 3 then '3+ orders' 
  end total_orders
  from dbt_teresita_g.src_orders
  group by user_id
)
select 
  total_orders
  , count(user_id) as num_users
from base
group by total_orders
order by 1
```
| total_orders   |  num_users |
|----------------|-----------:|
| 1 order        | 25         |
| 2 orders       | 28         |
| 3+ orders      | 71         |

### On average, how many unique sessions do we have per hour?

```sql
with base as 
(
  select 
    date_trunc('hour', created_at) as hour
    , count(distinct session_id) AS num_sessions
  FROM dbt_teresita_g.src_events
  GROUP BY hour
)
select 
  round(AVG(num_sessions),2) AS avg_sessions
from base
```
> 16.33