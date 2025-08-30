-- Comparison churn rate of risk profile vs total dataset (q2)

WITH risk_group AS (
  SELECT *
  FROM cleaned_churn_data
  WHERE contract = 'Month-to-month'
    AND dependents = 'No'
    AND internetservice = 'Fiber optic'
    AND paymentmethod = 'Electronic check'
    AND seniorcitizen = 1
    AND tenure BETWEEN 0 AND 12
    AND partner = 'No'
),
all_customers AS (
  SELECT * FROM cleaned_churn_data
)

SELECT 
  'Risk profile (Q1)' AS group_name,
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
