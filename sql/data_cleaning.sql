/*
 File: data_cleaning.sql
 Author: Your Name
 Date: 2025-11-07
 Description:
 This SQL script performs data cleaning for the Olist E-commerce database. 
 
 The cleaning steps include:
 
 1. Handling missing values:
 - Replace missing customer city/state with 'Unknown'.
 - Replace missing numeric values (price, freight_value, payment_value) with 0.
 - Handle missing review scores.
 
 2. Removing duplicate records:
 - Ensure uniqueness for primary keys in each table.
 - Use ctid in PostgreSQL to identify and remove duplicate rows while keeping the first occurrence.
 
 Tables cleaned:
 - customers
 - orders
 - order_items
 - payments
 - reviews
 - products
 
 This script ensures data integrity and prepares the database for analysis, such as RFM calculation and marketing segmentation.
 */
/* ==============================
 1. Handle Missing Values
 ============================== */
-- Replace missing city/state with 'Unknown'
UPDATE customers
SET customer_city = 'Unknown'
WHERE customer_city IS NULL;
UPDATE customers
SET customer_state = 'Unknown'
WHERE customer_state IS NULL;
-- Replace missing numeric values with 0
UPDATE order_items
SET price = 0
WHERE price IS NULL;
UPDATE order_items
SET freight_value = 0
WHERE freight_value IS NULL;
UPDATE payments
SET payment_value = 0
WHERE payment_value IS NULL;
-- Replace missing review scores with NULL
UPDATE reviews
SET review_score = NULL
WHERE review_score IS NULL;
/* ==============================
 2. Removing Duplicates
 ============================== */
-- Keep the first occurrence of each customer_id
DELETE FROM customers a USING customers b
WHERE a.ctid < b.ctid
    AND a.customer_id = b.customer_id;
-- Keep the first occurrence of each order_id
DELETE FROM orders a USING orders b
WHERE a.ctid < b.ctid
    AND a.order_id = b.order_id;
-- Remove duplicates based on order_id + order_item_id
DELETE FROM order_items a USING order_items b
WHERE a.ctid < b.ctid
    AND a.order_id = b.order_id
    AND a.order_item_id = b.order_item_id;
-- Remove duplicates based on order_id + payment_sequential
DELETE FROM payments a USING payments b
WHERE a.ctid < b.ctid
    AND a.order_id = b.order_id
    AND a.payment_sequential = b.payment_sequential;
-- Remove duplicates based on review_id
DELETE FROM reviews a USING reviews b
WHERE a.ctid < b.ctid
    AND a.review_id = b.review_id;
-- Remove duplicates based on product_id
DELETE FROM products a USING products b
WHERE a.ctid < b.ctid
    AND a.product_id = b.product_id;
-- Note:
-- ctid is a system column in PostgreSQL that uniquely identifies each row version.
-- This method keeps the first occurrence of each unique key and removes duplicates.