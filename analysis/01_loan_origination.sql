-- Loan Origination Analysis
-- Looking at application volume and final application status.

-- 1. Overall application status

SELECT
    status,
    COUNT(*) AS application_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM loan_applications
GROUP BY status
ORDER BY application_count DESC;


-- 2. Applications by loan purpose

SELECT
    loan_purpose,
    COUNT(*) AS application_count
FROM loan_applications
GROUP BY loan_purpose
ORDER BY application_count DESC;


-- 3. Average requested amount by application status

SELECT
    status,
    COUNT(*) AS applications,
    ROUND(AVG(requested_amount), 2) AS average_requested_amount,
    MIN(requested_amount) AS minimum_requested_amount,
    MAX(requested_amount) AS maximum_requested_amount
FROM loan_applications
GROUP BY status
ORDER BY status;


-- 4. Applications submitted over time

SELECT
    DATE_TRUNC('month', application_date) AS application_month,
    COUNT(*) AS application_count
FROM loan_applications
GROUP BY application_month
ORDER BY application_month;
