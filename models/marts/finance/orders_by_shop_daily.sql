with
    orders as (select * from {{ ref("stg_postgre__orders") }}),

    shops as (select * from {{ ref("stg_postgre__shops") }}),

    daily_orders as (
        select
            orders.shop_id,
            shops.shop_name,
            orders.order_date,
            count(*) as order_items_qty,
            round(sum(orders.order_value), 2) as order_total_value
        from orders
        left join shops using (shop_id)
        where orders.order_date is not null
        group by orders.shop_id, shops.shop_name, orders.order_date
        order by order_date, shop_id
    )

select *
from daily_orders
