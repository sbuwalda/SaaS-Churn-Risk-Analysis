-- Select customers with risk profile features (q2)

SELECT *
FROM cleaned_churn_data
WHERE contract = 'Month-to-month'
  AND dependents = 'No'
  AND internetservice = 'Fiber optic'
  AND paymentmethod = 'Electronic check'
  AND seniorcitizen = 1
  AND tenure BETWEEN 0 AND 12
  AND partner = 'No'
;
