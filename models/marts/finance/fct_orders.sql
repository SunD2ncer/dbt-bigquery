select orders.order_id, orders.customer_id, payments.amount_in_cents
from {{ ref('stg_jaffle_shop__orders') }} as orders
join {{ ref('stg_stripe__payments') }} as payments
on payments.order_id = orders.order_id