# 📊 Job Market Skill Demand Analysis — US vs India

## 📌 Overview
A comparative analysis of Data Analyst hiring demand across the **US and Indian job markets**, built through a full data pipeline — from raw job postings to an interactive Power BI dashboard — to uncover which skills employers actually demand, and how compensation differs across regions.

## 🎯 Business Objective
- Identify the most in-demand skills for Data Analyst roles in the US vs. India
- Quantify the salary gap between the two markets
- Determine what differentiates senior-level postings from entry-level ones
- Provide a data-backed skill-prioritization guide for job seekers and career switchers

## 🗂️ Dataset
| Market | Source | Size |
|---|---|---|
| 🇺🇸 US | [Data Analyst Job Postings — Kaggle](https://www.kaggle.com/datasets/lukebarousse/data-analyst-job-postings-google-search) | 50,969 cleaned postings |
| 🇮🇳 India | Adzuna API | 544 postings |

> **Note:** The India dataset is limited by Adzuna's free-tier API, which truncates job descriptions — resulting in ~25% skill-extraction coverage for that market. This is disclosed directly on the dashboard and factored into how India-market conclusions are framed.

## ⚙️ Tools & Technologies
`Excel` · `MySQL` · `Python (Pandas, Regex)` · `Adzuna API` · `Power BI`

## 🔄 Pipeline — Four Stages

**1. Data Cleaning (Excel)**
Standardized raw postings — removed duplicates, normalized job titles, handled missing salary fields.

**2. Relational Modeling (MySQL)**
Designed a three-table relational schema (jobs, skills, companies) and loaded cleaned data via `LOAD DATA INFILE` for efficient querying.

**3. Skill Extraction (Python)**
Built a **134-skill vocabulary** and used regex-based extraction to parse skills mentioned in job descriptions across both markets — the core signal for the whole analysis.

**4. Dashboard (Power BI)**
Three-page interactive dashboard: **US Overview**, **India Overview**, and **Comparison** — light, card-based design with a five-color muted accent system for clarity.

## 🖼️ Dashboard Preview
![US Overview](images/us_overview.png)
![India Overview](images/india_overview.png)
![Comparison](images/comparison.png)

## 💡 Key Findings
- **SQL is the #1 in-demand skill in both markets** — the single most universally required skill for Data Analyst roles regardless of geography
- **~7.9x salary gap** between US and India Data Analyst compensation (USD-equivalent)
- **Cloud skills are the clearest senior-level differentiator** — postings requiring AWS/Azure/GCP skew heavily toward senior and higher-paying roles, marking a clear skill investment for career growth
- Core skill sets overlap significantly between markets, but tooling emphasis shifts at the senior level

## 📁 Repo Structure

├── data/
│ ├── us_postings_cleaned.csv
│ └── india_postings_cleaned.csv
├── sql/
│ └── schema_and_load.sql
├── scripts/
│ └── skill_extraction.py
├── dashboard/
│ └── job_market_analysis.pbix
├── images/
│ ├── us_overview.png
│ ├── india_overview.png
│ └── comparison.png
└── README.md

## 🚀 How to Run
```bash
pip install pandas mysql-connector-python
# 1. Load schema: mysql -u <user> -p < sql/schema_and_load.sql
# 2. Run skill extraction: python scripts/skill_extraction.py
# 3. Open dashboard/job_market_analysis.pbix in Power BI Desktop
```

## ⚠️ Limitations
- India dataset (Adzuna free-tier) has ~25% skill-extraction coverage due to description truncation — India-market findings should be read as directional, not exhaustive
- Sample size imbalance (50,969 US vs. 544 India postings) means market comparisons weight toward US-market patterns

## 👨‍💻 Author
**Eshwar Ramesh**
Aspiring Data Analyst | Power BI Developer
📧 eshwarramesh1985@gmail.com
🌐 [Github](https://github.com/EshwarRamesh7) · [Portfolio](https://eshwarrameshportfolio.netlify.app)
