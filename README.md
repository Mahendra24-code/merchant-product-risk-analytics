# 🛡️ Risk-Adjusted Product Performance & Transaction Anomaly Detection Framework


---

> **An end-to-end analytics pipeline simulating an Enterprise Fintech & Global Payments Network, designed to monitor merchant transaction volumes, detect emerging risks, and deliver decision-ready insights.**

---

## 📌 Executive Summary
As global merchant and payment networks scale, manual monitoring of transaction volumes and emerging risk patterns becomes inefficient. This project establishes an automated **Risk Data Aggregation and Reporting Framework**. It ingests synthetic merchant transaction data, establishes baseline "Risk Appetite" KPIs, applies machine learning for multivariate anomaly detection, and delivers an interactive Power BI dashboard to enable proactive, data-driven stakeholder intervention.

---

## 🎯 Business Problem
- **Lack of Scalable Foundational Reporting:** Traditional, static rule-based thresholds generate high false-positive rates, overwhelming risk and fraud teams.
- **Siloed Measurement Frameworks:** Product performance (volume/adoption) and Risk metrics (fraud/anomalies) are often analyzed in isolation, hindering rapid root-cause analysis.
- **The Goal:** Build a unified, scalable insight solution that flags emerging risks in real-time while providing actionable, segmented recommendations for Product, Risk, and Merchant Services stakeholders.

---

## 🛠️ Technical Stack & Architecture

| Stage | Tool | Purpose & Business Value |
| :--- | :--- | :--- |
| **1. Data Profiling** | 📊 Advanced Excel / Power Query | Establish baseline KPIs, define Risk Appetite Thresholds, and validate data integrity (aligning with enterprise data quality principles). |
| **2. Data Aggregation** | 🗄️ SQL (PostgreSQL / DuckDB) | Scalable ETL using `CTEs` and `Window Functions` to calculate rolling 7-day metrics and dynamically flag rule-based anomalies. |
| **3. Predictive Analytics** | 🐍 Python (Pandas, Scikit-Learn) | Implement **Isolation Forest** for multivariate anomaly detection, significantly reducing false positives compared to static SQL rules. |
| **4. Visualization** | 📈 Power BI (DAX) | Interactive executive dashboard tracking At-Risk Volume, Anomaly Rates, and AI-driven Root-Cause Decomposition. |

---

## 🔄 End-to-End Solution Workflow

1. **Baseline Setup & Profiling:** Generated 50,000+ rows of synthetic merchant transaction data (including injected anomalies). Used Excel to profile data and mathematically define Risk Appetite Thresholds (e.g., >150% of baseline average).
2. **Scalable SQL Aggregation:** Loaded data into a relational database. Engineered advanced SQL queries utilizing `CTEs` and `WINDOW FUNCTIONS` to compute daily rolling averages and dynamically categorize risk status (e.g., *"Critical Volume Spike"*, *"Emerging Risk"*).
3. **Machine Learning Enhancement:** Exported aggregated data to Python. Trained an Isolation Forest model to detect complex, multivariate anomalies (e.g., moderate volume spike + sudden risk score increase), improving detection precision.
4. **Executive Dashboarding:** Connected Power BI to the final scored dataset. Built robust DAX measures for `Anomaly Rate %` and `At-Risk Revenue`, utilizing a Decomposition Tree for intuitive root-cause analysis by Merchant Category Code (MCC) and Tier.

---

## 💡 Key Business Insights (Simulated)
- **Category Vulnerability:** The *Travel* and *Entertainment* merchant categories exhibited a **15% higher baseline anomaly rate** compared to Grocery or Retail, driven primarily by Standard-tier merchants.
- **Model Efficiency:** The Python-based Isolation Forest model improved anomaly detection precision by **~25%** compared to the baseline SQL rule-engine, significantly reducing manual investigation time for the risk team.
- **Actionable Output:** The Power BI "High-Priority Merchant Risk Interventions" table provides the Risk Reporting team with a ready-to-action, decision-ready list for immediate account review or temporary limit adjustments.

---

## 🚀 How to Reproduce This Project
1. **Generate Data:** Run `python/data_generation.py` to create the `merchant_transaction_data.csv` dataset.
2. **SQL Processing:** Execute `sql/risk_aggregation.sql` in your preferred SQL environment (PostgreSQL/DuckDB) to create the rolling metric views and risk flags.
3. **ML Modeling:** Run `python/anomaly_detection.py` to apply the Isolation Forest algorithm and export the final scored dataset.
4. **Dashboard:** Open the provided `powerbi/High_Risk_Merchant_Critical_Exposure.pbix` file and connect it to the final dataset to interact with the live metrics.

---
---

> *⚠️ **Disclaimer:** This project utilizes synthetically generated data for educational and portfolio demonstration purposes. It is designed to simulate enterprise Fintech and Payments analytics environments and is not affiliated with any specific financial institution.*

---

## 📂 Repository Structure
```text
├── data/
│   └── merchant_transaction_data.csv       # Synthetic dataset (50k+ rows)
├── sql/
│   └── risk_aggregation.sql                # CTEs and Window Functions for rolling metrics & risk flagging
├── python/
│   ├── data_generation.py                  # Script to generate synthetic data with injected anomalies
│   └── anomaly_detection.py                # Isolation Forest model & SHAP root-cause analysis
├── excel/
│   └── Risk_Analytics_Model.xlsx           # Baseline KPI profiling and threshold logic
├── powerbi/
│   └── High_Risk_Merchant_Critical_Exposure.pbix # Interactive executive dashboard
├── visuals/
│   ├── executive_dashboard.png             # Screenshot of the Power BI dashboard
│   └── shap_anomaly_drivers.png            # Screenshot of the SHAP plot from Python
└── README.md                               # Project documentation (This file).

