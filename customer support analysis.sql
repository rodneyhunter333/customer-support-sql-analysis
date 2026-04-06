CREATE DATABASE support_analysis;
CREATE TABLE raw_support_data (
    unique_id INT,
    channel_name VARCHAR(50),
    category VARCHAR(100),
    sub_category VARCHAR(100),
    order_id INT,
    customer_city VARCHAR(100),
    product_category VARCHAR(100),
    item_price DECIMAL(10,2),
    agent_name VARCHAR(100),
    supervisor VARCHAR(100),
    manager VARCHAR(100),
    agent_shift VARCHAR(50),
    csat_score INT,
    order_date_time DATETIME
);
USE support_analysis;

DROP TABLE IF EXISTS raw_support_data;

CREATE TABLE raw_support_data (
    `Unique id` VARCHAR(50),
    `channel_name` VARCHAR(50),
    `category` VARCHAR(100),
    `Sub-category` VARCHAR(100),
    `Customer Remarks` TEXT,
    `Order_id` VARCHAR(50),
    `order_date_time` VARCHAR(50),
    `Issue_reported at` VARCHAR(50),
    `issue_responded` VARCHAR(50),
    `Survey_response_Date` VARCHAR(50),
    `Customer_City` VARCHAR(100),
    `Product_category` VARCHAR(100),
    `Item_price` DECIMAL(10,2),
    `connected_handling_time` INT,
    `Agent_name` VARCHAR(100),
    `Supervisor` VARCHAR(100),
    `Manager` VARCHAR(100),
    `Tenure Bucket` VARCHAR(50),
    `Agent Shift` VARCHAR(50),
    `CSAT Score` INT
);
USE support_analysis;

DROP TABLE IF EXISTS support_tickets;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS agents;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers AS
SELECT DISTINCT
    `Customer_City` AS customer_city
FROM raw_support_data
WHERE `Customer_City` IS NOT NULL;

CREATE TABLE agents AS
SELECT DISTINCT
    `Agent_name` AS agent_name,
    `Supervisor` AS supervisor,
    `Manager` AS manager,
    `Tenure Bucket` AS tenure_bucket,
    `Agent Shift` AS agent_shift
FROM raw_support_data
WHERE `Agent_name` IS NOT NULL;

CREATE TABLE orders AS
SELECT DISTINCT
    `Order_id` AS order_id,
    `order_date_time` AS order_date_time,
    `Customer_City` AS customer_city,
    `Product_category` AS product_category,
    `Item_price` AS item_price
FROM raw_support_data
WHERE `Order_id` IS NOT NULL;

CREATE TABLE support_tickets AS
SELECT
    `Unique id` AS ticket_id,
    `channel_name` AS channel_name,
    `category` AS category,
    `Sub-category` AS sub_category,
    `Customer Remarks` AS customer_remarks,
    `Order_id` AS order_id,
    `Issue_reported at` AS issue_reported_at,
    `issue_responded` AS issue_responded,
    `Survey_response_Date` AS survey_response_date,
    `connected_handling_time` AS connected_handling_time,
    `Agent_name` AS agent_name,
    `CSAT Score` AS csat_score
FROM raw_support_data;
SELECT COUNT(*) AS customers_count FROM customers;
SELECT COUNT(*) AS agents_count FROM agents;
SELECT COUNT(*) AS orders_count FROM orders;
SELECT COUNT(*) AS tickets_count FROM support_tickets;
SELECT COUNT(*) AS raw_count
FROM raw_support_data;
SELECT COUNT(*) AS raw_count
FROM raw_support_data;
SELECT COUNT(*) AS raw_count
FROM raw_support_data;
DROP TABLE IF EXISTS raw_support_data;
SELECT COUNT(*) AS raw_count
FROM raw_support_import;
SELECT *
FROM raw_support_import
LIMIT 5;
USE support_analysis;

DROP TABLE IF EXISTS support_tickets;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS agents;
DROP TABLE IF EXISTS customers;
CREATE TABLE customers AS
SELECT DISTINCT
    `Customer_City` AS customer_city
FROM raw_support_import
WHERE `Customer_City` IS NOT NULL
  AND `Customer_City` <> '';

CREATE TABLE agents AS
SELECT DISTINCT
    `Agent_name` AS agent_name,
    `Supervisor` AS supervisor,
    `Manager` AS manager,
    `Tenure Bucket` AS tenure_bucket,
    `Agent Shift` AS agent_shift
FROM raw_support_import
WHERE `Agent_name` IS NOT NULL
  AND `Agent_name` <> '';

CREATE TABLE orders AS
SELECT DISTINCT
    `Order_id` AS order_id,
    `order_date_time` AS order_date_time,
    `Customer_City` AS customer_city,
    `Product_category` AS product_category,
    `Item_price` AS item_price
FROM raw_support_import
WHERE `Order_id` IS NOT NULL
  AND `Order_id` <> '';

CREATE TABLE support_tickets AS
SELECT
    `Unique id` AS ticket_id,
    `channel_name` AS channel_name,
    `category` AS category,
    `Sub-category` AS sub_category,
    `Customer Remarks` AS customer_remarks,
    `Order_id` AS order_id,
    `Issue_reported at` AS issue_reported_at,
    `issue_responded` AS issue_responded,
    `Survey_response_Date` AS survey_response_date,
    `connected_handling_time` AS connected_handling_time,
    `Agent_name` AS agent_name,
    `CSAT Score` AS csat_score
FROM raw_support_import;
SELECT COUNT(*) AS customers_count FROM customers;
SELECT COUNT(*) AS agents_count FROM agents;
SELECT COUNT(*) AS orders_count FROM orders;
SELECT COUNT(*) AS tickets_count FROM support_tickets;
SELECT
    st.ticket_id,
    st.category,
    st.channel_name,
    st.csat_score,
    o.product_category,
    o.item_price,
    a.agent_name,
    a.supervisor
FROM support_tickets st
LEFT JOIN orders o
    ON st.order_id = o.order_id
LEFT JOIN agents a
    ON st.agent_name = a.agent_name
LIMIT 10;
SELECT
    channel_name,
    ROUND(AVG(csat_score), 2) AS avg_csat,
    COUNT(*) AS ticket_count
FROM support_tickets
WHERE csat_score IS NOT NULL
GROUP BY channel_name
ORDER BY avg_csat DESC;
SELECT
    agent_name,
    ROUND(AVG(csat_score), 2) AS avg_csat,
    COUNT(*) AS tickets_handled
FROM support_tickets
WHERE csat_score IS NOT NULL
GROUP BY agent_name
HAVING COUNT(*) >= 25
ORDER BY avg_csat DESC, tickets_handled DESC;
SELECT
    o.product_category,
    ROUND(AVG(st.csat_score), 2) AS avg_csat,
    COUNT(*) AS ticket_count
FROM support_tickets st
LEFT JOIN orders o
    ON st.order_id = o.order_id
WHERE st.csat_score IS NOT NULL
GROUP BY o.product_category
ORDER BY avg_csat DESC;
SELECT
    agent_name,
    COUNT(*) AS tickets_handled,
    ROUND(AVG(csat_score), 2) AS avg_csat
FROM support_tickets
WHERE csat_score IS NOT NULL
GROUP BY agent_name
HAVING COUNT(*) >= 20
ORDER BY avg_csat DESC;
SELECT
    o.product_category,
    ROUND(SUM(o.item_price), 2) AS total_revenue,
    COUNT(*) AS related_tickets
FROM support_tickets st
LEFT JOIN orders o
    ON st.order_id = o.order_id
GROUP BY o.product_category
ORDER BY total_revenue DESC;
SELECT
    a.agent_shift,
    ROUND(AVG(st.csat_score), 2) AS avg_csat,
    COUNT(*) AS ticket_count
FROM support_tickets st
LEFT JOIN agents a
    ON st.agent_name = a.agent_name
WHERE st.csat_score IS NOT NULL
GROUP BY a.agent_shift
ORDER BY avg_csat DESC;
SELECT
    o.customer_city,
    COUNT(*) AS ticket_count
FROM support_tickets st
LEFT JOIN orders o
    ON st.order_id = o.order_id
GROUP BY o.customer_city
ORDER BY ticket_count DESC
LIMIT 10;
SELECT
    agent_name,
    ROUND(AVG(csat_score), 2) AS avg_csat,
    COUNT(*) AS tickets_handled
FROM support_tickets
WHERE csat_score IS NOT NULL
GROUP BY agent_name
HAVING COUNT(*) >= 20
ORDER BY avg_csat ASC
LIMIT 5;
SELECT
    CASE
        WHEN connected_handling_time < 300 THEN 'Fast'
        WHEN connected_handling_time BETWEEN 300 AND 900 THEN 'Medium'
        ELSE 'Slow'
    END AS response_speed,
    ROUND(AVG(csat_score), 2) AS avg_csat,
    COUNT(*) AS ticket_count
FROM support_tickets
WHERE csat_score IS NOT NULL
GROUP BY response_speed
ORDER BY avg_csat DESC;
SELECT
    category,
    ROUND(AVG(csat_score), 2) AS avg_csat,
    COUNT(*) AS ticket_count
FROM support_tickets
WHERE csat_score IS NOT NULL
GROUP BY category
ORDER BY avg_csat ASC;
SELECT
    DATE_FORMAT(order_date_time, '%Y-%m') AS month,
    COUNT(*) AS ticket_count
FROM orders
GROUP BY month
ORDER BY month;