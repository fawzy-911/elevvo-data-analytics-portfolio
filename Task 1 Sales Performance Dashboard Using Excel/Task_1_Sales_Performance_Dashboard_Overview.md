# Sales Performance Dashboard | Excel

> A practical sales analytics project completed as part of the Elevvo Data Analytics Internship.

## Project overview

I used the **Sample Superstore** dataset to build an Excel dashboard that turns transaction-level sales data into a clear view of revenue, units sold, profit, product categories, regions, and monthly performance.

The dashboard is designed to help a business user answer questions such as:

- How much revenue and profit did the business generate?
- How many units were sold?
- Which regions and product categories contributed most?
- How did revenue and units change month by month and year over year?
- Which products generated the most revenue?

## Dataset and tools

- **Dataset:** [Sample Superstore Sales Dataset on Kaggle](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)
- **Tools:** Microsoft Excel, Excel tables, formulas, data validation filters, summary tables, and charts
- **Time period:** January 2014 to December 2017
- **Records analyzed:** 9,994 sales lines

## What I did

1. Kept the original source data in a separate `Raw_Data` sheet.
2. Prepared a `Clean_Data` sheet for analysis. I converted order and shipping dates into Excel date values, preserved leading zeros in postal codes, and replaced non-breaking spaces in product names with regular spaces. I kept the sales records and did not remove any rows.
3. Added `Order Year`, `Order Month`, and `Year-Month` fields so the data could be summarized over time.
4. Built supporting summaries for revenue and units by month, year, region, and category. The dashboard summaries use Excel formulas and respond to the Region and Category dropdown filters.
5. Created the dashboard with KPI cards, a monthly performance table, and charts for monthly revenue, revenue by region, profit by category, and the top five products by revenue.

## Dashboard results

| Measure | Result |
|---|---:|
| Revenue | **$2,297,200.86** |
| Profit | **$286,397.02** |
| Units sold | **37,873** |
| Sales lines | **9,994** |
| Distinct order IDs | **5,009** |

The dashboard currently labels the 9,994 sales lines as **Total Orders**. Since an order can contain multiple product lines, the correct distinct order count is **5,009**. This KPI label/calculation should be adjusted before presenting the dashboard as a final public portfolio item.

## Key observations

- The **West** region generated the highest revenue: **$725,457.82** (about 31.6% of total revenue).
- **Technology** generated the highest category revenue: **$836,154.03**. It also produced the highest category profit: **$145,454.95**.
- **November 2017** was the strongest month by revenue, at **$118,447.83**.
- Annual revenue increased from **$609,205.60 in 2016** to **$733,215.26 in 2017**, an increase of about **20.4%**.

## Why this project matters

A sales dashboard makes it easier to monitor performance without manually reviewing thousands of transaction rows. It brings key measures and trends together, helps compare regions and categories, and gives a starting point for questions about seasonality, product mix, and where the business is performing well.

Building this project gave me hands-on practice with preparing real-world tabular data, creating time-based measures, summarizing results in Excel, choosing charts for business questions, and checking that metric definitions match what a dashboard label claims.

## Workbook structure

- `Raw_Data` — original dataset
- `Clean_Data` — analysis-ready records and date fields
- `Pivot_Analysis` — supporting breakdowns
- `Summary_Calc` — formula-based monthly and grouped calculations
- `Dashboard` — final interactive summary and visualizations

## Project file

[Open the Excel dashboard workbook](Sales_Performance_Dashboard_Final_Fixed.xlsx)

---

*Prepared by Mohamed Fawzy | Elevvo Data Analytics Internship*
