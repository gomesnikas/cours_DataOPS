-- Table des revenus agrégés par jour
with sales as (
    select *
    from {{ ref('stg_sales') }}
)

select
    date_trunc('day', invoice_date) as revenue_date,
    sum(quantity * unit_price) as total_revenue
from sales
group by revenue_date
order by revenue_date
