-- STEP 1: Create Table
CREATE TABLE email_signup (
    id INT,
    email_id VARCHAR(100),
    signup_date DATE
);

-- STEP 2: Insert Data
INSERT INTO email_signup VALUES
(1, 'Rajesh@Gmail.com', '2022-02-01'),
(2, 'Rakesh_gmail@rediffmail.com', '2023-01-22'),
(3, 'Hitest@Gmail.com', '2020-09-08'),
(4, 'Salil@Gmmail.com', '2019-07-05'),
(5, 'Himanshu@Yahoo.com', '2023-05-09'),
(6, 'Hitesh@Twitter.com', '2015-01-01'),
(7, 'Rakesh@facebook.com', NULL);

-- STEP 3: Find Only Gmail Accounts
-- Match @gmail.com using case-insensitive matching
SELECT *
FROM email_signup
WHERE LOWER(email_id) LIKE '%@gmail.com';

-- STEP 4: Find First Signup, Latest Signup & Difference
SELECT
    MIN(signup_date) AS first_signup,
    MAX(signup_date) AS latest_signup,
    DATEDIFF(MAX(signup_date), MIN(signup_date)) AS difference_in_days
FROM email_signup
WHERE LOWER(email_id) LIKE '%@gmail.com';