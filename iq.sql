-- 2nd Highest Salary
-- Write a SQL query to select the 2nd highest salary in the engineering department.
-- Note: If more than one person shares the highest salary, the query should select the next highest salary.

WITH ranks AS (
    SELECT 
        salary, department_id,
        DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS ranking
    FROM employees
)

SELECT salary
FROM ranks
WHERE department_id = 1 AND ranking = 2;

-- Employees Salaries:
-- Given a employees and departments table, select the top 3 departments with at least ten employees and 
-- rank them according to the percentage of their employees making over 100K in salary.

WITH data AS (
    SELECT 
        e.salary, d.name AS departmant_name
    FROM employees AS e
    INNER JOIN departments AS d
    ON e.department_id = d.id
)
    SELECT 
        COUNT(CASE WHEN salary > 100000 THEN 1 END) / COUNT(salary) AS employees_over_100K,
        departmant_name,
        COUNT(*) AS number_of_employess
    FROM data
    GROUP BY 2
        HAVING COUNT(*) >= 10
    LIMIT 3;

-- Empty Neighborhoods
-- We’re given two tables, a users table with demographic information and the neighborhood they live in and a neighborhoods table.

-- Write a query that returns all neighborhoods that have 0 users. 

WITH neighborhood_data AS (
    SELECT n.name, u.id
    FROM neighborhoods as n
    LEFT JOIN users as u
    ON n.id = u.neighborhood_id
)
SELECT name
FROM neighborhood_data
GROUP BY name
HAVING COUNT(id) = 0;

-- Last Transaction

-- Given a table of bank transactions with columns id, transaction_value, and created_at representing the date and time for each transaction, write a query to get the last transaction for each day.

-- The output should include the id of the transaction, datetime of the transaction, and the transaction amount. Order the transactions by datetime.

SELECT 
    id, 
    created_at,
    transaction_value
    FROM bank_transactions
    WHERE created_at IN (
        SELECT 
            MAX(created_at)
            FROM bank_transactions
            GROUP BY DATE(created_at)
    )
    ORDER BY created_at;