-- Check for duplicate customer IDs
-- This identifies any customerid values that appear more than once in the dataset
-- We expect customerid to be unique per row (one row = one customer)

SELECT customerid, COUNT(*) AS occurrence_count
FROM raw_churn_data
GROUP BY customerid
HAVING COUNT(*) > 1;

-- no duplicate customerid values were found. That confirms each row represents a unique customer.