-- Q1 Risk profile churn rate vs total
WITH risk_q1 AS (
  SELECT *
  FROM cleaned_churn_data
  WHERE tenure BETWEEN 0 AND 12
    AND paymentmethod = 'Electronic check'
    AND contract = 'Month-to-month'
    AND internetservice = 'Fiber optic'
    AND onlinesecurity = 'No'
    AND techsupport = 'No'
    AND seniorcitizen = 1
    AND totalcharges BETWEEN 0 AND 500
),
all_customers AS (
  SELECT * FROM cleaned_churn_data
)
SELECT 
  'Risk profile (Q1)' AS group_name,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*), 2) AS churn_rate_pct
FROM risk_q1
UNION ALL
SELECT 
  'Total population' AS group_name,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*), 2) AS churn_rate_pct
FROM all_customers;
