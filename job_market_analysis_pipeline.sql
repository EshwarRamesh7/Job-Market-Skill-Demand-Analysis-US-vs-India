-- =====================================================
-- Job Market Skill Demand Analysis
-- Author: Eshwar
-- Description: End-to-end SQL pipeline analyzing 
-- 50,425 US Data Analyst job postings (source: Kaggle,
-- Google Jobs aggregator) to identify in-demand skills,
-- salary patterns, and market trends.
-- =====================================================

-- ---------- SCHEMA CREATION ----------

CREATE TABLE postings (
    posting_id INT AUTO_INCREMENT PRIMARY KEY,
    title_clean VARCHAR(50),
    company_name VARCHAR(255),
    location_city VARCHAR(100),
    location_state VARCHAR(50),
    is_remote VARCHAR(20),
    via VARCHAR(100),
    posted_at VARCHAR(50),
    schedule_type VARCHAR(50),
    salary_min DECIMAL(10,2),
    salary_max DECIMAL(10,2),
    salary_avg DECIMAL(10,2),
    salary_standardized DECIMAL(10,2),
    has_salary VARCHAR(10)
);

CREATE TABLE skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(50) UNIQUE
);

CREATE TABLE posting_skills (
    posting_id INT,
    skill_id INT,
    PRIMARY KEY (posting_id, skill_id),
    FOREIGN KEY (posting_id) REFERENCES postings(posting_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

-- ---------- ANALYSIS QUERIES ----------

-- 1. Top 10 most in-demand skills
SELECT sk.skill_name, COUNT(*) AS posting_count
FROM posting_skills ps
JOIN skills sk ON ps.skill_id = sk.skill_id
GROUP BY sk.skill_name
ORDER BY posting_count DESC
LIMIT 10;

-- 2. Average salary by skill (min 50 postings)
SELECT sk.skill_name, COUNT(*) AS posting_count,
       ROUND(AVG(p.salary_standardized), 0) AS avg_salary
FROM posting_skills ps
JOIN skills sk ON ps.skill_id = sk.skill_id
JOIN postings p ON ps.posting_id = p.posting_id
WHERE p.has_salary = 'Yes'
GROUP BY sk.skill_name
HAVING posting_count >= 50
ORDER BY avg_salary DESC
LIMIT 15;

-- 3. Top hiring companies
SELECT company_name, COUNT(*) AS posting_count
FROM postings
GROUP BY company_name
ORDER BY posting_count DESC
LIMIT 15;

-- 4. Remote vs on-site salary comparison
SELECT is_remote, COUNT(*) AS posting_count,
       ROUND(AVG(salary_standardized), 0) AS avg_salary
FROM postings
GROUP BY is_remote;

-- 5. Job title / seniority breakdown
SELECT title_clean, COUNT(*) AS posting_count,
       ROUND(AVG(salary_standardized), 0) AS avg_salary
FROM postings
GROUP BY title_clean
ORDER BY posting_count DESC;

-- 6. Top locations (excluding remote/unspecified)
SELECT location_city, location_state, COUNT(*) AS posting_count
FROM postings
WHERE location_city NOT IN ('Anywhere', 'United States') AND location_city IS NOT NULL
GROUP BY location_city, location_state
ORDER BY posting_count DESC
LIMIT 15;

-- 7. Skill co-occurrence pairs
SELECT sk1.skill_name AS skill_a, sk2.skill_name AS skill_b, COUNT(*) AS together_count
FROM posting_skills ps1
JOIN posting_skills ps2 ON ps1.posting_id = ps2.posting_id AND ps1.skill_id < ps2.skill_id
JOIN skills sk1 ON ps1.skill_id = sk1.skill_id
JOIN skills sk2 ON ps2.skill_id = sk2.skill_id
GROUP BY skill_a, skill_b
ORDER BY together_count DESC
LIMIT 15;

-- 8. Job board / source breakdown
SELECT via, COUNT(*) AS posting_count
FROM postings
GROUP BY via
ORDER BY posting_count DESC
LIMIT 15;

-- 9. Schedule type with salary
SELECT schedule_type, COUNT(*) AS posting_count,
       ROUND(AVG(salary_standardized), 0) AS avg_salary
FROM postings
GROUP BY schedule_type
ORDER BY posting_count DESC;

-- 10. Senior vs Junior skill comparison
SELECT p.title_clean, sk.skill_name, COUNT(*) AS posting_count
FROM posting_skills ps
JOIN skills sk ON ps.skill_id = sk.skill_id
JOIN postings p ON ps.posting_id = p.posting_id
WHERE p.title_clean IN ('Senior Data Analyst', 'Junior/Entry Data Analyst')
GROUP BY p.title_clean, sk.skill_name
ORDER BY p.title_clean, posting_count DESC;

-- 11. Data completeness check (% postings with identifiable skills)
SELECT 
    (SELECT COUNT(DISTINCT posting_id) FROM posting_skills) AS postings_with_skills,
    (SELECT COUNT(*) FROM postings) AS total_postings,
    ROUND(100.0 * (SELECT COUNT(DISTINCT posting_id) FROM posting_skills) / (SELECT COUNT(*) FROM postings), 1) AS pct_with_skills;