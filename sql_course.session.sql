-- Unify 2 queries that categorizes jobs into 2 groups UNION ALL
-- those with salary info IS NOT NULL
-- those without IS NULL
--return: job_id,job_tittle and an indicator that the salary info is provided

(
SELECT
    job_id,
    job_title,
    'Without Salary' AS salary_info
FROM job_postings_fact jpf
WHERE
    salary_hour_avg IS NULL OR salary_year_avg IS NULL
)

UNION ALL

(
SELECT
    job_id,
    job_title,
    'With Salary' AS salary_info
FROM job_postings_fact jpf
WHERE
    salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
)