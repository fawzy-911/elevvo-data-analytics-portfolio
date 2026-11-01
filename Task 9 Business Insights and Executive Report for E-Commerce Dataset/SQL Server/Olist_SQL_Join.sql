-- One output row per order. Child tables are totaled by order before joining,
-- so multiple items, payments, or reviews cannot duplicate an order.
WITH ItemsPerOrder AS (
    SELECT order_id,
           SUM(price) AS product_revenue,
           SUM(freight_value) AS freight_total,
           COUNT(*) AS item_count
    FROM order_items
    GROUP BY order_id
), PaymentsPerOrder AS (
    SELECT order_id,
           SUM(payment_value) AS payment_total
    FROM order_payments
    GROUP BY order_id
), ReviewsPerOrder AS (
    SELECT order_id,
           AVG(CAST(review_score AS DECIMAL(5,2))) AS average_review_score,
           COUNT(review_score) AS review_count
    FROM order_reviews
    GROUP BY order_id
)
SELECT
    o.order_id,
    c.customer_id,
    c.customer_unique_id,
    c.customer_state,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    i.product_revenue,
    i.freight_total,
    p.payment_total,
    r.average_review_score,
    COALESCE(i.item_count, 0) AS item_count,
    COALESCE(r.review_count, 0) AS review_count
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
LEFT JOIN ItemsPerOrder AS i
    ON o.order_id = i.order_id
LEFT JOIN PaymentsPerOrder AS p
    ON o.order_id = p.order_id
LEFT JOIN ReviewsPerOrder AS r
    ON o.order_id = r.order_id;
