with
    order_status as (select * from {{ ref("stg_postgres__order_status") }}),
    order_status_types as (select * from {{ ref("stg_postgres__order_status_types") }}),
    orders_items as (select * from {{ ref("stg_postgres__orders_items") }}),
    orders as (select * from {{ ref("stg_postgres__orders") }}),
    products as (select * from {{ ref("stg_postgres__products") }}),

cte_pedido_item as (
  
  SELECT
    orders.order_id,
    orders.shop_id,
    orders.order_date,
    orders.order_items_value, -- Preco
    orders.order_discount_value, -- Desconto
    orders.order_shipping_value, -- Frete
    orders.order_prepayment_value, -- AdiantReceita
    products.product_name, -- Produto
    orders_items.product_id, -- IdProduto
    order_status_types.status_label, -- StatusPedido
    orders_items.order_item_unit_price, -- PrecoUnitario
    sum(orders_items.order_item_unit_quantity) as order_item_quantity, -- Quantidade
    sum(orders_items.order_item_unit_price * orders_items.order_item_unit_quantity) as order_item_price,-- PrecoItem,
    sum(orders_items.order_item_unit_discount * orders_items.order_item_unit_quantity) as order_item_discount, -- DescontoItem,
    sum(orders_items.order_item_unit_prepayment * orders_items.order_item_unit_quantity) as order_item_prepayment -- AdiantReceitaItem,
    --to_char(fn_retornaprazoproducao_liberacao_data(orders.order_id), 'dd/mm/yyyy') AS "PrazoProducao"
  
  FROM orders
  JOIN orders_items ON orders.order_id = orders_items.order_id
  JOIN products ON orders_items.product_id = products.product_id
  JOIN order_status ON orders_items.order_item_id = order_status.order_item_id
  JOIN order_status_types ON order_status.order_status_type_id = order_status_types.order_status_type_id
  
  WHERE {{ get_month_to_yesterday_range('orders.order_date') }}
  --WHERE orders.order_date BETWEEN date_trunc('month', current_date - interval '1 day') AND date_trunc('day', current_date)
  GROUP BY orders.order_id, orders.shop_id, orders.order_date, orders.order_items_value, orders.order_discount_value, orders.order_shipping_value, orders.order_prepayment_value,
           products.product_name, orders_items.product_id, order_status_types.status_label, orders_items.order_item_unit_price)
           
select * from cte_pedido_item