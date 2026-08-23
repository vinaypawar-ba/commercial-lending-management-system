-- Portfolio analysis

-- 1. Overall loan portfolio

SELECT
    COUNT(*) AS total_loans,
    SUM(principal_amount) AS total_disbursed,
    SUM(outstanding_balance) AS total_outstanding,
    ROUND(AVG(principal_amount), 2) AS average_loan_amount,
    ROUND(
        SUM(outstanding_balance) * 100.0
        / NULLIF(SUM(principal_amount), 0),
        2
    ) AS outstanding_percentage
FROM loans;


-- 2. Portfolio by loan product

SELECT
    lp.product_name,
    COUNT(l.loan_id) AS total_loans,
    SUM(l.principal_amount) AS total_disbursed,
    SUM(l.outstanding_balance) AS total_outstanding,
    ROUND(AVG(l.principal_amount), 2) AS average_loan_amount
FROM loans l
JOIN loan_products lp
    ON l.product_id = lp.product_id
GROUP BY
    lp.product_id,
    lp.product_name
ORDER BY total_disbursed DESC;


-- 3. Customers with multiple loans

SELECT
    c.customer_id,
    c.business_name,
    COUNT(l.loan_id) AS number_of_loans,
    SUM(l.principal_amount) AS total_borrowed,
    SUM(l.outstanding_balance) AS total_outstanding
FROM customers c
JOIN loans l
    ON c.customer_id = l.customer_id
GROUP BY
    c.customer_id,
    c.business_name
HAVING COUNT(l.loan_id) > 1
ORDER BY total_outstanding DESC;


-- 4. Largest outstanding loan exposures

SELECT
    l.loan_number,
    c.business_name,
    lp.product_name,
    l.principal_amount,
    l.outstanding_balance,
    l.status
FROM loans l
JOIN customers c
    ON l.customer_id = c.customer_id
JOIN loan_products lp
    ON l.product_id = lp.product_id
ORDER BY l.outstanding_balance DESC
LIMIT 10;


-- 5. Loan status distribution

SELECT
    status,
    COUNT(*) AS loan_count,
    SUM(principal_amount) AS total_principal,
    SUM(outstanding_balance) AS total_outstanding
FROM loans
GROUP BY status
ORDER BY loan_count DESC;
