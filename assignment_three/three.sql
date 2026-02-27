-- STEP 1: Create Table
CREATE TABLE dept_tbl (
    id_deptname VARCHAR(50),
    emp_name VARCHAR(50),
    salary INT
);

-- STEP 2: Insert Data
INSERT INTO dept_tbl VALUES
('1111-MATH', 'RAHUL', 10000),
('1111-MATH', 'RAKESH', 20000),
('2222-SCIENCE', 'AKASH', 10000),
('222-SCIENCE', 'ANDREW', 10000),
('22-CHEM', 'ANKIT', 25000),
('3333-CHEM', 'SONIKA', 12000),
('4444-BIO', 'HITESH', 2300),
('44-BIO', 'AKSHAY', 10000);

-- STEP 3: Main Query (Final Answer)
-- Extract department name using SUBSTRING_INDEX()
-- SUBSTRING_INDEX(id_deptname, '-', -1) takes text after '-'
-- Example: 1111-MATH -> MATH, 22-CHEM -> CHEM
SELECT
    SUBSTRING_INDEX(id_deptname, '-', -1) AS dept_name,
    SUM(salary) AS total_salary
FROM dept_tbl
GROUP BY dept_name
ORDER BY dept_name;

-- STEP 4: Alternative Query (First letter capital only)
-- Use this if output needs: Math, Science, Bio, Chem
SELECT
    CONCAT(UPPER(LEFT(SUBSTRING_INDEX(id_deptname, '-', -1), 1)),
           LOWER(SUBSTRING(SUBSTRING_INDEX(id_deptname, '-', -1), 2))) AS dept_name,
    SUM(salary) AS total_salary
FROM dept_tbl
GROUP BY dept_name
ORDER BY dept_name;