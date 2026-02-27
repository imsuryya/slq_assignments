-- STEP 1: Create Table
CREATE TABLE sales_data (
    productid INT,
    sale_date DATE,
    quantity_sold INT
);

-- STEP 2: Insert Given Dataset
INSERT INTO sales_data VALUES
(1, '2022-01-01', 20),
(2, '2022-01-01', 15),
(1, '2022-01-02', 10),
(2, '2022-01-02', 25),
(1, '2022-01-03', 30),
(2, '2022-01-03', 18),
(1, '2022-01-04', 12),
(2, '2022-01-04', 22);

-- STEP 3: Assign Rank Partitioned by productid
-- Find the latest product sold by ranking sale_date DESC inside each product
SELECT *,
RANK() OVER (PARTITION BY productid ORDER BY sale_date DESC) AS rnk
FROM sales_data;

-- Get only latest sale per product
SELECT *
FROM (
    SELECT *,
    RANK() OVER (PARTITION BY productid ORDER BY sale_date DESC) AS rnk
    FROM sales_data
) t
WHERE rnk = 1;

-- STEP 4: Get Previous Row Quantity (Using LAG)
-- LAG() gets previous row value, we compare current vs previous
SELECT
    productid,
    sale_date,
    quantity_sold,
    LAG(quantity_sold)
        OVER (PARTITION BY productid ORDER BY sale_date) AS previous_quantity,
    quantity_sold - LAG(quantity_sold)
        OVER (PARTITION BY productid ORDER BY sale_date) AS difference
FROM sales_data;

-- STEP 5: Get First and Last Value per productid
SELECT
    productid,
    sale_date,
    quantity_sold,
    FIRST_VALUE(quantity_sold)
        OVER (PARTITION BY productid ORDER BY sale_date) AS first_value,
    LAST_VALUE(quantity_sold)
        OVER (
            PARTITION BY productid
            ORDER BY sale_date
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS last_value
FROM sales_data;