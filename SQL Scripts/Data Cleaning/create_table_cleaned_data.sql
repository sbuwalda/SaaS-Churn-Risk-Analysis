-- Create cleaned version of raw data with proper data types
-- Specifically: convert 'totalcharges' from TEXT to FLOAT
-- Blank values are safely converted to NULL using NULLIF + CAST

CREATE TABLE cleaned_churn_data AS
SELECT 
    customerid,
    gender,
    seniorcitizen,
    partner,
    dependents,
    tenure,
    phoneservice,
    multiplelines,
    internetservice,
    onlinesecurity,
    onlinebackup,
    deviceprotection,
    techsupport,
    streamingtv,
    streamingmovies,
    contract,
    paperlessbilling,
    paymentmethod,
    monthlycharges,
    -- Convert blank strings to NULL, then cast to FLOAT
    CAST(NULLIF(TRIM(totalcharges), '') AS FLOAT) AS totalcharges,
    churn
FROM raw_churn_data;

-- totalcharges type conversion completed
-- Identified 11 non-numeric totalcharges values (all blank strings)
-- Used NULLIF(TRIM(...), '') to convert blanks to NULL
-- Applied CAST(... AS FLOAT) to ensure proper numeric typing
-- Result stored in new table: cleaned_churn_data (7043 rows)