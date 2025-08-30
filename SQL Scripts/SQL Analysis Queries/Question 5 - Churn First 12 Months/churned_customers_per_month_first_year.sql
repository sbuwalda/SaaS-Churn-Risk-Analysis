-- Churned customers per month (first 12 months)
SELECT 
    tenure AS month_number,
    COUNT(*) AS churned_customers
FROM cleaned_churn_data
WHERE churn = 'Yes'
  AND tenure BETWEEN 1 AND 12
GROUP BY tenure
ORDER BY month_number;
