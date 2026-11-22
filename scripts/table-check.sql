-- Create the table structure
CREATE TABLE merchant_data (
    date VARCHAR(50),
    merchant_id VARCHAR(50),
    product_category VARCHAR(50),
    merchant_tier VARCHAR(50),
    transaction_volume NUMERIC,
    risk_score NUMERIC,
    is_anomaly INT,
    Transaction_Date VARCHAR(50)
);
-- Check 1: Total row count (Should be 50,000)
SELECT COUNT(*) FROM merchant_data;

-- Check 2: Preview the data
SELECT * FROM merchant_data LIMIT 5;
---------------------------------------------------
