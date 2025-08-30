-- Check for missing or null values
-- This identifies how many rows have nulls in each column.
-- Important for determining which columns need cleaning or imputation.

SELECT 
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(customerid) AS missing_customerid,
    COUNT(*) - COUNT(gender) AS missing_gender,
    COUNT(*) - COUNT(seniorcitizen) AS missing_seniorcitizen,
    COUNT(*) - COUNT(partner) AS missing_partner,
    COUNT(*) - COUNT(dependents) AS missing_dependents,
    COUNT(*) - COUNT(tenure) AS missing_tenure,
    COUNT(*) - COUNT(phoneservice) AS missing_phoneservice,
    COUNT(*) - COUNT(multiplelines) AS missing_multiplelines,
    COUNT(*) - COUNT(internetservice) AS missing_internetservice,
    COUNT(*) - COUNT(onlinesecurity) AS missing_onlinesecurity,
    COUNT(*) - COUNT(onlinebackup) AS missing_onlinebackup,
    COUNT(*) - COUNT(deviceprotection) AS missing_deviceprotection,
    COUNT(*) - COUNT(techsupport) AS missing_techsupport,
    COUNT(*) - COUNT(streamingtv) AS missing_streamingtv,
    COUNT(*) - COUNT(streamingmovies) AS missing_streamingmovies,
    COUNT(*) - COUNT(contract) AS missing_contract,
    COUNT(*) - COUNT(paperlessbilling) AS missing_paperlessbilling,
    COUNT(*) - COUNT(paymentmethod) AS missing_paymentmethod,
    COUNT(*) - COUNT(monthlycharges) AS missing_monthlycharges,
    COUNT(*) - COUNT(totalcharges) AS missing_totalcharges,
    COUNT(*) - COUNT(churn) AS missing_churn
FROM raw_churn_data;

-- Executed a full column-wise null scan across all 7043 rows in raw_churn_data.
-- Output confirmed that there are 0 missing values in every column.
-- Conclusion: No null handling or imputation is required at this stage.