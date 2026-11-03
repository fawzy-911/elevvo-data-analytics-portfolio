# Task 7 — Time Series Breakdown of Retail Sales

This project analyzes Walmart's historical weekly sales as a monthly time series using Python. It covers sales trend, moving averages, calendar-month seasonality, department/store comparisons, visualizations, and a simple exponential-smoothing forecast with a time-based holdout evaluation.

## Dataset check

The Kaggle Walmart dataset is suitable for the task's time-series work. `train.csv` contains `Date`, `Store`, `Dept`, `Weekly_Sales`, and `IsHoliday`; `stores.csv` provides store type and size; and `features.csv` provides holidays and weekly external features. Weekly observations are aggregated to calendar months in the notebook.

The data does **not** contain a product SKU or a named region. The notebook therefore uses `Dept` as the closest available product-like breakdown and `Store`/`Type` as the available location breakdown. These limitations are stated in the notebook instead of labeling departments as products or stores as regions.

## Analysis included

- Data inspection and duplicate-key check.
- Joins between sales, store metadata, and weekly features.
- Monthly total sales and 3-month/12-month rolling means.
- Calendar-month seasonality table, line chart, and year-month heatmap.
- Monthly sales breakdown by leading departments and stores.
- Holt-Winters exponential smoothing with 12-month seasonality.
- Six-month chronological holdout evaluation using MAE, RMSE, and MAPE, followed by a six-month illustrative forecast.
- Task-coverage table and practical limitations.

## Main files

- `Walmart_Retail_Sales_Time_Series.ipynb` — complete executed notebook with results, tables, and charts.
- `data/raw/datasets/divyajeetthakur/walmart-sales-prediction/versions/1/` — local source CSV files provided with this task.

The notebook uses the supplied local dataset. The Kaggle page identifies its contents and notes that it is subject to the competition rules: [Walmart Sales Forecasting dataset](https://www.kaggle.com/datasets/anggundwilestari/walmart-sales-forecasting).

## Run the notebook

Open the notebook in Jupyter from this project folder and run cells in order. It requires `pandas`, `matplotlib`, `statsmodels`, `scikit-learn`, `numpy`, and a Python 3 kernel.
