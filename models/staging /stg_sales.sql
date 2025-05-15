with raw as (
    select
        cast("InvoiceNo" as string) as invoice_no,
        cast("StockCode" as string) as stock_code,
        cast("Description" as string) as description,
        cast("Quantity" as integer) as quantity,
        cast("InvoiceDate" as timestamp) as invoice_date,
        cast("UnitPrice" as float) as unit_price,
        cast("CustomerID" as string) as customer_id,
        cast("Country" as string) as country
    from {{ source('sales', 'sales') }}
)

select * from raw
where customer_id is not null and unit_price is not null

