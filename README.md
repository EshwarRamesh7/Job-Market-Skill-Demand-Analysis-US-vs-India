# Job Market Skills Intelligence — US vs India

A comparative analytics project exploring the skills, salaries and hiring patterns associated with Data Analyst roles in the United States and India.

**Tools:** Python · Pandas · MySQL · Excel · Power BI · Adzuna API

## Business question

Which skills appear most often in Data Analyst job postings in the US and India, how do the markets differ, and what should a job seeker prioritise when planning a skill-development path?

## Data sources and scope

| Market | Source | Project sample |
|---|---|---:|
| United States | Kaggle dataset based on Google Jobs postings | Approximately 50,000 postings |
| India | Adzuna API | 544 cleaned postings |

The project uses a 134-skill vocabulary. The India sample is considerably smaller, and the Adzuna free-tier API may truncate job descriptions. The resulting skill coverage is therefore incomplete. Treat the comparison as directional rather than a perfectly balanced labour-market study.

## Workflow

1. **Data collection and cleaning** — Python/Pandas and the Adzuna API for India postings; cleaned US posting data supplied as an Excel file.
2. **Relational modelling** — MySQL tables for postings, skills and posting-to-skill relationships.
3. **SQL analysis** — skill demand, salary by skill, companies, remote work, locations, job titles, co-occurring skills and data completeness.
4. **Reporting** — a three-page Power BI dashboard covering US overview, India overview and comparison.

## Findings recorded in the analysis

- SQL is identified as a leading skill in both markets.
- The original analysis reports an approximately **7.9× US-to-India salary difference** after currency normalisation.
- Cloud skills are highlighted as more prevalent in senior-level postings.
- Core skill overlap is meaningful, while the relative emphasis on tools changes by role and seniority.

The salary ratio is a project-specific estimate, not a universal market ratio. Comparisons depend on salary period, currency conversion, seniority and the set of postings with usable salary data.

## Dashboard previews

![US overview](images/Us%20Overview.png)

![India overview](images/India%20Overview.png)

![US vs India comparison](images/Comparison%20US%20vs%20India.png)

## Repository contents

- `Job market.ipynb` — Adzuna collection and India-data preparation.
- `job_market_analysis_pipeline.sql` — MySQL schema and analytical queries.
- `Data Analyst Project.pbix` — Power BI report.
- `JobMarket_Portfolio_Deck.pptx` — presentation.
- `data/` — cleaned US and India datasets.
- `images/` — dashboard screenshots.
- `docs/PROJECT_GUIDE_AND_INTERVIEW_QUESTIONS.md` — explanation and interview preparation.

## Reproducing the analysis

Install the notebook dependencies, configure Adzuna credentials using a secret manager, run the notebook and SQL script, then open the PBIX file in Power BI Desktop. Never commit API keys.

## Limitations

- US and India samples are materially different in size and source.
- India description truncation affects skill extraction coverage.
- Salary comparison depends on currency and salary-period normalisation.
- The historical README and SQL header contain slightly different US record counts. Confirm the final count before quoting an exact figure.
- The separately described `skill_extraction.py` is not currently present in this repository.

## Interview preparation

See [Project explanation and interview questions](docs/PROJECT_GUIDE_AND_INTERVIEW_QUESTIONS.md).

## Author

**Eshwar Ramesh** · [GitHub](https://github.com/EshwarRamesh7) · [Portfolio](https://eshwarrameshportfolio.netlify.app) · [LinkedIn](https://www.linkedin.com/in/eshwar-ramesh-9a4652251)
