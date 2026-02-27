-- STEP 1: Create the Table
CREATE TABLE product_details (
    sell_date DATE,
    product VARCHAR(50)
);

-- STEP 2: Insert the Given Data

INSERT INTO product_details (sell_date, product) VALUES
('2020-05-30', 'Headphones'),
('2020-06-01', 'Pencil'),
('2020-06-02', 'Mask'),
('2020-05-30', 'Basketball'),
('2020-06-01', 'Book'),
('2020-06-02', ' Mask '),
('2020-05-30', 'T-Shirt');

-- STEP 3: Final Query (Main Answer)
SELECT
    sell_date,
    COUNT(DISTINCT TRIM(product)) AS num_sold,
    GROUP_CONCAT(DISTINCT TRIM(product) ORDER BY TRIM(product) SEPARATOR ', ') AS product_list
FROM product_details
GROUP BY sell_date
ORDER BY sell_date;