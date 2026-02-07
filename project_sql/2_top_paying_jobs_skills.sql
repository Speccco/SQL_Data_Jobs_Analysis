-- What skills are required for the top-paying Data Scientist jobs?!
WITH jobs_company AS (
    SELECT j.job_id,
        j.job_title,
        j.salary_year_avg,
        c.name
    FROM job_postings_fact j
        LEFT JOIN company_dim c ON j.company_id = c.company_id
    WHERE j.salary_year_avg IS NOT NULL
        AND job_title_short ILIKE 'Data Scientist'
)
SELECT j.*,
    STRING_AGG(s.skills, ', ') AS skills
FROM jobs_company j
    INNER JOIN skills_job_dim sj ON j.job_id = sj.job_id
    INNER JOIN skills_dim s ON sj.skill_id = s.skill_id
WHERE s.skills IS NOT NULL
GROUP BY j.job_id,
    j.name,
    j.job_title,
    j.salary_year_avg
ORDER BY j.salary_year_avg DESC
LIMIT 10