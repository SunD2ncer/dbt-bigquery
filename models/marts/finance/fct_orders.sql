select orders.order_id, orders.customer_id, payments.amount
from {{ ref('stg_jaffle_shop__orders') }} as orders
join {{ ref('stg_stripe__payments') }} as payments
on payments.orderid = orders.order_id