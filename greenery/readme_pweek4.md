# DBT Project week 4

### Product funnel is defined with 3 levels for our dataset:

* Sessions with any event of type page_view
* Sessions with any event of type add_to_cart
* Sessions with any event of type checkout

```sql
with base as (
    select
        count(distinct(session_id)) as num_of_sessions
        , count(distinct case when page_view > 0 then session_id end) as page_views
        , count(distinct case when add_to_cart > 0 then session_id end) as add_to_cart
        , count(distinct case when checkout > 0 then session_id end) as checkouts
    from dbt_teresita_g.ct_sessions_events
)
select
    *
from base
```
| event          |  sessions  |
|----------------|-----------:|
| page_view      | 578        |
| add_to_cart    | 467        |
| checkout       | 361        |

### 3A. dbt next steps for you 
*Reflecting on your learning in this class...*

**if your organization is thinking about using dbt, how would you pitch the value of dbt/analytics engineering to a decision maker at your organization?**
> Thank God, we are already using DBT. People outside the Data Team probably don't know that we are using DBT, but definitely they appreciate the speed with which we deliver analysis/reports.

**if your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?**
> Maybe the use of more macros. We have some pieces of code repeated in diferent layers of the project.

**if you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?**
> Modelling and thinking ahead!

### 3B. Setting up for production / scheduled dbt run of your project 
And finally, before you fly free into the dbt night, we will take a step back and reflect: after learning about the various options for dbt deployment and seeing your final dbt project, how would you go about setting up a production/scheduled dbt run of your project in an ideal state?
> I already use dbt cloud and works as expected. However, I would like to try another orchestrator(not sure which one), but as our tech stack is growing and also our data sources, it would be a good idea to try some different.
> I am very interested in data lineage, and recently found [this tool](https://www.datafold.com/) that works with DBT and might solve most of my problems :)
