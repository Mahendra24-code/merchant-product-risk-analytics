/* =========================================================================
   AMEX GMNS PRODUCT RISK REPORTING FRAMEWORK (PostgreSQL Fixed)
   ========================================================================= */

-- CTE 1: DAILY RISK DATA AGGREGATION & DATE CASTING
WITH DailyMetrics AS (
    SELECT 
        CAST(transaction_date AS DATE) as trans_date,
        product_category,
        merchant_tier,
        SUM(transaction_volume) as daily_volume,
        AVG(risk_score) as avg_risk_score,
        COUNT(DISTINCT merchant_id) as active_merchants,
        SUM(is_anomaly) as flagged_anomalies
    FROM merchant_data  -- <--- Make sure this matches your actual table name (e.g., merchant_data)
    WHERE transaction_date IS NOT NULL 
      AND transaction_date != ''  -- Filters out the blank rows from the CSV
    GROUP BY CAST(transaction_date AS DATE), product_category, merchant_tier
),

-- CTE 2: ENTERPRISE RISK APPETITE BASELINE CALCULATION
BaselineStats AS (
    SELECT 
        product_category,
        merchant_tier,
        AVG(daily_volume) as baseline_avg_volume,
        STDDEV(daily_volume) as baseline_stddev_volume,
        AVG(avg_risk_score) as baseline_avg_risk
    FROM DailyMetrics
    GROUP BY product_category, merchant_tier
),

-- CTE 3: ROLLING WINDOW FOR "EMERGING RISK" DETECTION
RollingMetrics AS (
    SELECT 
        dm.trans_date,
        dm.product_category,
        dm.merchant_tier,
        dm.daily_volume,
        dm.avg_risk_score,
        dm.active_merchants,
        dm.flagged_anomalies,
        
        -- 7-Day Rolling Average Volume
        AVG(dm.daily_volume) OVER (
            PARTITION BY dm.product_category, dm.merchant_tier 
            ORDER BY dm.trans_date 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) as rolling_7_day_avg_volume,
        
        -- 7-Day Rolling Anomaly Count
        SUM(dm.flagged_anomalies) OVER (
            PARTITION BY dm.product_category, dm.merchant_tier 
            ORDER BY dm.trans_date 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) as rolling_7_day_anomaly_count
        
    FROM DailyMetrics dm
)

-- FINAL OUTPUT: DYNAMIC RISK FLAGGING
SELECT 
    rm.trans_date,
    rm.product_category,
    rm.merchant_tier,
    ROUND(rm.daily_volume, 2) as daily_volume,
    ROUND(rm.avg_risk_score, 2) as avg_risk_score,
    rm.active_merchants,
    ROUND(rm.rolling_7_day_avg_volume, 2) as rolling_7_day_avg_volume,
    ROUND(bs.baseline_avg_volume, 2) as risk_appetite_baseline,
    rm.flagged_anomalies,
    rm.rolling_7_day_anomaly_count,
    
    CASE 
        WHEN rm.daily_volume > (bs.baseline_avg_volume + (2 * bs.baseline_stddev_volume)) 
            THEN 'Critical Volume Spike (Risk Appetite Breach)'
        WHEN rm.rolling_7_day_avg_volume > (bs.baseline_avg_volume * 1.5) 
            THEN 'Sustained High Volume (Emerging Risk)'
        WHEN rm.avg_risk_score > 85 
            THEN 'High Risk Score'
        WHEN rm.rolling_7_day_anomaly_count > 5 
            THEN 'Clustered Anomalies'
        ELSE 'Normal'
    END as risk_status

FROM RollingMetrics rm
JOIN BaselineStats bs 
    ON rm.product_category = bs.product_category 
    AND rm.merchant_tier = bs.merchant_tier
ORDER BY rm.trans_date DESC, rm.daily_volume DESC;