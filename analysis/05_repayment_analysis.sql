-- Repayment and collection analysis

-- 1. Current loan status and outstanding exposure

SELECT
    status,
    COUNT(*) AS loan_count,
    SUM(principal_amount) AS total_disbursed,
    SUM(outstanding_balance) AS total_outstanding,
    ROUND(
        SUM(outstanding_balance) * 100.0
        / NULLIF(SUM(principal_amount), 0),
        2
    ) AS outstanding_rate
FROM loans
GROUP BY status
ORDER BY total_outstanding DESC;


-- 2. Loans with the highest outstanding balances

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


-- 3. Outstanding exposure by loan product

SELECT
    lp.product_name,
    COUNT(l.loan_id) AS loan_count,
    SUM(l.principal_amount) AS total_disbursed,
    SUM(l.outstanding_balance) AS total_outstanding,
    ROUND(
        SUM(l.outstanding_balance) * 100.0
        / NULLIF(SUM(l.principal_amount), 0),
        2
    ) AS outstanding_rate
FROM loans l
JOIN loan_products lp
    ON l.product_id = lp.product_id
GROUP BY
    lp.product_id,
    lp.product_name
ORDER BY total_outstanding DESC;


-- 4. Overdue and defaulted exposure

SELECT
    status,
    COUNT(*) AS loan_count,
    SUM(principal_amount) AS total_disbursed,
    SUM(outstanding_balance) AS overdue_exposure
FROM loans
WHERE status IN ('Overdue', 'Defaulted')
GROUP BY status
ORDER BY overdue_exposure DESC;


-- 5. Loan status movement

SELECT
    lsh.status,
    COUNT(*) AS status_events
FROM loan_status_history lsh
GROUP BY lsh.status
ORDER BY status_events DESC;
