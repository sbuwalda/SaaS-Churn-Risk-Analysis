-- insert_data.sql
-- Description: Data import step for raw Telco Churn dataset
-- Note: Import was executed using pgAdmin's Import/Export GUI due to file access limitations
-- with server-side COPY. The script below shows the exact equivalent for documentation.

-- Target table
-- raw_churn_data (see create_tables.sql for schema)

-- Equivalent COPY command:
COPY raw_churn_data
FROM 'C:/postgres_imports/raw_data_set_telco_customer_churn.csv'
DELIMITER ','
CSV HEADER;
