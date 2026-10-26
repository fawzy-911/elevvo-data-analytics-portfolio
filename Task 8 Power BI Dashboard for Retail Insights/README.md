# Superstore Sales Dashboard | Power BI Retail Insights

An interactive Power BI report built for the Elevvo Data Analytics internship Task 8. The project explores retail sales, profitability, product and store performance, customer segments, and returns across multiple related tables.

## Task objective

Use Power BI to model related retail tables, analyze sales performance, and present useful business insights and recommendations through an interactive report.

## Dataset

The report uses the [Superstore Sales Dataset on Kaggle](https://www.kaggle.com/datasets/mohamedfawzy911/superstore-sales-dataset). Its Excel source contains six sheets: `Orders`, `Customers`, `Products`, `Stores`, `Returns`, and `Calendar`.

The model uses `Orders` at order-line level, with customer, product, store, and calendar dimensions. Returns are analyzed separately and associated with order lines using `Row ID` to avoid inflating sales when analyzing returns.

## Data model

The report model connects order-line sales to the customer, product, store, and calendar tables, with returns linked to order lines by `Row ID`.

![Power BI data model](Data%20Model.png)

## Report pages

### 1. Executive Overview

High-level sales, profit, profit margin, and order count, with trends by period and comparisons by region, product category, and sales channel.

![Executive Overview report page](Executive%20Overview.png)

### 2. Product & Store Performance

Product rankings, units and discount indicators, product-level sales and profitability detail, sales/profit by sub-category, and store comparisons.

![Product and Store Performance report page](Product%20%26%20Store%20Performance.png)

### 3. Customer & Returns Analysis

Customer and return indicators, sales by customer segment, returned quantities by reason, and returned lines by region.

![Customer and Returns report page](Customer%20%26%20Returns%20Analysis.png)

## Key findings shown in the report

The screenshots reflect the report's selected date range, **January 1, 2022 to November 26, 2024**. Figures are rounded as displayed in Power BI.

- The selected period shows approximately **$2.79M in sales**, **$844.66K in profit**, a **30.27% profit margin**, and **12K orders**.
- **Technology** is the largest sales category in the category chart, at approximately **$1.24M**.
- **South** leads the regional sales comparison at approximately **$0.75M**; Central is lowest at approximately **$0.58M**.
- In-Store contributes approximately **60.08%** of sales, compared with **39.92%** for Online.
- In the returns chart, the largest returned-quantity reason is **Changed Mind (641 units)**, followed by **Defective (473)** and **Not as Described (406)**.
- Consumer customers account for the largest share of segment sales in the displayed view, approximately **46.2%**.

These are descriptive findings for the selected filters; they do not by themselves establish why performance or returns occurred.

## Recommendations

1. **Review return reasons with product and category detail.** Start with Changed Mind, Defective, and Not as Described, then identify which products contribute most before choosing an intervention.
2. **Investigate Technology profitability alongside its sales volume.** Review product-level margins, discounts, and costs before changing pricing or promotion strategy.
3. **Use South's sales lead to examine its product and store mix.** Compare profit and margin as well as revenue before transferring practices to other regions.
4. **Plan channel actions using the In-Store and Online split.** Compare their margins and return rates under the same date and region filters before reallocating resources.

## Published report

[Open the Power BI report](https://app.powerbi.com/groups/me/reports/2d7e8a25-d6b1-4822-86ce-d2d1c35823f7?ctid=89f6a41b-7500-4be7-b733-829805371e95&pbi_source=linkShare&bookmarkGuid=339573ac-6a25-42f4-b935-70ff8167a060)

Access depends on the Power BI sharing permissions configured by the owner.

## Files to include in this task folder

```text
README.md
Superstore Sales Dashboard.pbix
Executive Overview.png
Product & Store Performance.png
Customer & Returns Analysis.png
Data Model.png
```

Keep the screenshot filenames unchanged, or update the image links above to match their names. The PBIX file is the editable report; the published link opens its Power BI Service version.
