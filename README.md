# merchant-product-risk-analytics
End-to-end risk-adjusted product performance analytics pipeline simulating American Express merchant transaction monitoring and anomaly detection to deliver decision-ready risk insights.
# 🛡️ Risk-Adjusted Product Performance & Transaction Anomaly Detection Framework


---

## 📌 Executive Summary
As Global Merchant & Network Services (GMNS) product capabilities scale, manual monitoring of merchant transaction volumes and emerging risk patterns becomes inefficient and prone to oversight. This project establishes an end-to-end, automated **Risk Data Aggregation and Reporting Framework**. It ingests synthetic merchant transaction data, establishes baseline "Risk Appetite" KPIs, applies machine learning for multivariate anomaly detection, and delivers a decision-ready Power BI dashboard for proactive stakeholder intervention.

## 🎯 Business Problem
- **Lack of Scalable Monitoring:** Traditional rule-based thresholds generate high false-positive rates, overwhelming risk teams.
- **Siloed Insights:** Product performance (volume/adoption) and Risk metrics (fraud/anomalies) are often analyzed separately, delaying root-cause analysis.
- **Goal:** Build a unified measurement framework that flags emerging risks while providing actionable, segmented insights for Product and Risk stakeholders.

---

## 🛠️ Technical Stack & Architecture

| Stage | Tool | Purpose |
| :--- | :--- | :--- |
| **1. Data Profiling** | 📊 Advanced Excel / Power Query | Establish baseline KPIs, define Risk Appetite Thresholds, and validate data integrity. |
| **2. Data Aggregation** | 🗄️ SQL (PostgreSQL/DuckDB) | Scalable ETL using CTEs and Window Functions to calculate rolling 7-day metrics and flag rule-based anomalies. |
| **3. Predictive Analytics** | 🐍 Python (Pandas, Scikit-Learn) | Implement **Isolation Forest** for multivariate anomaly detection, reducing false positives compared to static SQL rules. |
| **4. Visualization** | 📈 Power BI (DAX) | Interactive executive dashboard tracking At-Risk Volume, Anomaly Rates, and Root-Cause Decomposition. |

---

## 🔄 Project Workflow

1. **Data Generation & Baseline Setup:** Generated 50,000+ rows of synthetic merchant transaction data (including injected anomalies). Used Excel Power Query to profile data and define Risk Appetite Thresholds 
2. **Scalable SQL Aggregation:** Loaded data into a relational database. Wrote advanced SQL queries utilizing `CTEs` and `WINDOW FUNCTIONS` to compute daily rolling averages and dynamically flag high-risk merchants.
3. **Machine Learning Enhancement:** Exported aggregated data to Python. Trained an Isolation Forest model to detect complex, multivariate anomalies (e.g., moderate volume spike + sudden risk score increase) 
4. **Executive Dashboarding:** Connected Power BI to the final dataset. Built DAX measures for `Anomaly Rate %` and `At-Risk Revenue`, utilizing a Decomposition Tree for intuitive root-cause analysis by Product Category and Merchant Tier.

---

## 💡 Key Business Insights (Simulated)
- **Category Vulnerability:** The *Travel* and *Entertainment* product categories exhibited a **15% higher baseline anomaly rate** compared to Grocery or Retail, driven primarily by Standard-tier merchants.
- **Model Efficiency:** The Python-based Isolation Forest model improved anomaly detection precision by **~25%** compared to the baseline SQL rule-engine, significantly reducing false-positive alerts for the risk team.
- **Actionable Output:** The Power BI "Top 50 At-Risk Merchants" table provides the Risk Reporting CoE with a ready-to-action list for immediate account review or temporary limit adjustments.

---

## 🚀 How to Reproduce This Project
1. **Generate Data:** Run `data_generation.py` to create the `amex_merchant_data.csv` dataset.
2. **SQL Processing:** Execute `risk_aggregation.sql` in your preferred SQL environment (PostgreSQL) to create the rolling metric views.
3. **ML Modeling:** Run `anomaly_detection.py` to apply the Isolation Forest algorithm and export the final scored dataset.
4. **Dashboard:** Connect the provided Power BI `.pbix` file to the final dataset to interact with the live metrics.

---
Disclaimer: This project utilizes synthetically generated data for educational and portfolio demonstration purposes. It is not affiliated with or endorsed by American Express.

## 📂 Repository Structure
```text
├── data/
│   └── amex_merchant_data.csv          # Synthetic dataset (50k+ rows)
├── sql/
│   └── risk_aggregation.sql            # CTEs and Window Functions for rolling metrics
├── python/
│   ├── data_generation.py              # Script to generate synthetic data with anomalies
│   └── anomaly_detection.py            # Isolation Forest model & SHAP analysis
├── excel/
│   └── Risk_Appetite_Thresholds.xlsx   # Baseline KPI profiling and threshold logic
├── powerbi/
│   └── Amex_Risk_Performance_Dashboard.pbix # Interactive dashboard file
└── README.md                           # This file

Disclaimer: This project utilizes synthetically generated data for educational and portfolio demonstration purposes. It is not affiliated with or endorsed by American Express.
