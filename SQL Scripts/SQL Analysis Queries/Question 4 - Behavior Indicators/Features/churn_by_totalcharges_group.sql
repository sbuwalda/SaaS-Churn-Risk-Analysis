-- Churnpercentage per klantlevensduurwaarde (TotalCharges) met nieuwe bins

SELECT
  CASE
    WHEN totalcharges::NUMERIC >= 0    AND totalcharges::NUMERIC < 500  THEN '€0–500'
    WHEN totalcharges::NUMERIC >= 500  AND totalcharges::NUMERIC < 1000 THEN '€500–1000'
    WHEN totalcharges::NUMERIC >= 1000 AND totalcharges::NUMERIC < 1500 THEN '€1000–1500'
    WHEN totalcharges::NUMERIC >= 1500 AND totalcharges::NUMERIC < 2000 THEN '€1500–2000'
    ELSE '€2000+'
  END AS totalcharges_group,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*), 2) AS churn_rate_pct
FROM cleaned_churn_data
GROUP BY totalcharges_group
ORDER BY churn_rate_pct DESC;
