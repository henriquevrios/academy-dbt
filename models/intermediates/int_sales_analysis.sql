with
    sales_data as (
        select
            soh.salesorderid as order_id
            , soh.orderdate as order_date
            , soh.duedate as due_date
            , soh.shipdate as ship_date
            , soh.subtotal as subtotal
            , soh.taxamt as tax_amount
            , soh.freight as freight_cost
            , soh.totaldue as total_due
            , soh.customerid as customer_id
            , soh.salespersonid as salesperson_id
            , sod.productid as product_id
            , sod.orderqty as quantity_ordered
            , sod.unitprice as unit_price
            , sod.unitprice - sod.unitpricediscount as effective_unit_price
            , sod.orderqty * (sod.unitprice - sod.unitpricediscount) as line_total
        from adventureworks.sap_adw.salesorderheader soh
        inner join adventureworks.sap_adw.salesorderdetail sod
            on soh.salesorderid = sod.salesorderid
    )

    , aggregated_sales as (
        select
            order_id
            , order_date
            , due_date
            , ship_date
            , customer_id
            , salesperson_id
            , product_id
            , sum(quantity_ordered) as total_quantity_ordered
            , sum(line_total) as total_sales_amount
            , sum(tax_amount) as total_tax
            , sum(freight_cost) as total_freight
            , sum(total_due) as total_revenue
        from sales_data
        group by
            order_id
            , order_date
            , due_date
            , ship_date
            , customer_id
            , salesperson_id
            , product_id
    )

select
    order_id
    , order_date
    , due_date
    , ship_date
    , customer_id
    , salesperson_id
    , product_id
    , total_quantity_ordered
    , total_sales_amount
    , total_tax
    , total_freight
    , total_revenue
from aggregated_sales
