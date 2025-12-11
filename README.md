# Introduction
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

SQL Queries found here: [project_sql](/project_sql/)

# Background

Driven by a desire to navigate the data analyst job market more effectively, this project was born from a want to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

Data hails from Luke Barouse's SQL Course. It's packed with insights on job titles, salaries, locations, and essential skills.

The questions I wanted to answer through my SQL queries were the follwing:

1- What are the **top-paying data analyst jobs**?

2- What **skills are required** for these top-paying jobs?

3- What **skills are most in demand** for data analysts?

4- Which **skills are associated with higher salaries**?

5- What are the most **optimal skills to learn**?

You may find on [project_sql](/project_sql/) one query for each corresponding question.


# Tools used

For this deep dive into the data analyst job market, I used several key tools:

 - **SQL**: The backbone of the analysis, allowing me to query the databases and derive insights.
- *PostgreSQL**: The chosen database management system, used for handling the job posting data.
- **Visual Studio Code**: Code Editor of choice for database management and executing SQL queries.
- **Git & GitHub**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# Analysis

Each query for this project aimed at investigating specific aspects of the data analyst job market. All queries have been filtered to target **Data Analyst** roles in **Argentina, Brazil,Chile,Colombia,Paraguay and Uruguay**

Here’s how I approached each question:

##1-Top Paying Data Analyst Jobs

To identify the highest-paying roles, I filtered data analyst roles by average yearly salary and location. This query highlights the high paying opportunities in the field.

```
SELECT
    job_id,
    job_title,
    cd.name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE
    jpf.job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_location IN ('Argentina', 'Brazil','Uruguay','Paraguay','Chile','Colombia')
ORDER BY
    salary_year_avg DESC
LIMIT 10
```
Here's the breakdown of the top data analyst jobs in 2023 for the specified LATAM Countries:
- **Wide Salary Range**: Top 10 paying data analyst roles span from $64,000 USD to $156,000 USD, indicating significant salary potential in the field.
- **Job Title Variety**: There's a high diversity in job titles, from Data Analyst to Data Architect, reflecting varied roles and specializations within data analytics.

![Screenshot of Graph showing the chart for query 1](project_sql\query1chart.png)

*Bar graph visualizing the salary for the top 10 salaries for data analysts; chart generated on Excel based on query results*

## 2. Skills for Top Paying Jobs

To understand what skills are required for the top-paying jobs, I joined the job postings dataset with that of the skills data, providing insights into what employers value for high-compensation roles.

```
WITH top_10_jobs AS (
    SELECT
        job_id,
        job_title,
        cd.name,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date
    FROM job_postings_fact jpf
    LEFT JOIN company_dim AS cd
        ON jpf.company_id = cd.company_id
    WHERE
        jpf.job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_location IN ('Argentina', 'Brazil','Uruguay','Paraguay','Chile','Colombia')
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_10_jobs.*,
    skills
FROM top_10_jobs
INNER JOIN skills_job_dim 
    ON top_10_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

**Python** is leading with a bold count of 5.
**SQL** follows closely with a bold count of 4.
**Excel** is also highly sought after, with a count of 3. 
Other skills like AWS, Azure, Bitbucket show varying degrees of demand.


![Screenshot of the graph for query 2](project_sql\query2chart.png)

*Bar graph visualizing the salary for the top 10 salaries for data analysts; chart generated on Excel based on query results*

## 3. In-Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings,  focusing on areas with high demand.

```
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
```

Here's the breakdown of the most demanded skills for data analysts in 2023

- **SQL and Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.

- **Programming and Visualization Tools** like **Python, Tableau, and Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.


| demand_count  | Skills |
| ------------- | ------------- |
| 590  | SQL |
| 393 | Python  |
| 336 | Excel |
| 324 | Power BI |
282 | Tableau
 
 *Table of the demand for the top 5 skills in data analyst job postings*


## 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```
SELECT
    ROUND (AVG(jpf.salary_year_avg),0) AS salary_avg_year,
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
    sd.skills
ORDER BY
    salary_avg_year DESC
LIMIT 25
```

Here's a breakdown of the results for top paying skills for Data Analysts:

- **High Demand for Big Data & Distributed Computing Skills**
Top salaries cluster around technologies built for high-volume data processing. Skills like **Go, Hadoop, Scala, Spark, NoSQL, and Java** all reach the highest salary tier, showing how strongly the market rewards analysts who can work across distributed systems, scalable data backend environments.

- **Cloud Engineering & Platform Expertise**
Cloud skills continue to command higher pay. **AWS, Databricks, and Azure** appear high on the list, reinforcing the trend that companies highly value analysts who can operate in cloud-native data ecosystems and handle modern data infrastructure.

- **Core Programming & Automation Skills**
Languages and tools that support automation and analytics — such as **Python, Flow**, and even more niche tools like **Chef and Notion** — remain strong earners. Their presence reflects a shift toward analysts who can build automated processes, support DevOps-style operations, and improve cross-team efficiency.

| salary_avg_year  | skills |
| ------------- | ------------- |
| 156500  | go  |
| 156500  | hadoop |
156500    | scala 
156500     |spark
156500|nosql
156500|java
128500 | aws
128500 | databricks
106433 | azure
104643 | python
100500  | chef
100500  | notion
89845  | sql
88001 | flow

*Table of the average salary for the top 15 paying skills for data analysts*

## 5. Most Optimal Skills to Learn
Combining insights from demand and salary data queries, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```
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
```

| skills     | skill_demand_count | avg_salary |
|------------|---------------------|------------|
| databricks | 2                   | 128500     |
| aws        | 2                   | 128500     |
| azure      | 3                   | 106433     |
| python     | 7                   | 104643     |
| sql        | 9                   | 89845      |
| flow       | 2                   | 88001      |
| power bi   | 4                   | 81117      |
| excel      | 3                   | 65300      |
| tableau    | 3                   | 63000      |
| oracle     | 2                   | 62734      |

- **High-Value Cloud & Big Data Skills:**
Cloud platforms like **Databricks and AWS** combine strong salaries ($128,500 each) with steady demand (2 postings each). 
**Azure** also ranks highly with a salary of $106,433 and 3 postings, highlighting that cloud-driven analytics remains one of the most financially rewarding areas.

- **Core Programming & Data Manipulation Skills:**
P**ython stands out with one of the highest demand counts (7 postings) and a competitive average salary of $104,643, showing it's still a foundational skill for analysts who work with modeling, automation, or data pipelines. 
**SQL**, with the highest demand in the list (9 postings) and a salary near $89,845, remains essential for querying and managing data across industries.

- **Business Intelligence & Traditional Analytics Tools:**
Tools like **Power BI** (4 postings, $81,117), **Excel** (3 postings, $65,300), and **Tableau** (3 postings, $63,000) continue to be widely required for reporting and visualization. **Oracle** (2 postings, $62,734) reflects ongoing demand for classic database systems, especially in enterprise environments


# What I've learned

Throughout this journey, I've packed my SQL toolkit with some serious arsenal:

🧩 **Complex Query Crafting:** Mastered the art of SQL, merging tables and wielding WITH clausesfor temp table maneuvers.

**📊 Data Aggregation:** Got comfortable with GROUP BY and turned aggregate functions like COUNT() and AVG().

**💡 Analytical Skills**: Leveled up my problem-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions

Insights

From the analysis, several general insights emerged:

- **Top-Paying Data Analyst Jobs:** The highest-paying jobs for data analysts in selected LATAM countries offer a wide range of salaries, the highest at $156,000!

- **Skills for Top-Paying Jobs:** High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.

- **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.

- **Skills with Higher Salaries:** Specialized skills, such as Go and Hadoop, are associated with the highest average salaries, indicating a premium on niche expertise.

- **Optimal Skills for Job Market Value:** SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

## Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.
