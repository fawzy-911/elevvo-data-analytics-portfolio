# Task 10 — Marketing Campaign A/B Analysis

## Project question

Did users shown the product advertisement (`ad`) purchase more often than users shown the public service announcement (`psa`), and is the observed difference statistically convincing?

This project follows the Task 10 brief: compare conversion rates, conduct hypothesis tests, report p-values at a 95% confidence level, and complete both bonus analyses. The notebook uses the Kaggle **Marketing A/B Testing** dataset and includes executed results and a confidence-interval chart.

## Files

- `Task_10_Marketing_AB_Analysis.ipynb` — complete, executed Python analysis.
- `marketing_AB.csv` — source dataset used by the notebook.
- `Task_10_Marketing_AB_Analysis.md` — this project summary.

## Dataset and preparation

The dataset contains one user per row and includes the group assignment, whether that user converted, ad exposure count, and the day/hour of highest ad exposure. The downloaded file had an exported row-index column; the notebook removes that index and gives the remaining fields simple Python column names.

Data checks after this cleanup:

| Check | Result |
| --- | ---: |
| Users | 588,101 |
| Missing values | 0 |
| Duplicate user IDs | 0 |
| Ad group users | 564,577 |
| PSA group users | 23,524 |
| Total conversions | 14,843 |

The allocation is strongly unbalanced (about 96% ad and 4% PSA). The analysis keeps the original allocation and uses the group-specific denominators; it does not incorrectly compare raw conversion counts.

## Method

1. Calculate each group's conversion rate as conversions divided by users.
2. Define the null hypothesis as equal conversion rates and the two-sided alternative as different conversion rates.
3. Run a two-proportion z-test at `alpha = 0.05` and a chi-square test on the same 2×2 outcome table.
4. Calculate Wilson 95% confidence intervals for each group's rate and a Newcombe 95% confidence interval for the difference in rates.
5. Estimate incremental conversions for a hypothetical rollout to 100,000 users by applying the observed absolute lift. This is a scenario, not a guaranteed forecast.

## Results

| Group | Users | Conversions | Conversion rate | 95% Wilson confidence interval |
| --- | ---: | ---: | ---: | ---: |
| PSA control | 23,524 | 420 | 1.7854% | 1.623%–1.964% |
| Product ad | 564,577 | 14,423 | 2.5547% | 2.516%–2.594% |

- **Absolute lift:** 0.7692 percentage points (ad minus PSA).
- **Relative lift:** 43.09% versus the PSA conversion rate.
- **Z-test:** `z = 7.370`, `p = 1.71 × 10⁻¹³`.
- **Chi-square test:** `χ² = 54.006`, `df = 1`, `p ≈ 2.0 × 10⁻¹³`. SciPy applies Yates' continuity correction to this 2×2 table by default, so this statistic is not exactly the square of the z statistic.
- **Newcombe 95% confidence interval for absolute lift:** 0.587 to 0.936 percentage points. The interval is above zero.

At the 5% significance level, reject the null hypothesis of equal conversion rates. Both tests support a statistically significant difference, and the confidence interval supports a positive lift.

## Bonus: estimated incremental conversions

If 100,000 comparable users were exposed and the measured absolute lift persisted, the point estimate is **about 769 additional conversions**. The interval based on the lift confidence interval is **about 587 to 936 additional conversions**.

This estimate assumes comparable audience mix and implementation, stable conversion behavior, and that the measured effect carries over at larger scale. The dataset has no revenue, margin, or ad-cost fields, so this analysis cannot establish profitability or return on ad spend.

## Business interpretation

The product-ad group has a higher observed conversion rate than the PSA control group, and the difference is statistically significant at the specified confidence level. The result supports considering a broader rollout, while monitoring conversion performance at scale. Before treating the estimate as causal, confirm that assignment to `ad` and `psa` was randomized and that no targeting or delivery differences systematically separated the groups. Statistical significance alone does not measure campaign profitability.

## Reproduce the analysis

Keep the CSV beside the notebook, then open `Task_10_Marketing_AB_Analysis.ipynb` in Jupyter Notebook, JupyterLab, or VS Code and run all cells. The analysis uses Python with pandas, NumPy, SciPy, statsmodels, and Matplotlib.

Install the libraries if needed:

```bash
python -m pip install pandas numpy scipy statsmodels matplotlib jupyter
```

## Source

Dataset: [Marketing A/B Testing — Kaggle](https://www.kaggle.com/datasets/faviovaz/marketing-ab-testing)

Task requirements: Data Analytics Tasks PDF, Level 3, Task 10 — Marketing Campaign A/B Analysis.
