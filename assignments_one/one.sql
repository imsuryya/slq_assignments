-- 1. Create Database as ecommerce
CREATE DATABASE ecommerce;

-- 2. Create 4 tables (gold_member_users, users, sales, product) under the above database(ecommerce)
USE ecommerce;

CREATE TABLE gold_member_users (
    userid VARCHAR(50),
    signup_date DATE
);

CREATE TABLE users (
    userid VARCHAR(50),
    signup_date DATE
);

CREATE TABLE product (
    product_id INT,
    product_name VARCHAR(50),
    price INT
);

CREATE TABLE sales (
    userid VARCHAR(50),
    created_date DATE,
    product_id INT
);

-- 3. Insert Values
-- Gold Members
INSERT INTO gold_member_users VALUES
('John','2017-09-22'),
('Mary','2017-04-21');

-- Users
INSERT INTO users VALUES
('John','2014-09-02'),
('Michel','2015-01-15'),
('Mary','2014-04-11');

-- Product
INSERT INTO product VALUES
(1,'Mobile',980),
(2,'Ipad',870),
(3,'Laptop',330);

-- Sales
INSERT INTO sales VALUES
('John','2017-04-19',2),
('Mary','2019-12-18',1),
('Michel','2020-07-20',3),
('John','2019-10-23',2),
('John','2018-03-19',3),
('Mary','2016-12-20',2),
('John','2016-11-09',1),
('John','2016-05-20',3),
('Michel','2017-09-24',1),
('John','2017-03-11',2),
('John','2016-03-11',1),
('Mary','2016-11-10',1),
('Mary','2017-12-07',2);

-- 4. Show All Tables
SHOW TABLES;

-- 5. Count Records of All Four Tables (Single Query)
SELECT
(SELECT COUNT(*) FROM users) AS users_count,
(SELECT COUNT(*) FROM gold_member_users) AS gold_count,
(SELECT COUNT(*) FROM sales) AS sales_count,
(SELECT COUNT(*) FROM product) AS product_count;

-- 6. Total Amount Each Customer Spent
SELECT s.userid,
SUM(p.price) AS total_amount
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY s.userid;

-- 7. Distinct Visit Dates of Each Customer
SELECT DISTINCT created_date AS date, userid AS customer_name
FROM sales
ORDER BY userid;

-- 8. First Product Purchased by Each Customer
SELECT s.userid, p.product_name, MIN(s.created_date) AS first_purchase_date
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY s.userid;

-- 9. Most Purchased Item of Each Customer
SELECT userid, COUNT(product_id) AS item_count
FROM sales
GROUP BY userid
ORDER BY item_count DESC;

-- 10. Customer Who is NOT Gold Member
SELECT userid
FROM users
WHERE userid NOT IN (SELECT userid FROM gold_member_users);

-- 11. Amount Spent When Customer Was Gold Member
SELECT s.userid,
SUM(p.price) AS gold_member_amount
FROM sales s
JOIN product p ON s.product_id = p.product_id
JOIN gold_member_users g ON s.userid = g.userid
WHERE s.created_date >= g.signup_date
GROUP BY s.userid
ORDER BY s.userid;

-- 12. Customer Names Starting with M
SELECT userid
FROM users
WHERE userid LIKE 'M%';

-- 13. Distinct Customer IDs
SELECT DISTINCT userid
FROM sales;

-- 14. Change Column Name price → price_value
ALTER TABLE product
RENAME COLUMN price TO price_value;

-- 15. Change Product Name Ipad → Iphone
UPDATE product
SET product_name = 'Iphone'
WHERE product_name = 'Ipad';

-- 16. Rename Table gold_member_users → gold_membership_users
RENAME TABLE gold_member_users TO gold_membership_users;

-- 17. Add Status Column
ALTER TABLE gold_membership_users
ADD status VARCHAR(10);

UPDATE gold_membership_users
SET status = 'Yes';

SELECT u.userid,
CASE
    WHEN g.userid IS NOT NULL THEN 'Yes'
    ELSE 'No'
END AS status
FROM users u
LEFT JOIN gold_membership_users g
ON u.userid = g.userid;

-- 18. Delete User IDs and Rollback
START TRANSACTION;

DELETE FROM users WHERE userid='John';
DELETE FROM users WHERE userid='Mary';

ROLLBACK;

-- 19. Insert Duplicate Record in Product
INSERT INTO product VALUES (3,'Laptop',330);

-- 20. Find Duplicates in Product Table
SELECT product_id, product_name, price_value, COUNT(*)
FROM product
GROUP BY product_id, product_name, price_value
HAVING COUNT(*) > 1;