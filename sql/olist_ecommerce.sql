/*
 File: customer_rfm_analysis.sql
 Author: Your Name
 Date: 2025-11-07
 Description:
 Calculates RFM (Recency, Frequency, Monetary) metrics for all customers
 and assigns marketing segments: Champions, Loyal, At-Risk, Dormant, No Purchase.
 */
/* ==============================
 1. Create Database and Tables
 ============================== */
-- Name the Database olist_ecommerce 
CREATE DATABASE olist_ecommerce;
-- Right click the database and open Query Tool
-- Create Tables
CREATE TABLE customers (
    customer_id VARCHAR PRIMARY KEY,
    customer_unique_id VARCHAR,
    customer_zip_code_prefix INT,
    customer_city VARCHAR,
    customer_state VARCHAR
);
CREATE TABLE orders (
    order_id VARCHAR PRIMARY KEY,
    customer_id VARCHAR REFERENCES customers(customer_id),
    order_status VARCHAR,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);
CREATE TABLE order_items (
    order_id VARCHAR REFERENCES orders(order_id),
    order_item_id INT,
    product_id VARCHAR,
    seller_id VARCHAR,
    shipping_limit_date TIMESTAMP,
    price NUMERIC(10, 2),
    freight_value NUMERIC(10, 2)
);
CREATE TABLE payments (
    order_id VARCHAR REFERENCES orders(order_id),
    payment_sequential INT,
    payment_type VARCHAR,
    payment_installments INT,
    payment_value NUMERIC(10, 2)
);
CREATE TABLE reviews (
    review_id VARCHAR PRIMARY KEY,
    order_id VARCHAR REFERENCES orders(order_id),
    review_score INT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);
CREATE TABLE products (
    product_id VARCHAR PRIMARY KEY,
    product_category_name VARCHAR,
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_grams INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);
CREATE TABLE product_category_translation (
    product_category_name VARCHAR,
    product_category_name_english VARCHAR
);
-- Right click on each table and select Import/Export Data to Import CSV files for each table
-- Verify the count of records in each table
SELECT (
        SELECT COUNT(*)
        FROM customers
    ) AS customers,
    (
        SELECT COUNT(*)
        FROM orders
    ) AS orders,
    (
        SELECT COUNT(*)
        FROM order_items
    ) AS order_items,
    (
        SELECT COUNT(*)
        FROM payments
    ) AS payments,
    (
        SELECT COUNT(*)
        FROM reviews
    ) AS reviews,
    (
        SELECT COUNT(*)
        FROM products
    ) AS products,
    (
        SELECT COUNT(*)
        FROM product_category_translation
    ) AS product_categories;