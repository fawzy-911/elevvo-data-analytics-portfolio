# Task 6 — Web Scraping and Analysis of Job Postings

This project collects public remote-job listings from the HTML page at [We Work Remotely](https://weworkremotely.com/remote-jobs), then cleans and analyzes the results with Python.

## What the notebook does

- Checks the source site's `robots.txt` before requesting the listing page and each sampled detail page.
- Reads one HTML listings page with `requests` and BeautifulSoup. It does not use an API.
- Collects job title, company, company headquarters, work-location scope, posting-age label, categories, listing URL, and source.
- Fetches up to 15 job descriptions, one at a time with a one-second pause, to look for skill keywords.
- Removes duplicate links, standardizes text fields, estimates posting dates from relative labels, groups positions into broad role families, and compares location scopes and keyword mentions.
- Displays charts and saves raw and cleaned CSV files.

The source's `robots.txt` allows public pages. Its public feed page says that job data may be reused with attribution, and the site terms ask users to link back when using site data. Each record retains its original job URL. This notebook is a small, respectful educational sample, not a bulk crawler.

## Snapshot findings

The executed notebook contains the collected results and charts. It collected **64 unique listings** on **October 27, 2026**, and fetched full descriptions for **15** of them. In this snapshot, **Engineering & IT** was the largest grouped role family (24 listings), and **Anywhere in the World** was the most common work-location scope (33 listings). The most frequent skill/job keyword mentions were **marketing** and **sales** (12 listings each); these are text matches, not a manually validated skills taxonomy. Individual titles are mostly distinct, so role-family grouping is more useful than ranking exact titles.

Treat these as observations about the page at collection time, not a complete view of the labor market. This is a remote-job board, only a sample of descriptions is analyzed, relative posting dates are estimates, and keyword matching can miss skills or count contextually unrelated mentions.

## Files

- `Job_Postings_Scraping_and_Analysis.ipynb` — executed notebook with code, tables, charts, and findings.
- `job_postings_scraped_raw.csv` — scraped fields before cleaning, including page URLs and collection status.
- `job_postings_cleaned.csv` — normalized fields plus estimated posting date, role family, work-location scope, and skill text.

## Run it

Open the notebook in Jupyter and run the cells from top to bottom. It requires `requests`, `beautifulsoup4`, `pandas`, `matplotlib`, and `ipykernel`. Since job ads change over time, rerunning the collection section can produce different results.
