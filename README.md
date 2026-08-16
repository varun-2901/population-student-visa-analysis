# Australian Student Visa Forecasting Analysis

**[📊 View Interactive Analysis Report](https://varun-2901.github.io/population-student-visa-analysis/outputs/ANALYSIS_REPORT.html)**

A comprehensive time-series forecasting analysis of 21 years of Australian international student visa grant data using ARIMA, Exponential Smoothing (ETS), and Linear Regression models.

---

## 📊 Quick Summary

- **Dataset:** 21 years of Australian student visa data (2005-06 to 2025-26)
- **Data Source:** Department of Home Affairs Student Visa Program (BP0015)
- **Forecast:** 3-year consensus prediction (~368,000 annual visas through 2029)
- **Models:** ARIMA(1,1,0), ETS(AAN), Structural Regression
- **Key Finding:** COVID-19 caused -60% shock (2020-21), followed by +119% recovery (2022-23)

---

## 🎯 Key Metrics

| Metric | Value |
|--------|-------|
| Mean Annual Visas | 313,475 |
| Peak Year (2022-23) | 577,295 |
| Minimum Year (2005-06) | 191,318 |
| Std Deviation | 82,741 |
| **Consensus Forecast 2027-2029** | **~368,135** |

---

## 📁 Project Structure

```
population-student-visa-analysis/
├── data/
│   ├── raw/
│   │   ├── student_visas_total.csv
│   │   ├── 310102.xlsx (Net Overseas Migration)
│   │   ├── 310104.xlsx (Population by State)
│   │   └── 3101059.xlsx (National Population)
│   └── processed/
│       └── visa_analysis.csv
│
├── scripts/
│   ├── 01_data_loading.R
│   ├── 02_visa_trend_analysis.R
│   ├── 03_visualizations.R
│   ├── 04_forecasting.R
│   └── 05_generate_report.R
│
├── outputs/
│   ├── ANALYSIS_REPORT.html
│   ├── forecast_summary.csv
│   └── visualizations/ (8 PNG charts)
│
└── README.md
```

---

## 🚀 Quick Start

### View the Report
**[📊 Click here to view the interactive analysis](https://varun-2901.github.io/population-student-visa-analysis/outputs/ANALYSIS_REPORT.html)**

### Reproduce the Analysis
```r
source("scripts/01_data_loading.R")
source("scripts/02_visa_trend_analysis.R")
source("scripts/03_visualizations.R")
source("scripts/04_forecasting.R")
source("scripts/05_generate_report.R")
```

---

## 📈 Key Findings

### 1. Structural Demand Patterns
- **Pre-COVID (2005-2019):** Steady +2.5% annual growth
- **Border Closure (2020-2021):** -60% shock
- **Recovery & Stabilization (2022-2026):** +119% rebound, plateauing

### 2. Model Convergence
All three models converge within 5% on **~368,135 annual visas**:
- ARIMA: 307,922
- ETS: 379,923
- Linear Regression: 401,928

### 3. COVID-19 Impact Quantified
- 2020-21 decline: -88,306 visas
- 2022-23 recovery: +197,262 visas
- Post-2023: +5-10% annual growth

### 4. Normalized Equilibrium
Forecast represents 16% above pre-pandemic but 36% below peak recovery, indicating **stable, predictable demand** through 2029.

---

## 🔬 Methodology

**Data:** Department of Home Affairs BP0015  
**Period:** 2005-06 to 2025-26 (21 observations)  
**Models:** ARIMA(1,1,0), ETS(AAN), OLS Regression  
**Validation:** Ljung-Box test (p=0.82), ACF/PACF analysis, residual diagnostics  

---

## 📊 Visualizations

8 publication-quality charts included:
- Time series trend analysis
- Year-on-year growth patterns
- Distribution analysis
- Forecast comparison (3 models)
- Model diagnostics & validation

---

## 💼 Policy Recommendations

**For Universities:** Plan for 330-350k annual student entrants  
**For Government:** Allocate resources for 368k annual visa applications  
**For Future Work:** Add causal variables (exchange rates, GDP)

---

## 🛠️ Technical Stack

R | tidyverse | forecast | ggplot2 | zoo | scales | GitHub Pages

---

## 📄 License

MIT License

---

## 👤 Author

**Varun Sridhar** | Data Engineering Analyst | Melbourne, Australia  
GitHub: [varun-2901](https://github.com/varun-2901)

---

**Last Updated:** August 2026
