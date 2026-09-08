select order_id, sum(amount_in_cents) as total_amount
from {{ ref('stg_stripe__payment') }}
group by 1
having sum(amount_in_cents) < 0