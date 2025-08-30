-- Vergelijk churnpercentage binnen het risicoprofiel versus de volledige populatie.
-- Het risicoprofiel is gedefinieerd op basis van gedragsproxies:
-- contract = maand, betaling = electronic check, tenure = laag, charges = hoog-gematigd.

-- 1. Churnstatistieken binnen risicoprofiel
WITH risk_group AS (
  SELECT *
  FROM cleaned_churn_data
  WHERE contract = 'Month-to-month'
    AND monthlycharges BETWEEN 75 AND 100
    AND paymentmethod = 'Electronic check'
    AND totalcharges::FLOAT BETWEEN 0 AND 500
    AND tenure BETWEEN 0 AND 12
    AND paperlessbilling = 'Yes'
),

-- 2. Statistieken over alle klanten
all_customers AS (
  SELECT *
  FROM cleaned_churn_data
)

SELECT 
  'Risk profile' AS group_name,
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
