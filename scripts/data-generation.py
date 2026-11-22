import pandas as pd
import numpy as np
import random

np.random.seed(42)
n_rows = 50000

data = {
    'date': pd.date_range(start='2025-01-01', periods=n_rows, freq='h').tolist(),
    'merchant_id': [f'MCH_{random.randint(1000, 9999)}' for _ in range(n_rows)],
    'product_category': np.random.choice(['Travel', 'Dining', 'Retail', 'Grocery', 'Entertainment'], n_rows),
    'merchant_tier': np.random.choice(['Platinum', 'Gold', 'Standard'], n_rows, p=[0.2, 0.3, 0.5]),
    'transaction_volume': np.random.exponential(scale=5000, size=n_rows),
    'risk_score': np.random.uniform(0, 100, n_rows)
}
df = pd.DataFrame(data)

# Inject realistic anomalies (e.g., 5% of records have 5x normal volume and high risk)
anomaly_indices = np.random.choice(n_rows, size=int(n_rows * 0.05), replace=False)
df.loc[anomaly_indices, 'transaction_volume'] *= 5
df.loc[anomaly_indices, 'risk_score'] = np.random.uniform(85, 100, size=len(anomaly_indices))
df['is_anomaly'] = df.index.isin(anomaly_indices).astype(int)

df.to_csv('amex_merchant_data.csv', index=False)
print("Dataset generated successfully!")