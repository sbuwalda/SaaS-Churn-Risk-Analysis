-- Q1 Risk profile customer list
SELECT *
FROM cleaned_churn_data
WHERE tenure BETWEEN 0 AND 12
  AND paymentmethod = 'Electronic check'
  AND contract = 'Month-to-month'
  AND internetservice = 'Fiber optic'
  AND onlinesecurity = 'No'
  AND techsupport = 'No'
  AND seniorcitizen = 1
  AND totalcharges BETWEEN 0 AND 500;
