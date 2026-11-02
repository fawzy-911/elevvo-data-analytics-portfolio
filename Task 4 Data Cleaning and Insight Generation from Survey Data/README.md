# Insight Generation from Survey Data — Kaggle 2021

## Project goal

This project completes Task 4 of the Elevvo Data Analytics Internship using the original Kaggle Machine Learning & Data Science Survey 2021 response file. It documents data-quality issues, cleans the working copy, handles categories, and reports survey findings with tables and charts.

## Source data

The original file is from Kaggle's [official 2021 survey page](https://www.kaggle.com/competitions/kaggle-survey-2021/data). The download also includes official answer-choice and methodology PDFs.

`kaggle_survey_2021_responses.csv` is the **raw/original Kaggle file**. It has 25,974 rows including the first row containing question wording, 25,973 respondent records, and 369 columns. The original is not overwritten.

## Data quality and cleaning

The notebook checks the data before cleaning and shows the findings in a table and chart:

- Separates the question-wording row from the respondent records.
- Found 8,392,838 missing response cells (87.6% of respondent cells). Missing values are retained because many questions were conditional and multi-select questions are stored across several columns.
- Checks exact duplicate respondent rows and removes them if present.
- Found 413,723 text values with leading/trailing whitespace and trimmed them.
- Keeps categorical labels readable instead of applying arbitrary numeric codes to unordered values.
- Adds a standardized gender field while preserving source `Q2` and its distinct response categories.

Cleaning is performed on an in-memory copy. `kaggle_survey_2021_responses.csv` remains the raw source, and the cleaned analysis copy is saved as `kaggle_survey_2021_cleaned.csv`.

## Findings from the supplied source

| Finding | Result |
|---|---:|
| Largest country group | India — 7,434 respondents |
| Most common role | Student — 6,804 respondents |
| Largest age group | 25–29 — 4,931 respondents |
| Most common gender response | Man — 20,598 respondents |
| Most selected regular programming language | Python — 21,860 respondents |

The raw quality check found 8,392,838 missing cells (87.6%), 413,723 text values with surrounding spaces, and 0 exact duplicate response rows. The notebook contains executed outputs, including tables and four charts: missingness by field, respondent profile, programming languages, and the five-insight summary. Counts come from different survey questions and have different response bases, so they should not be treated as directly comparable rates.

## Limitations

This was a voluntary Kaggle community survey. It describes the respondents and does not necessarily represent all data science professionals. Missing values are not imputed because blank cells may reflect survey routing rather than bad data.

## Files

| File | Description |
|---|---|
| `Kaggle_Survey_2021_Cleaning_and_Insights.ipynb` | Executed notebook with code outputs, tables, and charts |
| `kaggle_survey_2021_responses.csv` | Original Kaggle survey response file (raw source) |
| `kaggle_survey_2021_cleaned.csv` | Cleaned working copy created by the notebook |
| `supplementary_data/kaggle_survey_2021_answer_choices.pdf` | Official survey answer choices |
| `supplementary_data/kaggle_survey_2021_methodology.pdf` | Official survey methodology |

## Run the notebook

Keep the notebook and CSV in the same folder. Install dependencies if necessary:

```bash
pip install pandas matplotlib jupyter
```

Open the notebook in Jupyter or VS Code and run the cells from top to bottom.

