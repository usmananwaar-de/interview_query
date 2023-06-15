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