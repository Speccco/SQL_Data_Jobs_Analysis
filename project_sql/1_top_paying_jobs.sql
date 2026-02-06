-- What are the top-paying jobs for my role?
SELECT c.name AS company_name,
    j.job_title,
    j.job_country,
    j.job_schedule_type,
    j.job_posted_date::DATE,
    j.salary_year_avg
FROM job_postings_fact j
    LEFT JOIN company_dim c ON j.company_id = c.company_id
WHERE j.salary_year_avg IS NOT NULL
    AND job_title_short ILIKE 'Data Scientist'
ORDER BY j.salary_year_avg DESC
LIMIT 10