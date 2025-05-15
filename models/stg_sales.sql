-- Modèle de staging nettoyé
with raw_sales as (
    select
        cast("InvoiceNo" as text) as invoice_no,
        cast("StockCode" as text) as stock_code,
        "Description" as description,
        cast("Quantity" as int) as quantity,
        cast("InvoiceDate" as timestamp) as invoice_date,
        cast("UnitPrice" as numeric) as unit_price,
        cast("CustomerID" as text) as customer_id,
        "Country" as country
    from {{ source('sales', 'sales') }}
)

select *
from raw_sales
where customer_id is not null and unit_price is not null

