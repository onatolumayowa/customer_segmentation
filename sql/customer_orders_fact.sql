/*
 File: customer_orders_fact.sql
 Author: Your Name
 Date: 2025-11-07
 Description:
 This SQL script creates a customer-level fact table aggregating orders, payments, items, and reviews.
 
 It calculates key metrics for each customer, including:
 - Total orders
 - Total items purchased
 - Total money spent
 - First and last order dates
 - Average order value
 - Average review score
 
 This table is designed to be used in Python for:
 - RFM (Recency, Frequency, Monetary) calculation
 - KMeans clustering for customer segmentation
 
 Tables used:
 - customers
 - orders
 - order_items
 - payments
 - reviews
 */
/* ==============================
 Create Customer Orders Fact Table
 ============================== */
-- Drop existing table if it exists
DROP TABLE IF EXISTS customer_orders_fact;
-- Create master customer-level fact table
CREATE TABLE customer_orders_fact AS
SELECT c.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    -- Total orders per customer
    COUNT(DISTINCT o.order_id) AS total_orders,
    -- Total items purchased per customer
    COUNT(oi.order_item_id) AS total_items,
    -- Total money spent (set 0 if NULL)
    COALESCE(SUM(p.payment_value), 0) AS total_spent,
    -- First and last order timestamps
    MIN(o.order_purchase_timestamp) AS first_order_date,
    MAX(o.order_purchase_timestamp) AS last_order_date,
    -- Average order value
    COALESCE(
        SUM(p.payment_value) / NULLIF(COUNT(DISTINCT o.order_id), 0),
        0
    ) AS average_order_value,
    -- Average review score (rounded to 2 decimals)
    ROUND(AVG(r.review_score), 2) AS average_review_score
FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    LEFT JOIN payments p ON o.order_id = p.order_id
    LEFT JOIN reviews r ON o.order_id = r.order_id
GROUP BY c.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state -- Order by total spent to see top customers first
ORDER BY total_spent DESC;
-- Notes:
-- 1. LEFT JOIN ensures customers with no orders are included with zeros for metrics.
-- 2. COALESCE sets NULL values to 0, avoiding errors in Python calculations.
-- 3. NULLIF prevents division by zero in average_order_value.
-- 4. This table is intended as the base dataset for Python RFM calculation and KMeans clustering.