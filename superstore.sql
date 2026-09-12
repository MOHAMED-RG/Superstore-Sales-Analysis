-- Preview the Superstore dataset

SELECT *
FROM superstore;

-- =====================================================
-- 1. DATA CLEANING & VALIDATION
-- =====================================================

-- Check the number of non-NULL values in each column
-- Used to identify columns that contain missing values

SELECT
    COUNT(row_id)        AS total_row_id,
    COUNT(order_id)      AS total_order_id,
    COUNT(order_date)    AS total_order_date,
    COUNT(ship_date)     AS total_ship_date,
    COUNT(ship_mode)     AS total_ship_mode,
    COUNT(customer_id)   AS total_customer_id,
    COUNT(customer_name) AS total_customer_name,
    COUNT(segment)       AS total_segment,
    COUNT(country)       AS total_country,
    COUNT(city)          AS total_city,
    COUNT(state)         AS total_state,
    COUNT(postal_code)   AS total_postal_code,
    COUNT(region)        AS total_region,
    COUNT(product_id)    AS total_product_id,
    COUNT(category)      AS total_category,
    COUNT(sub_category)  AS total_sub_category,
    COUNT(product_name)  AS total_product_name,
    COUNT(sales)         AS total_sales
FROM superstore;

-- Check for NULL values in the Sales column
-- Used to identify records with missing sales values

SELECT *
FROM superstore
WHERE sales IS NULL;

-- Check for NULL values in the Postal Code column
-- Used to identify records with missing postal code values

SELECT *
FROM superstore
WHERE postal_code IS NULL;


-- Check records with missing Sales values
-- Select key columns to inspect the affected records

SELECT
    row_id,
    order_id,
    order_date,
    product_id,
    product_name,
    sales
FROM superstore
WHERE sales IS NULL;

-- Count records with missing Sales values
-- Used to determine the number of records affected by NULL values

SELECT COUNT(*) AS null_sales_count
FROM superstore
WHERE sales IS NULL;


-- Remove records with missing Sales values
-- Sales is required for the business analysis

DELETE FROM superstore
WHERE sales IS NULL;


-- Verify that no NULL Sales values remain after cleaning

SELECT COUNT(*) AS remaining_null_sales
FROM superstore
WHERE sales IS NULL;


-- Check the number of records with missing Postal Code values
-- Used to determine the number of records affected by NULL values

SELECT COUNT(*) AS null_postal_code_count
FROM superstore
WHERE postal_code IS NULL;


-- Check missing Postal Code values for Vermont
-- Result: 0 NULL values found, so no cleaning is required

SELECT
    state,
    COUNT(*) AS total_rows,
    COUNT(postal_code) AS postal_code_not_null,
    COUNT(*) - COUNT(postal_code) AS postal_code_nulls
FROM superstore
WHERE state = 'Vermont'
GROUP BY state;

-- Check for duplicate Row IDs
-- Result: 0 duplicates found, so no cleaning is required

SELECT
    row_id,
    COUNT(*) AS row_id_count
FROM superstore
GROUP BY row_id
HAVING COUNT(*) > 1;

-- Check for orders with multiple records
-- Result: Duplicate Order IDs were found, but this is expected
-- because one order can contain multiple products and does not affect the analysis

SELECT
    order_id,
    COUNT(*) AS order_counts
FROM superstore
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY order_counts DESC;


-- Check for completely duplicated records
-- Result: No fully duplicated records found, so no cleaning is required

SELECT
    COUNT(*) AS total_rows,
    COUNT(
        DISTINCT (
            row_id, order_id, order_date, ship_date,
            ship_mode, customer_id, customer_name,
            segment, country, city, state, postal_code,
            region, product_id, category, sub_category,
            product_name, sales
        )
    ) AS unique_rows
FROM superstore;


-- Check for negative Sales values
-- Result: No negative Sales values found, so no cleaning is required

SELECT *
FROM superstore
WHERE sales < 0;


-- Check for invalid shipping dates
-- Result: No records found where Ship Date is earlier than Order Date,
-- so no cleaning is required

SELECT *
FROM superstore
WHERE ship_date < order_date;


-- Check the number of records for each Shipping Mode
-- Used to understand the distribution of orders across shipping methods

SELECT
    ship_mode,
    COUNT(*) AS order_count
FROM superstore
GROUP BY ship_mode
ORDER BY order_count DESC;



-- Check the number of records in each Region
-- Used to validate the distribution of records across regions

SELECT
    region,
    COUNT(*) AS record_count
FROM superstore
GROUP BY region
ORDER BY record_count DESC;


-- Check the number of records in each Category
-- Used to validate the distribution of records across categories

SELECT
    category,
    COUNT(*) AS record_count
FROM superstore
GROUP BY category
ORDER BY record_count DESC;


-- Check the number of records in each Customer Segment
-- Used to validate the distribution of records across segments

SELECT
    segment,
    COUNT(*) AS record_count
FROM superstore
GROUP BY segment
ORDER BY record_count DESC;


-- Check for NULL values across all columns
-- Result: No NULL values found, so no cleaning is required

SELECT
    COUNT(*) - COUNT(row_id)        AS row_id_nulls,
    COUNT(*) - COUNT(order_id)      AS order_id_nulls,
    COUNT(*) - COUNT(order_date)    AS order_date_nulls,
    COUNT(*) - COUNT(ship_date)     AS ship_date_nulls,
    COUNT(*) - COUNT(ship_mode)     AS ship_mode_nulls,
    COUNT(*) - COUNT(customer_id)   AS customer_id_nulls,
    COUNT(*) - COUNT(customer_name) AS customer_name_nulls,
    COUNT(*) - COUNT(segment)       AS segment_nulls,
    COUNT(*) - COUNT(country)       AS country_nulls,
    COUNT(*) - COUNT(city)          AS city_nulls,
    COUNT(*) - COUNT(state)         AS state_nulls,
    COUNT(*) - COUNT(postal_code)   AS postal_code_nulls,
    COUNT(*) - COUNT(region)        AS region_nulls,
    COUNT(*) - COUNT(product_id)    AS product_id_nulls,
    COUNT(*) - COUNT(category)      AS category_nulls,
    COUNT(*) - COUNT(sub_category)  AS sub_category_nulls,
    COUNT(*) - COUNT(product_name)  AS product_name_nulls,
    COUNT(*) - COUNT(sales)         AS sales_nulls
FROM superstore;

-- Check for leading or trailing spaces in Customer Names
-- Result: No extra spaces found, so no cleaning is required

SELECT *
FROM superstore
WHERE customer_name <> TRIM(customer_name);

-- Check for leading or trailing spaces in categorical columns
-- Result: No extra spaces found, so no cleaning is required

SELECT *
FROM superstore
WHERE ship_mode <> TRIM(ship_mode)
   OR segment <> TRIM(segment)
   OR country <> TRIM(country)
   OR city <> TRIM(city)
   OR state <> TRIM(state)
   OR region <> TRIM(region)
   OR category <> TRIM(category)
   OR sub_category <> TRIM(sub_category);


-- Check the date range of Orders and Shipments
-- Used to validate the earliest and latest dates in the dataset

SELECT
    MIN(order_date) AS earliest_order,
    MAX(order_date) AS latest_order,
    MIN(ship_date) AS earliest_ship,
    MAX(ship_date) AS latest_ship
FROM superstore;

-- Check for non-numeric Postal Code values
-- Result: No invalid Postal Code values found, so no cleaning is required

SELECT
    postal_code
FROM superstore
WHERE postal_code IS NOT NULL
  AND postal_code !~ '^[0-9]+$';

-- Check for NULL values in the Sales column
-- Result: 0 NULL values found, so no cleaning is required

SELECT
    COUNT(*) AS null_sales_rows
FROM superstore
WHERE sales IS NULL;


-- =====================================================
-- 2. SALES ANALYSIS
-- =====================================================

-- Calculate the total sales across all orders

SELECT
    SUM(sales) AS total_sales
FROM superstore;

-- Calculate total sales for each region
-- Sorted from the highest total sales to the lowest

SELECT
    region,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;



-- Calculate total sales for each product category
-- Rounded to two decimal places and sorted from the highest total sales to the lowest

SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;


-- Calculate total sales for each product
-- Sorted from the highest total sales to the lowest
-- Limited to the top 10 products

SELECT
    product_name,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;


-- Calculate total sales for each year
-- Sorted from the highest total sales to the lowest

SELECT
    EXTRACT(YEAR FROM order_date) AS year_date,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY year_date
ORDER BY total_sales DESC;


-- Calculate total sales for each month
-- Sorted from the highest total sales to the lowest

SELECT
    EXTRACT(MONTH FROM order_date) AS month_date,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY month_date
ORDER BY total_sales DESC;


-- Calculate the average shipping time in days
-- Rounded to two decimal places

SELECT
    ROUND(AVG(ship_date - order_date), 2) AS shipping_time_per_day
FROM superstore;


-- Calculate total sales for each customer
-- Sorted from the highest total sales to the lowest
-- Limited to the top 10 customers

SELECT
    customer_name,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- Calculate total sales for each state
-- Rounded to two decimal places and sorted from the highest total sales to the lowest
-- Limited to the top 10 states

SELECT
    state,
    ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY state
ORDER BY total_sales DESC
LIMIT 10;

-- Calculate total sales for each sub-category
-- Rounded to two decimal places and sorted from the highest total sales to the lowest
-- Limited to the top 10 sub-categories

SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY sub_category
ORDER BY total_sales DESC
LIMIT 10;

-- Calculate total sales for each region and product category
-- Rounded to two decimal places and sorted from the highest total sales to the lowest

SELECT
    region,
    category,
    ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY region, category
ORDER BY total_sales DESC;


-- Calculate total sales for each shipping mode
-- Rounded to two decimal places and sorted from the highest total sales to the lowest

SELECT
    ship_mode,
    ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY ship_mode
ORDER BY total_sales DESC;

-- Calculate total sales for each combination of region and shipping mode
-- Rounded to two decimal places and sorted from the highest total sales to the lowest

SELECT
    region,
    ship_mode,
    ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY region, ship_mode
ORDER BY total_sales DESC;


-- Calculate each region's percentage contribution to total sales
-- Rounded to two decimal places and sorted from the highest percentage to the lowest

SELECT
    region,
    ROUND(
        SUM(sales) * 100 / (SELECT SUM(sales) FROM superstore),
        2
    ) AS sales_percentage
FROM superstore
GROUP BY region
ORDER BY sales_percentage DESC;


-- Calculate the average shipping time for each shipping mode
-- Rounded to two decimal places and sorted from the longest shipping time to the shortest

SELECT
    ship_mode,
    ROUND(AVG(ship_date - order_date), 2) AS shipping_time_per_day
FROM superstore
GROUP BY ship_mode
ORDER BY shipping_time_per_day DESC;

-- Calculate total sales for each city
-- Rounded to two decimal places and sorted from the highest total sales to the lowest
-- Limited to the top 10 cities

SELECT
    city,
    ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY city
ORDER BY total_sales DESC
LIMIT 10;

-- Calculate total sales for each region and year
-- Sorted from the highest total sales to the lowest

SELECT
    region,
    EXTRACT(YEAR FROM order_date) AS year_date,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY region, year_date
ORDER BY total_sales DESC;