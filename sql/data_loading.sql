/*
 File: data_loading.sql
 Description:
 This SQL script sets up the Olist E-commerce database from scratch and loads CSV data into the respective tables.
 
 Steps:
 1. Creates the database `olist_ecommerce`.
 2. Defines the schema by creating tables with primary keys and foreign key relationships.
 3. Provides instructions to import CSV files into each table.
 4. Verifies the data load by counting records in all tables.
 */
/* ==============================
 Create Database
 ============================== */
-- Name the database
CREATE DATABASE olist_ecommerce;
-- After creating the database, open the Query Tool to run the following table creation scripts.
/* ==============================
 Create Tables
 ============================== */
-- 1. Customers table: stores basic customer information
CREATE TABLE customers (
    customer_id VARCHAR PRIMARY KEY,
    -- Unique ID for each customer
    customer_unique_id VARCHAR,
    -- Unique identifier shared across multiple orders
    customer_zip_code_prefix INT,
    -- Customer postal code prefix
    customer_city VARCHAR,
    -- Customer city
    customer_state VARCHAR -- Customer state
);
-- 2. Orders table: stores order details
CREATE TABLE orders (
    order_id VARCHAR PRIMARY KEY,
    -- Unique order identifier
    customer_id VARCHAR REFERENCES customers(customer_id),
    -- Link to the customer who placed the order
    order_status VARCHAR,
    -- Current status of the order
    order_purchase_timestamp TIMESTAMP,
    -- Timestamp when order was placed
    order_approved_at TIMESTAMP,
    -- Timestamp when order was approved
    order_delivered_carrier_date TIMESTAMP,
    -- Timestamp when order reached carrier
    order_delivered_customer_date TIMESTAMP,
    -- Timestamp when order was delivered
    order_estimated_delivery_date TIMESTAMP -- Estimated delivery date
);
-- 3. Order Items table: stores individual items in each order
CREATE TABLE order_items (
    order_id VARCHAR REFERENCES orders(order_id),
    -- Link to the order
    order_item_id INT,
    -- Item number in the order
    product_id VARCHAR,
    -- ID of the product
    seller_id VARCHAR,
    -- ID of the seller
    shipping_limit_date TIMESTAMP,
    -- Shipping deadline for the item
    price NUMERIC(10, 2),
    -- Product price
    freight_value NUMERIC(10, 2) -- Shipping cost
);
-- 4. Payments table: stores payment details for each order
CREATE TABLE payments (
    order_id VARCHAR REFERENCES orders(order_id),
    -- Link to the order
    payment_sequential INT,
    -- Sequence of payment attempts
    payment_type VARCHAR,
    -- Type of payment (credit_card, boleto, etc.)
    payment_installments INT,
    -- Number of installments
    payment_value NUMERIC(10, 2) -- Payment amount
);
-- 5. Reviews table: stores customer reviews for orders
CREATE TABLE reviews (
    review_id VARCHAR PRIMARY KEY,
    -- Unique review identifier
    order_id VARCHAR REFERENCES orders(order_id),
    -- Link to the order
    review_score INT,
    -- Rating (1–5)
    review_creation_date TIMESTAMP,
    -- When review was created
    review_answer_timestamp TIMESTAMP -- When review was answered by seller
);
-- 6. Products table: stores product information
CREATE TABLE products (
    product_id VARCHAR PRIMARY KEY,
    -- Unique product identifier
    product_category_name VARCHAR,
    -- Product category
    product_name_length INT,
    -- Length of product name
    product_description_length INT,
    -- Length of product description
    product_photos_qty INT,
    -- Number of product photos
    product_weight_grams INT,
    -- Weight of the product
    product_length_cm INT,
    -- Product length in cm
    product_height_cm INT,
    -- Product height in cm
    product_width_cm INT -- Product width in cm
);
-- 7. Product Category Translation table: maps categories to English
CREATE TABLE product_category_translation (
    product_category_name VARCHAR,
    -- Original category name
    product_category_name_english VARCHAR -- Translated category name
);
/* ==============================
 Load CSV Data
 ============================== */
-- Right-click each table and select "Import/Export Data" to load the corresponding CSV file.
-- Ensure each CSV matches the table columns and data types.
/* ==============================
 Verify Data Load
 ============================== */
-- Count records in each table to ensure data was imported successfully
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