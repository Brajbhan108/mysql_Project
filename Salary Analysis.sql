-- Objective : The main goal of this case study was to analyze salary trends, remote work patterns, and job roles across different locations and experience levels.
-- Dataset Description : The dataset includes columns such as work_year, experience_level, employment_type, job_title, salary, salary_currency, salaryinusd, employee_residence, remote_ratio, company_location, and company_size.
-- Data sourse : https://www.kaggle.com/datasets/arnabchaki/data-science-salaries-2023

--Key Queries :
-- Highest-Paying Roles: To identify top salaries in AI and Machine Learning fields
-- Remote vs. On-Site Salaries: To compare average salaries for fully remote, on-site, and hybrid roles.
-- Regional Salary Variation: To analyze average salaries by country.
-- Salaries by Experience Level: To compare average salaries across different experience levels.
-- Company Size and Salaries: To determine average salaries based on company size.
-- Top Average Salaries by Country: To identify countries with the highest average salaries.
-- Top-Paying Roles: To find roles like AI Architect and Data Science Tech Lead with high average salaries.
-- Salary Growth Over Years: To track average salary growth over different years.
-- Salaries Paid in USD: To analyze the dominance of salaries paid in USD.
-- Senior Remote Opportunities: To examine remote work availability and salaries for senior employees.

1. Top Salaries and Their Characteristics
SELECT * 
FROM salaries 
ORDER BY salary_in_usd DESC 
LIMIT 10;

2. Role of Remote Work and Location in Salary Variations
SELECT remote_ratio, 
       AVG(salary_in_usd) AS avg_salary, 
       MIN(salary_in_usd) AS min_salary, 
       MAX(salary_in_usd) AS max_salary
FROM salaries
GROUP BY remote_ratio
ORDER BY avg_salary DESC;

SELECT employee_residence, 
       AVG(salary_in_usd) AS avg_salary, 
       MIN(salary_in_usd) AS min_salary, 
       MAX(salary_in_usd) AS max_salary
FROM salaries
GROUP BY employee_residence
ORDER BY avg_salary DESC;

3. Experience Level vs. Salary Trends
SELECT experience_level, 
       AVG(salary_in_usd) AS avg_salary, 
       MIN(salary_in_usd) AS min_salary, 
       MAX(salary_in_usd) AS max_salary
FROM salaries
GROUP BY experience_level
ORDER BY avg_salary DESC;

4. Company Size and Its Impact on Salaries
SELECT company_size, 
       AVG(salary_in_usd) AS avg_salary, 
       MIN(salary_in_usd) AS min_salary, 
       MAX(salary_in_usd) AS max_salary
FROM salaries
GROUP BY company_size
ORDER BY avg_salary DESC;

5. Geographic Salary Trends
SELECT employee_residence, 
       AVG(salary_in_usd) AS avg_salary
FROM salaries
GROUP BY employee_residence
ORDER BY avg_salary DESC
LIMIT 10;

6. Salary Distributions Across Roles
SELECT job_title, 
       AVG(salary_in_usd) AS avg_salary, 
       MIN(salary_in_usd) AS min_salary, 
       MAX(salary_in_usd) AS max_salary
FROM salaries
GROUP BY job_title
ORDER BY avg_salary DESC
LIMIT 10;

7. Salary Trends Over Years
SELECT work_year, 
       AVG(salary_in_usd) AS avg_salary, 
       MIN(salary_in_usd) AS min_salary, 
       MAX(salary_in_usd) AS max_salary
FROM salaries
GROUP BY work_year
ORDER BY work_year ASC;

8. Role of Currency in Salaries
SELECT salary_currency, 
       AVG(salary_in_usd) AS avg_salary, 
       MIN(salary_in_usd) AS min_salary, 
       MAX(salary_in_usd) AS max_salary
FROM salaries
GROUP BY salary_currency
ORDER BY avg_salary DESC;

9. Correlation Between Remote Ratio and Experience Level
SELECT remote_ratio, experience_level, 
       AVG(salary_in_usd) AS avg_salary
FROM salaries
GROUP BY remote_ratio, experience_level
ORDER BY remote_ratio, experience_level;

10. Variability in Salaries for the Same Role
SELECT job_title, 
       MIN(salary_in_usd) AS min_salary, 
       MAX(salary_in_usd) AS max_salary, 
       (MAX(salary_in_usd) - MIN(salary_in_usd)) AS salary_range
FROM salaries
GROUP BY job_title
ORDER BY salary_range DESC
LIMIT 10;

11. Highest Salaries by Company Location
SELECT company_location, 
       MAX(salary_in_usd) AS highest_salary
FROM salaries
GROUP BY company_location
ORDER BY highest_salary DESC
LIMIT 10;

12. Lowest-Paying Roles
SELECT job_title, 
       AVG(salary_in_usd) AS avg_salary
FROM salaries
GROUP BY job_title
ORDER BY avg_salary ASC
LIMIT 10;

13. Most Common Job Titles
SELECT job_title, 
       COUNT(*) AS count
FROM salaries
GROUP BY job_title
ORDER BY count DESC
LIMIT 10;

14. Salary Inequality Between Roles
SELECT job_title, 
       MIN(salary_in_usd) AS min_salary, 
       MAX(salary_in_usd) AS max_salary, 
       (MAX(salary_in_usd) - MIN(salary_in_usd)) AS salary_gap
FROM salaries
GROUP BY job_title
ORDER BY salary_gap DESC
LIMIT 10;

15. Role-Specific Remote Work Trends
SELECT job_title, remote_ratio, 
       AVG(salary_in_usd) AS avg_salary
FROM salaries
GROUP BY job_title, remote_ratio
ORDER BY avg_salary DESC;

16. Impact of Region on Role Prevalence
SELECT employee_residence, job_title, 
       COUNT(*) AS count
FROM salaries
GROUP BY employee_residence, job_title
ORDER BY count DESC;

17. Salary Range for Mid-Level Roles
SELECT job_title, 
       MIN(salary_in_usd) AS min_salary, 
       MAX(salary_in_usd) AS max_salary, 
       AVG(salary_in_usd) AS avg_salary
FROM salaries
WHERE experience_level = 'MI'
GROUP BY job_title
ORDER BY avg_salary DESC;

18. Top Roles in Large Companies
SELECT job_title, 
       AVG(salary_in_usd) AS avg_salary
FROM salaries
WHERE company_size = 'L'
GROUP BY job_title
ORDER BY avg_salary DESC
LIMIT 10;

19. Salary Trends in AI vs. Data Roles
SELECT work_year, 
       AVG(CASE WHEN job_title LIKE '%AI%' THEN salary_in_usd END) AS avg_ai_salary,
       AVG(CASE WHEN job_title LIKE '%Data%' THEN salary_in_usd END) AS avg_data_salary
FROM salaries
GROUP BY work_year
ORDER BY work_year ASC;

20. Number of People Employed in Different Company Sizes in 2021
SELECT company_size, 
       COUNT(*) AS employee_count
FROM salaries
WHERE work_year = 2021
GROUP BY company_size
ORDER BY employee_count DESC;

21. Top 3 Job Titles with Highest Average Salary for Part-Time Positions in 2023 (Countries with >50 Employees)
WITH country_employee_count AS (
    SELECT employee_residence, 
           COUNT(*) AS employee_count
    FROM salaries
    GROUP BY employee_residence
    HAVING COUNT(*) > 50
)
SELECT job_title, 
       AVG(salary_in_usd) AS avg_salary
FROM salaries
WHERE work_year = 2023 
  AND employment_type = 'PT' 
  AND employee_residence IN (SELECT employee_residence FROM country_employee_count)
GROUP BY job_title
ORDER BY avg_salary DESC
LIMIT 3;

22. Countries Where Mid-Level Salaries Are Higher Than the Overall Average in 2023
WITH mid_level_avg_salary AS (
    SELECT AVG(salary_in_usd) AS overall_mid_salary
    FROM salaries
    WHERE work_year = 2023 AND experience_level = 'MI'
)
SELECT employee_residence, 
       AVG(salary_in_usd) AS mid_salary
FROM salaries
WHERE work_year = 2023 AND experience_level = 'MI'
GROUP BY employee_residence
HAVING AVG(salary_in_usd) > (SELECT overall_mid_salary FROM mid_level_avg_salary)
ORDER BY mid_salary DESC;

23. Company Locations with Highest and Lowest Average Salaries for Senior-Level Employees in 2023
SELECT company_location, 
       AVG(salary_in_usd) AS avg_salary
FROM salaries
WHERE work_year = 2023 AND experience_level = 'SE'
GROUP BY company_location
ORDER BY avg_salary DESC
LIMIT 1;

-- Lowest Salary
SELECT company_location, 
       AVG(salary_in_usd) AS avg_salary
FROM salaries
WHERE work_year = 2023 AND experience_level = 'SE'
GROUP BY company_location
ORDER BY avg_salary ASC
LIMIT 1;

24. Annual Salary Growth Rate for Job Titles
WITH yearly_salaries AS (
    SELECT work_year, job_title, 
           AVG(salary_in_usd) AS avg_salary
    FROM salaries
    GROUP BY work_year, job_title
),
growth_rate AS (
    SELECT a.job_title, 
           a.work_year AS current_year, 
           b.work_year AS previous_year, 
           ((a.avg_salary - b.avg_salary) / b.avg_salary) * 100 AS growth_rate
    FROM yearly_salaries a
    JOIN yearly_salaries b
      ON a.job_title = b.job_title AND a.work_year = b.work_year + 1
)
SELECT job_title, current_year, growth_rate
FROM growth_rate
ORDER BY growth_rate DESC;

25. Top 3 Countries with Highest Entry-Level Salary Growth (2020–2023)
WITH entry_salary_growth AS (
    SELECT employee_residence, 
           ((MAX(CASE WHEN work_year = 2023 THEN salary_in_usd END) - 
             MIN(CASE WHEN work_year = 2020 THEN salary_in_usd END)) /
             MIN(CASE WHEN work_year = 2020 THEN salary_in_usd END)) * 100 AS growth_rate
    FROM salaries
    WHERE experience_level = 'EN'
    GROUP BY employee_residence
    HAVING COUNT(*) > 50
)
SELECT employee_residence, growth_rate
FROM entry_salary_growth
ORDER BY growth_rate DESC
LIMIT 3;

26. Update Remote Work Ratio for Employees in US and AU Earning > $90,000
UPDATE salaries
SET remote_ratio = 50
WHERE employee_residence IN ('US', 'AU') 
  AND salary_in_usd > 90000
  AND remote_ratio != 50;

27. Update Salaries for Data Field Employees in 2024
UPDATE salaries
SET salary_in_usd = CASE 
    WHEN experience_level = 'EN' THEN salary_in_usd * 1.35
    WHEN experience_level = 'MI' THEN salary_in_usd * 1.30
    WHEN experience_level = 'SE' THEN salary_in_usd * 1.22
    WHEN experience_level = 'EX' THEN salary_in_usd * 1.20
    WHEN job_title LIKE '%Director%' THEN salary_in_usd * 1.15
    ELSE salary_in_usd
END
WHERE work_year = 2024 AND job_title LIKE '%Data%';

28. Year with Highest Average Salary for Each Job Title
SELECT job_title, 
       work_year, 
       AVG(salary_in_usd) AS avg_salary
FROM salaries
GROUP BY job_title, work_year
HAVING AVG(salary_in_usd) = (
    SELECT MAX(AVG(salary_in_usd)) 
    FROM salaries AS sub
    WHERE sub.job_title = salaries.job_title
    GROUP BY sub.job_title
);

29. Percentage of Employment Types by Job Title
SELECT job_title, 
       SUM(CASE WHEN employment_type = 'FT' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS full_time_pct,
       SUM(CASE WHEN employment_type = 'PT' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS part_time_pct
FROM salaries
GROUP BY job_title;

--Conclusion :
  AI and Machine Learning roles pay the highest, especially in the US and Canada, with salaries up to 800,000. Remote roles pay well, but on-site roles generally pay more. 
  The US, Canada, Israel, and Qatar offer high salaries, with salaries increasing significantly with experience and medium-sized companies paying the most. 
  Israel offers the highest average salaries. AI Architect and Data Science Tech Lead roles pay over 250,000. Salaries have grown steadily, with a big jump from 2022 to 2024. 
  Senior employees have more remote opportunities, which pay well.AI roles show large salary differences. The US and Canada offer the highest salaries. Admin and Data Analyst roles have the lowest salaries. Data Scientists and Analysts are in high demand. 
  AI Architect roles show significant salary disparities and are often remote. Mid-level AI Engineering roles have wide salary ranges. Large companies pay well for specialized roles, and AI roles have seen significant salary growth.


