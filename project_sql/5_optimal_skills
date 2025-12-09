WITH skill_demand AS(
    SELECT
        sd.skill_id,
        COUNT(jpf.job_id) AS skill_demand_count,
        sd.skills
    FROM job_postings_fact jpf
    INNER JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd
        ON sjd.skill_id = sd.skill_id
    WHERE
        salary_year_avg IS NOT NULL AND
        job_title_short = 'Data Analyst' AND
        job_location IN ('Argentina', 'Brazil','Uruguay','Paraguay','Chile','Colombia')
    GROUP BY
        sd.skill_id
), highest_paid_skills AS(  
    SELECT
        sjd.skill_id,
        ROUND (AVG(jpf.salary_year_avg),0) AS salary_avg_year
    FROM job_postings_fact jpf
    INNER JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    WHERE
        salary_year_avg IS NOT NULL AND
        job_title_short = 'Data Analyst' AND
        job_location IN ('Argentina', 'Brazil','Uruguay','Paraguay','Chile','Colombia')
    GROUP BY
        sjd.skill_id
    )

SELECT
    skill_demand.skills,
    skill_demand.skill_demand_count,
    ROUND(hps.salary_avg_year,2) AS avg_salary
FROM skill_demand 
INNER JOIN highest_paid_skills AS hps
    ON skill_demand.skill_id = hps.skill_id
WHERE
    skill_demand.skill_demand_count > 1
ORDER BY
    avg_salary DESC,
    skill_demand_count DESC
;