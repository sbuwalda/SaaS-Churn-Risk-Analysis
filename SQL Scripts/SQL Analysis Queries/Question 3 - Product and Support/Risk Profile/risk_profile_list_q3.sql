-- Select customers with q3 risk profile features

SELECT *
FROM cleaned_churn_data
WHERE deviceprotection = 'No'
  AND internetservice = 'Fiber optic'
  AND onlinebackup = 'No'
  AND onlinesecurity = 'No'
  AND paperlessbilling = 'Yes'
  AND techsupport = 'No'
  AND streamingmovies = 'No'
  AND streamingtv = 'No'
;
