-- Churn % per MonthlyCharges_group
WITH binned AS (
  SELECT
    CASE
      WHEN monthlycharges >= 0  AND monthlycharges < 25  THEN '€0–25'
      WHEN monthlycharges >= 25 AND monthlycharges < 50  THEN '€25–50'
      WHEN monthlycharges >= 50 AND monthlycharges < 75  THEN '€50–75'
      WHEN monthlycharges >= 75 AND monthlycharges < 100 THEN '€75–100'
      WHEN monthlycharges >= 100                        THEN '€100+'
      ELSE 'Unknown'
    END AS monthlycharges_group,
    churn
  FROM cleaned_churn_data
)
SELECT
  monthlycharges_group,
  COUNT(*)                                         AS total_customers,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)   AS churned_customers,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)::numeric
        / NULLIF(COUNT(*),0), 2)                   AS churn_rate_pct
FROM binned
GROUP BY monthlycharges_group
ORDER BY
  CASE monthlycharges_group
    WHEN '€0–25'   THEN 1
    WHEN '€25–50'  THEN 2
    WHEN '€50–75'  THEN 3
    WHEN '€75–100' THEN 4
    WHEN '€100+'   THEN 5
    ELSE 6
  END;

