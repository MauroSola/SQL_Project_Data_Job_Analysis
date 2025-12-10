
SELECT
    COUNT(jpf.job_id) AS demand_count,
    sd.skills
FROM job_postings_fact jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location IN ('Argentina', 'Brazil','Uruguay','Paraguay','Chile','Colombia')
GROUP BY
    sd.skills
ORDER BY
    demand_count DESC
LIMIT 5
