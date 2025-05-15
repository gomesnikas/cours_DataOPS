with stg as (
    select * from {{ ref('stg_sales') }}
)

select
    date(invoice_date) as revenue_date,
    sum(quantity * unit_price) as daily_revenue
from stg
group by 1
order by 1

