# Task 5 — SQL-Based Analysis of Product Sales

A focused SQL analysis of the **Chinook digital music store** database, completed for the Elevvo Data Analytics Internship.

## Task objective

Use SQL to analyze product sales from a relational database and answer these business questions:

1. Which products sell the most?
2. How does revenue vary by region?
3. How do revenue and sales volume perform month by month?

The work practices SQL joins, aggregations, grouping, sorting, and a window function.

## Dataset and tools

- **Dataset:** Chinook Database, the dataset recommended in the task
- **Database file:** `Chinook_Sqlite.sqlite`
- **SQL dialect:** SQLite
- **Tool:** DB Browser for SQLite or another SQLite client
- **Dataset period:** January 2009 to December 2013
- **Source page:** [Chinook Database on Kaggle](https://www.kaggle.com/datasets/ranasabrii/chinook)

The database contains related tables such as `Invoice`, `InvoiceLine`, `Track`, `Album`, `Artist`, and `Customer`. For this analysis, `Track` represents an individual product sold by the store.

## Analysis approach

### 1. Top-selling products

Joined `InvoiceLine` to `Track`, grouped invoice lines by track, and calculated:

- Units sold with `SUM(Quantity)`
- Revenue with `SUM(UnitPrice * Quantity)`

The query uses `ROW_NUMBER()` to return exactly ten tracks. Products are ordered by units sold, then revenue, then product name to make ties deterministic.

### 2. Revenue by region

Chinook records invoice billing countries but does not provide a ready-made `Region` field. To answer the task's regional question, the query maps each `BillingCountry` to a continent-level region using a documented `CASE` expression. Revenue is summed from `Invoice.Total`, which ensures each invoice is counted once.

### 3. Monthly performance

Grouped invoices by month to calculate invoice count and revenue, and grouped invoice lines by month to calculate units sold. The monthly summaries are joined after aggregation so an invoice total is not repeated for each product line. `LAG()` calculates the month-over-month revenue and unit changes.

## Results from the SQL queries

The tables below reproduce the rows returned by the three queries in `Task_5_Chinook_Sales_Analysis.sql`. The monthly query returns 60 rows; all 60 are included. A dash marked `NULL` is SQL `NULL` for the first month, which has no previous month for comparison.

### 1. Top 10 products (tracks)

The query orders by units sold, then revenue, then product name. The database has many ties at two units sold, so the tie-breakers determine which ten rows are displayed.

| Rank | Product (Track) | Units Sold | Revenue |
| --- | --- | --- | --- |
| 1 | Gay Witch Hunt | 2 | 3.98 |
| 2 | Hot Girl | 2 | 3.98 |
| 3 | How to Stop an Exploding Man | 2 | 3.98 |
| 4 | Phyllis's Wedding | 2 | 3.98 |
| 5 | Pilot | 2 | 3.98 |
| 6 | The Fix | 2 | 3.98 |
| 7 | The Woman King | 2 | 3.98 |
| 8 | Walkabout | 2 | 3.98 |
| 9 | A Cor Do Sol | 2 | 1.98 |
| 10 | A Melhor Forma | 2 | 1.98 |

### 2. Revenue by derived region

The regions are derived from the billing-country mapping documented in the SQL query. Revenue is summed once per invoice.

| Region | Countries | Invoices | Revenue |
| --- | --- | --- | --- |
| Europe | 17 | 196 | 1114.36 |
| North America | 2 | 147 | 827.02 |
| South America | 3 | 49 | 274.34 |
| Asia | 1 | 13 | 75.26 |
| Oceania | 1 | 7 | 37.62 |

### 3. Monthly performance

Revenue and invoice counts are aggregated from `Invoice`; units are aggregated from `InvoiceLine`. Changes compare each month with the preceding month.

| Month | Invoices | Revenue | Units Sold | Revenue Change | Revenue Change % | Units Change |
| --- | --- | --- | --- | --- | --- | --- |
| 2009-01 | 6 | 35.64 | 36 | — (NULL) | — (NULL) | — (NULL) |
| 2009-02 | 7 | 37.62 | 38 | 1.98 | 5.56% | 2 |
| 2009-03 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2009-04 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2009-05 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2009-06 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2009-07 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2009-08 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2009-09 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2009-10 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2009-11 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2009-12 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2010-01 | 7 | 52.62 | 38 | 15.00 | 39.87% | 0 |
| 2010-02 | 7 | 46.62 | 38 | -6.00 | -11.40% | 0 |
| 2010-03 | 7 | 44.62 | 38 | -2.00 | -4.29% | 0 |
| 2010-04 | 7 | 37.62 | 38 | -7.00 | -15.69% | 0 |
| 2010-05 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2010-06 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2010-07 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2010-08 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2010-09 | 6 | 36.63 | 37 | -0.99 | -2.63% | -1 |
| 2010-10 | 7 | 37.62 | 38 | 0.99 | 2.70% | 1 |
| 2010-11 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2010-12 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2011-01 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2011-02 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2011-03 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2011-04 | 7 | 51.62 | 38 | 14.00 | 37.21% | 0 |
| 2011-05 | 7 | 42.62 | 38 | -9.00 | -17.44% | 0 |
| 2011-06 | 7 | 50.62 | 38 | 8.00 | 18.77% | 0 |
| 2011-07 | 7 | 37.62 | 38 | -13.00 | -25.68% | 0 |
| 2011-08 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2011-09 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2011-10 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2011-11 | 6 | 23.76 | 24 | -13.86 | -36.84% | -14 |
| 2011-12 | 7 | 37.62 | 38 | 13.86 | 58.33% | 14 |
| 2012-01 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2012-02 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2012-03 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2012-04 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2012-05 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2012-06 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2012-07 | 7 | 39.62 | 38 | 2.00 | 5.32% | 0 |
| 2012-08 | 7 | 47.62 | 38 | 8.00 | 20.19% | 0 |
| 2012-09 | 6 | 46.71 | 29 | -0.91 | -1.91% | -9 |
| 2012-10 | 7 | 42.62 | 38 | -4.09 | -8.76% | 9 |
| 2012-11 | 7 | 37.62 | 38 | -5.00 | -11.73% | 0 |
| 2012-12 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2013-01 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2013-02 | 5 | 27.72 | 28 | -9.90 | -26.32% | -10 |
| 2013-03 | 7 | 37.62 | 38 | 9.90 | 35.71% | 10 |
| 2013-04 | 5 | 33.66 | 34 | -3.96 | -10.53% | -4 |
| 2013-05 | 7 | 37.62 | 38 | 3.96 | 11.76% | 4 |
| 2013-06 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2013-07 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2013-08 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2013-09 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2013-10 | 7 | 37.62 | 38 | 0.00 | 0.00% | 0 |
| 2013-11 | 7 | 49.62 | 38 | 12.00 | 31.90% | 0 |
| 2013-12 | 7 | 38.62 | 38 | -11.00 | -22.17% | 0 |

### Overall checks

- **Invoices:** 412
- **Units sold:** 2,240
- **Total revenue:** 2,328.60
- **Period:** January 2009 to December 2013
- The total from `Invoice.Total` equals the total from `InvoiceLine.UnitPrice × Quantity`: **2,328.60**.
- Highest-revenue region in the query output: **Europe — 1,114.36**.
- Highest-revenue month in the query output: **2010-01 — 52.62**.

## Files

- [`Task_5_Chinook_Sales_Analysis.sql`](Task_5_Chinook_Sales_Analysis.sql) — the three runnable SQLite queries
- [`Chinook_Sqlite.sqlite`](Chinook_Sqlite.sqlite) — the database used for the analysis

## Running the queries

1. Open `Chinook_Sqlite.sqlite` in DB Browser for SQLite.
2. Open the **Execute SQL** tab and load `Task_5_Chinook_Sales_Analysis.sql`.
3. Run each query separately to view its result table.

---

*Prepared by Mohamed Fawzy | Elevvo Data Analytics Internship*
