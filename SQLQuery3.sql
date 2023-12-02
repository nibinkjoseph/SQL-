/**************** Data Wrangling / Data Munging *************/

SELECT DISTINCT(department)
FROM staff
ORDER BY department;



/********* Reformatting Characters Data *********/

SELECT DISTINCT(UPPER(department))
FROM staff
ORDER BY 1;




/*** Concatetation ***/
SELECT 
	last_name,
	concat(job_title, ' - ', department) AS title_with_department 
FROM staff;



/*** Trim ***/
SELECT
	TRIM('    data sciece rocks !    ');






-- without trim is 27 characters
SELECT
	LEN('    data sciece rockds !    ');






/* How many employees with Assistant roles */
select
	[job_title],
	count(*) as employee_with_role
from staff
where [job_title] like '%Assistant%'
group by [job_title];






/* What are those Assistant roles? */
SELECT DISTINCT(job_title)
FROM staff
WHERE job_title LIKE '%Assistant%'
ORDER BY 1;










SELECT 
    DISTINCT job_title,
    CASE WHEN job_title LIKE '%Assistant%' THEN 1 ELSE 0 END AS is_assistant_role
FROM staff
ORDER BY 1;



SELECT job_title
FROM staff
WHERE job_title LIKE 'Assistant%';





/* We want to extract job category from the assistant position which starts with word Assisant */
SELECT 
	SUBSTRING(job_title) FROM LEN('Assistant')+1) AS job_category,
	job_title
FROM staff
WHERE job_title LIKE 'Assistant%';









SELECT 
    SUBSTRING(job_title, LEN('Assistant') + 1, LEN(job_title)) AS job_category,
    job_title
FROM staff
WHERE job_title LIKE 'Assistant%';



SELECT 
    SUBSTRING(job_title, CHARINDEX('Assistant', job_title) + LEN('Assistant') + 1, LEN(job_title)) AS job_category,
    job_title
FROM staff
WHERE job_title LIKE 'Assistant%';




SELECT DISTINCT
    SUBSTRING(job_title, CHARINDEX('Assistant', job_title) + LEN('Assistant') + 1, LEN(job_title)) AS job_category
FROM staff
WHERE job_title LIKE 'Assistant%';




SELECT
    REPLACE(job_title, 'Assistant', 'Asst.') AS modified_job_title
FROM staff;





SELECT
    CASE WHEN job_title LIKE 'Assistant%' THEN REPLACE(job_title, 'Assistant', 'Asst.')
         ELSE job_title
    END AS modified_job_title
FROM staff;


use [SQL Practice Linkedin]


SELECT
	s.last_name,s.salary,s.department,

	(SELECT ROUND(AVG(salary),6)
	 FROM staff s2
	 WHERE s2.department = s.department) AS department_average_salary
FROM staff s;



SELECT 
	department,
	last_name,
	salary,
	LAG(salary) OVER(PARTITION BY department ORDER BY salary DESC)
FROM staff;


use [SQL Practice Linkedin]






SELECT 
	department, job_title,
	last_name, 
	salary,
	AVG(salary) OVER (PARTITION BY department)  as avg_salary
FROM staff;


/* employee salary vs max salary of his/her department */

SELECT 
	department, 
	last_name, 
	salary,
	max(salary) over(partition by department) as max_salary
from staff;


/* employee salary vs min salary of his/her Company Region */

select
	department,
	[region_id],
    [last_name],
[salary], min(salary) over(partition by department) as min_salary
from staff;



SELECT
	department,
	last_name,
	salary,
	FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY salary DESC)
FROM staff;



SELECT
	department,
	last_name,
	salary,
	MAX(salary) OVER (PARTITION BY department)
FROM staff
ORDER BY department ASC, salary DESC;




/*Rank()*/


-- give the rank by salary decending oder withint the specific department group.
-- the ranking 1, 2, 3 will restart when it reaches to another unique group.
-- works same as Row_Number Function
SELECT
	department,
	last_name,
	salary,
	RANK() OVER (PARTITION BY department ORDER BY salary DESC) as rank
FROM staff;




select [department],[salary],[job_title],[last_name],
	rank() over(partition by department order by salary desc) as rank
from staff;


SELECT
	[department],
	[last_name],
	[salary],
ROW_NUMBER() over(partition by department order by salary desc)
from staff;


SELECT 
	department,
	last_name,
	salary,
	lead(salary) OVER(PARTITION BY department ORDER BY salary DESC) as lag_function
FROM staff;



SELECT 
	department,
	last_name,
	salary,
	NTILE(5) OVER(PARTITION BY department ORDER BY salary DESC)
FROM staff;
