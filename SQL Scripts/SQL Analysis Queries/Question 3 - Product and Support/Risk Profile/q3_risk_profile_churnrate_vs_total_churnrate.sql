-- Comparison churn rate of risk profile (q3) vs total dataset

WITH risk_group AS (
  SELECT *
  FROM cleaned_churn_data
  WHERE deviceprotection = 'No'
    AND internetservice = 'Fiber optic'
    AND onlinebackup = 'No'
    AND onlinesecurity = 'No'
    AND paperlessbilling = 'Yes'
    AND techsupport = 'No'
    AND streamingtv = 'No'
    AND streamingmovies = 'No'
),
all_customers AS (
  SELECT * FROM cleaned_churn_data
)

SELECT 
  'Risk profile (Q2)' AS group_name,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*), 2) AS churn_rate_pct
FROM risk_group

UNION ALL

SELECT 
  'Total population' AS group_name,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*), 2) AS churn_rate_pct
FROM all_customers;
