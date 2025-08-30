-- Selecteer klanten die vallen binnen het gedefinieerde churn-risicoprofiel

SELECT *
FROM cleaned_churn_data
WHERE contract = 'Month-to-month'
  AND monthlycharges BETWEEN 75 AND 100
  AND paymentmethod = 'Electronic check'
  AND totalcharges::FLOAT BETWEEN 0 AND 500
  AND tenure BETWEEN 0 AND 12
ORDER BY churn DESC;
