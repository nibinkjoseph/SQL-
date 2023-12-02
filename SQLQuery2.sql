use [SQL Practice Linkedin]

select * from dbo.staff;

select * from [dbo].[company_regions]

select * from [dbo].[company_divisions]


SELECT top 5 * 
FROM company_divisions


/* How many total employees in this company */
SELECT COUNT(*) FROM staff;


/* What about gender distribution? */
SELECT gender, COUNT(*) AS total_employees
FROM staff
GROUP BY gender;

select * from staff


/* How many employees in each department */
select department, count(*) as total_employeess
from staff
group by department
order by department


/*How many distinct departments ? */

select  distinct(department)
from staff


/* What is the highest and lowest salary of employees? */
SELECT 
	Max(salary) as Max_salary,
	Min(salary) as Min_salary
from staff


/* what about salary distribution by gender group? */
SELECT gender, MIN(salary) As Min_Salary, MAX(salary) AS Max_Salary, AVG(salary) AS Average_Salary
FROM staff
GROUP BY gender;

/* How much total salary company is spending each year? */
SELECT SUM(salary)
FROM staff



/* want to know distribution of min, max average salary by department */
/* Data Interpretation: It seems like Outdoors deparment has the highest average salary paid  and Jewelery department with lowest */ 
SELECT
	department, 
	MIN(salary) As Min_Salary, 
	MAX(salary) AS Max_Salary, 
	AVG(salary) AS Average_Salary, 
	COUNT(*) AS total_employees
FROM staff
GROUP BY department
ORDER BY 5 DESC;




/* how spread out those salary around the average salary in each department ? */
/* Data Interpretation: Although average salary for Outdoors is highest among deparment, it seems like data points
are pretty close to average salary compared to other departments. */
SELECT 
	department, 
	MIN(salary) As Min_Salary, 
	MAX(salary) AS Max_Salary, 
	AVG(salary) AS Average_Salary,
	VAR(salary) AS Variance_Salary,
	STDEVP(salary) AS StandardDev_Salary,
	COUNT(*) AS total_employees
FROM staff
GROUP BY department
ORDER BY 4 DESC;


/* which department has the highest salary spread out ? */
/* Data Interpretation: based on the findings, Health department has the highest spread out. So let's find out more */
SELECT 
	department, 
	MIN(salary) As Min_Salary, 
	MAX(salary) AS Max_Salary, 
	ROUND(AVG(salary),2) AS Average_Salary,
	ROUND(VAR(salary),2) AS Variance_Salary,
	ROUND(STDEV(salary),2) AS StandardDev_Salary,
	COUNT(*) AS total_employees
FROM staff
GROUP BY department
ORDER BY 7 DESC;


/* how spread out those salary around the average salary in each department ? */
/* Data Interpretation: Although average salary for Outdoors is highest among deparment, it seems like data points
are pretty close to average salary compared to other departments. */
SELECT 
	department, 
	MIN(salary) As Min_Salary, 
	MAX(salary) AS Max_Salary, 
	AVG(salary) AS Average_Salary,
	VAR(salary) AS Variance_Salary,
	STDEV(salary) AS StandardDev_Salary,
	COUNT(*) AS total_employees
FROM staff
GROUP BY department
ORDER BY 4 DESC;




/* which department has the highest salary spread out ? */
/* Data Interpretation: based on the findings, Health department has the highest spread out. So let's find out more */
SELECT 
	department, 
	MIN(salary) As Min_Salary, 
	MAX(salary) AS Max_Salary, 
	ROUND(AVG(salary),2) AS Average_Salary,
	ROUND(VAR(salary),2) AS Variance_Salary,
	ROUND(STDEV(salary),2) AS StandardDev_Salary,
	COUNT(*) AS total_employees
FROM staff
GROUP BY department
ORDER BY 6 DESC;


/* Let's see Health department salary */
SELECT department, salary
FROM staff
WHERE department like 'Health'
ORDER BY 2 ASC;


/* we will make 3 buckets to see the salary earning status for Health Department */

CREATE VIEW Health_dept_earning_status_s
AS
	SELECT
		CASE
			WHEN salary>= 100000 then 'high salary'
			when salary>= 50000 and salary < 100000 then 'middle earner'
			else 'low earner'
		END AS Earning_status
	from staff
	where department like 'Health'


/* we can see that there are 24 high earners, 14 middle earners and 8 low earners */
select Earning_status, count(*) as count
from Health_dept_earning_status_s
group by Earning_status
order by count desc;


SELECT department, salary
FROM staff
WHERE department LIKE 'Outdoors'
ORDER BY 2 ASC;


create view Outdoor_salary_range
as
	select
		case
			when salary>= 100000 then 'high earner'
			when salary>=50000 and salary<100000 then'middle earner'
			else'low earner'
		end as earning_status
	from staff
	where department like 'Outdoors'


	select earning_status, count(*)
	from Outdoor_salary_range
	group by earning_status;

	/* we can see that there are 34 high earners, 12 middle earners and 2 low earners */


	SELECT
	DISTINCT(department)
FROM staff
WHERE department LIKE 'B%';



SELECT DISTINCT(lower(department))
FROM staff
ORDER BY 1;



/*** Concatetation ***/
SELECT 
	last_name,
	job_title  ' - '  department AS title_with_department 
FROM staff;