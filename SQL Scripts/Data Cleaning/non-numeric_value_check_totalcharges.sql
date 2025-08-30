-- Convert totalcharges from TEXT to NUMERIC
-- We first preview any non-numeric values to avoid conversion errors.

SELECT totalcharges
FROM raw_churn_data
WHERE TRIM(totalcharges) !~ '^\d+(\.\d+)?$';