# Job Market Skills Intelligence — US vs India
## Project explanation and interview preparation

### Project summary

This project compares Data Analyst job postings in the United States and India to identify frequently requested skills, salary patterns and differences by role. It combines Python-based data preparation, a relational MySQL analysis layer and a Power BI dashboard.

**60-second interview pitch**

“I built a comparative job-market analysis for Data Analyst roles in the US and India. I worked with a large US job-posting sample and a smaller India sample collected through the Adzuna API. The workflow included cleaning job-posting data, organising postings and skills into a relational structure, using SQL to analyse skill demand and salary patterns, and presenting the results in a three-view Power BI dashboard. I also considered source limitations, especially the difference in sample sizes and incomplete skill coverage in the India API data.”

### Business problem

The project asks which skills are most frequently associated with Data Analyst roles, which skills overlap across markets, how salary patterns vary by market and role, which skills appear more often in senior postings, and how reliable the comparisons are.

### Data and sources

The US dataset comes from a Kaggle dataset based on a Google Jobs aggregator and is described as approximately 50,000 postings. India postings were collected through the Adzuna API, with 544 cleaned postings noted in the project. The work uses a vocabulary of 134 skills.

The India free-tier source can truncate job descriptions. Therefore, fewer postings may contain enough text for complete skill extraction. The US and India samples should not be treated as equally comprehensive.

### Technical workflow

1. **Collection and cleaning:** Python and Pandas standardise job titles, clean fields and remove duplicates. Adzuna credentials should be supplied through environment secrets.
2. **Relational model:** a postings table stores job attributes; a skills table stores the skill vocabulary; a posting_skills bridge table represents the many-to-many relationship.
3. **SQL:** queries cover top skills, average salary by skill, companies, remote work, location, seniority, skill co-occurrence and data completeness.
4. **Power BI:** three views compare US, India and the markets side by side.

### Findings and interpretation

SQL is identified as a leading skill in both markets. The original project reports an approximately 7.9× US-to-India salary ratio after normalisation and identifies cloud technologies as more prevalent in senior roles.

In an interview, explain how salaries were standardised: annual/monthly/hourly units, currency conversion date, range midpoint or average, and treatment of missing values. The 7.9× result is specific to this dataset and set of assumptions.

### Interview questions and suggested answers

**1. Why use two data sources?**  
The project needed coverage for both markets, and the available sources differed by country. This improved geographic coverage but introduced differences in sampling and field quality.

**2. How are skills extracted from job descriptions?**  
The project uses a predefined skill vocabulary and text matching. A robust approach includes text normalisation, aliases and word-boundary checks. Short names such as “R” require special handling to avoid false positives.

**3. Why use a bridge table for skills?**  
One posting can mention many skills and each skill can appear in many postings. A posting_skills bridge table models this many-to-many relationship without storing a list of skills in a single field.

**4. How should skill demand be counted?**  
Join postings to the bridge table and skill table, then count distinct postings for each skill. Distinct counts prevent duplicate associations from inflating demand.

**5. How do you handle missing salary values?**  
Keep missing salary as unknown, exclude it from salary averages and report how many postings remain. Replacing missing salary with zero would bias the result.

**6. Why is the sample-size difference important?**  
The US sample is far larger. Raw counts are not directly comparable. Within-market percentages are more useful, but source coverage and missing descriptions still affect the comparison.

**7. How would you compare salaries fairly?**  
Use a common currency and salary period, define how salary ranges are represented, document the exchange-rate date and compare similar job levels. Missing and ambiguous salaries should be excluded or separately analysed.

**8. What is skill co-occurrence?**  
It measures which pairs of skills are mentioned in the same posting. It can identify common combinations but does not show that one skill causes demand for another.

**9. What are the limitations of regex-based extraction?**  
It can miss synonyms and variants and can produce false matches for short terms. A curated alias dictionary, token boundaries and manual quality checks can improve accuracy.

**10. What does a salary-by-skill query tell you?**  
It compares salary values among postings that mention each skill. It is descriptive and may be affected by seniority, geography, industry and job title.

**11. Why is data completeness important?**  
If one source provides less description text, the skill model has fewer opportunities to detect skills. Reporting extraction coverage helps prevent overconfident market conclusions.

**12. How would you improve this project?**  
Collect both markets over the same period, improve India coverage, package the extraction code as a tested module, standardise salary units explicitly and document source-level data-quality checks.

### Limitations to be ready to discuss

- Different sources and sample sizes can bias the comparison.
- India job-description truncation affects skill extraction coverage.
- The salary ratio depends on normalisation assumptions.
- Exact source counts need reconciliation before they are quoted.
- The standalone extraction script named in an older README is not in the current repository.

### Resume bullet

Developed a US–India Data Analyst job-market analysis using Python, MySQL and Power BI to compare skill demand, salary patterns and seniority signals while documenting sampling and source-coverage limitations.

### Files

- [Python notebook](../Job%20market.ipynb)
- [SQL pipeline](../job_market_analysis_pipeline.sql)
- [Power BI report](../Data%20Analyst%20Project.pbix)
- [Presentation](../JobMarket_Portfolio_Deck.pptx)
