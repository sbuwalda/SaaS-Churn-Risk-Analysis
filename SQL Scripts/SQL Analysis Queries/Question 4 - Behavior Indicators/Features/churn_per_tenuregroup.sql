-- Churnpercentage per tenuregroep (gedragsproxy)

SELECT 
  CASE
    WHEN tenure BETWEEN 0 AND 12 THEN '0–12 maanden'
    WHEN tenure BETWEEN 13 AND 24 THEN '13–24 maanden'
    WHEN tenure BETWEEN 25 AND 48 THEN '25–48 maanden'
    ELSE '49+ maanden'
  END AS tenure_group,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*), 2) AS churn_rate_pct
FROM cleaned_churn_data
GROUP BY tenure_group
ORDER BY churn_rate_pct DESC;
