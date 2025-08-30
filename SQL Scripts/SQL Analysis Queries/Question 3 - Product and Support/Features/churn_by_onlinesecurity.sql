-- Churn rate by use of Online Security

SELECT 
    onlinesecurity AS category,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*), 2) AS churn_rate_pct
FROM cleaned_churn_data
GROUP BY onlinesecurity
ORDER BY churn_rate_pct DESC;
