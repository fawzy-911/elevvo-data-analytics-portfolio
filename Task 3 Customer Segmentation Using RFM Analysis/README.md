# Customer Segmentation Using RFM Analysis

## Project overview

This project completes **Task 3: Customer Segmentation Using RFM Analysis** for the Elevvo Data Analytics internship. Using historical retail transactions, it summarizes customer purchase behavior, assigns Recency, Frequency, and Monetary scores, groups customers into understandable segments, and suggests a practical marketing idea for each group.

The goal is to move from a transaction-level sales file to a customer-level view that can help a business decide whom to reward, encourage, or try to win back.

## Dataset

The project uses the [Online Retail dataset from the UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/352/online+retail). It contains transactions from a UK-based online retailer from December 1, 2010 through December 9, 2011. The original dataset has **541,909 rows and 8 columns**.

Each row represents a product line on an invoice. An invoice can contain multiple product lines, so the notebook counts **distinct invoices per customer** for Frequency rather than counting rows.

The workbook used by the notebook is `Online Retail.xlsx`, included in this project folder.

## RFM approach

Each customer is described by three measures:

| Measure | Definition in this project | How to interpret a higher score |
|---|---|---|
| **Recency (R)** | Days between the customer's latest purchase and the reference date | The customer purchased more recently |
| **Frequency (F)** | Number of distinct invoices for the customer | The customer purchased more often |
| **Monetary (M)** | Sum of positive line sales (`Quantity × UnitPrice`) | The customer spent more |

The reference date is **December 10, 2011**, one day after the latest valid purchase. Customers receive scores from 1 to 5 using five quantile groups. Recency is scored in reverse because fewer days since purchase is better; Frequency and Monetary are scored in ascending order. The three scores are also combined into an RFM code, such as `555`.

Segments are assigned with simple, documented rules based on the scores: **Champions**, **Loyal Customers**, **Recent Customers**, **At Risk**, **Hibernating**, and **Potential Loyalists**. These rules are intended to be easy to explain and are not a predictive machine-learning model.

## Data preparation

Cleaning is limited to decisions needed for customer-level purchase analysis. Rows are processed in sequence:

| Preparation step | Rows affected / remaining | Reason |
|---|---:|---|
| Original records | 541,909 | Source data |
| Remove exact duplicate rows | 5,268 removed | Avoid counting identical records twice |
| Remove rows without `CustomerID` | 135,037 removed | Cannot attribute these transactions to a customer |
| Remove invoices beginning with `C` | 8,872 removed | These are cancellation invoices |
| Remove remaining rows with `Quantity <= 0` | 0 remaining at this step | Exclude non-positive quantities from positive purchase value |
| Remove remaining rows with `UnitPrice <= 0` | 40 removed | Exclude rows without a positive selling price |
| Rows retained for RFM | **392,692** | Valid customer purchase lines |

The counts are sequential: each row count applies after the preceding preparation step. Missing product descriptions are not used in RFM and are therefore not a reason to discard an otherwise usable customer transaction.

For each retained line, sales value is calculated as:

```text
Sales = Quantity × UnitPrice
```

Returns and cancellations are not subtracted from Monetary in this version. Monetary therefore represents **positive purchase value**, not net customer spend after returns.

## Results

The cleaned transactions produce **4,338 customer records** in the RFM table. The segment summary is sorted by total spend:

| Segment | Customers | Avg. recency (days) | Avg. invoices | Avg. spend (£) | Total spend (£) | Customer share | Spend share |
|---|---:|---:|---:|---:|---:|---:|---:|
| Champions | 942 | 12.50 | 11.20 | 6,091.24 | 5,737,952.12 | 21.72% | 64.56% |
| Loyal Customers | 508 | 37.21 | 5.12 | 1,826.03 | 927,623.75 | 11.71% | 10.44% |
| At Risk | 661 | 150.64 | 3.41 | 1,246.46 | 823,912.44 | 15.24% | 9.27% |
| Potential Loyalists | 843 | 38.97 | 1.85 | 867.95 | 731,677.86 | 19.43% | 8.23% |
| Hibernating | 1,074 | 216.68 | 1.10 | 487.71 | 523,803.28 | 24.76% | 5.89% |
| Recent Customers | 310 | 18.10 | 1.25 | 458.84 | 142,239.44 | 7.15% | 1.60% |

### Main observations

- **Champions account for 64.56% of total spend while representing 21.72% of customers.** This makes retention and loyalty benefits worth considering for this group.
- **Hibernating is the largest segment by customer count** at 1,074 customers, or 24.76% of the customer base. Its spend share is 5.89%, and its average recency is 216.68 days.
- **At Risk contains 661 customers** with an average of 3.41 invoices and average recency of 150.64 days. A measured re-engagement campaign could be tested with this segment.
- Total spend across all segments is **£8,887,208.89**. Segment spend shares sum to approximately 100%, with small differences possible from rounding.

## Marketing ideas to test

| Segment | Suggested action |
|---|---|
| Champions | Reward loyalty or offer early access to new products. |
| Loyal Customers | Test a loyalty benefit or product bundle to encourage another purchase. |
| Recent Customers | Send a welcome message with relevant related-product suggestions. |
| Potential Loyalists | Try personalized recommendations and a modest next-order offer. |
| At Risk | Test a tailored reminder or limited-time incentive. |
| Hibernating | Try a low-cost win-back message before offering expensive incentives. |

These are hypotheses, not guaranteed outcomes. Campaign response, repeat purchases, and costs should be measured before expanding an offer.

## Visualizations

The notebook includes the optional task bonus:

- Customer count by RFM segment
- Total spend by RFM segment
- A heatmap of average R, F, and M scores by segment

## Project files

| File | Description |
|---|---|
| `Customer_Segmentation_RFM.ipynb` | Executable notebook containing the cleaning, RFM calculations, segment rules, results, and charts |
| `Online Retail.xlsx` | UCI source workbook used by the notebook |

## Run the notebook

Place the notebook and workbook in the same folder, then install the libraries if needed:

```bash
pip install pandas matplotlib seaborn openpyxl
```

Open `Customer_Segmentation_RFM.ipynb` in Jupyter Notebook, JupyterLab, or VS Code and run the cells from top to bottom.

## Scope and limitations

- The dataset covers approximately one year and ends in **2011**. Recency is relative to the end of that historical period and does not describe customers' current behavior.
- Cancellation invoices, records without a customer ID, and remaining non-positive quantities or prices are excluded from the RFM purchase analysis.
- Monetary is based on positive purchase lines and does not subtract returns.
- Quantile scores are relative to this dataset. The segment names and rule thresholds are transparent choices for this project, not universal standards.
- RFM is descriptive here. It does not predict future purchases or establish why a customer became inactive.
