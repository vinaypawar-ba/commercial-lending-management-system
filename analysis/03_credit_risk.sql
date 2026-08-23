-- Credit risk analysis

-- 1. Credit score by application status

SELECT
    la.status,
    COUNT(*) AS application_count,
    ROUND(AVG(cs.credit_score), 2) AS average_credit_score,
    MIN(cs.credit_score) AS minimum_credit_score,
    MAX(cs.credit_score) AS maximum_credit_score
FROM loan_applications la
JOIN credit_scores cs
    ON la.application_id = cs.application_id
GROUP BY la.status
ORDER BY la.status;


-- 2. Loan amount by application status

SELECT
    status,
    COUNT(*) AS application_count,
    SUM(requested_amount) AS total_requested_amount,
    MIN(requested_amount) AS minimum_requested_amount,
    MAX(requested_amount) AS maximum_requested_amount
FROM loan_applications
GROUP BY status
ORDER BY total_requested_amount DESC;


-- 3. Approval performance by loan product

SELECT
    lp.product_name,
    COUNT(*) AS total_applications,
    COUNT(*) FILTER (WHERE la.status = 'Approved') AS approved,
    COUNT(*) FILTER (WHERE la.status = 'Pending') AS pending,
    COUNT(*) FILTER (WHERE la.status = 'Rejected') AS rejected,
    ROUND(
        COUNT(*) FILTER (WHERE la.status = 'Approved') * 100.0
        / COUNT(*),
        2
    ) AS approval_rate
FROM loan_applications la
JOIN loan_products lp
    ON la.product_id = lp.product_id
GROUP BY lp.product_name
ORDER BY approval_rate DESC;


-- 4. Compare credit scores of approved and rejected applications

SELECT
    status,
    ROUND(AVG(credit_score), 2) AS average_credit_score,
    MIN(credit_score) AS minimum_credit_score,
    MAX(credit_score) AS maximum_credit_score
FROM (
    SELECT
        la.status,
        cs.credit_score
    FROM loan_applications la
    JOIN credit_scores cs
        ON la.application_id = cs.application_id
    WHERE la.status IN ('Approved', 'Rejected')
) credit_analysis
GROUP BY status
ORDER BY status;


-- 5. Identify rejected applications with relatively strong credit scores

SELECT
    la.application_id,
    la.requested_amount,
    cs.credit_score,
    la.reason
FROM loan_applications la
JOIN credit_scores cs
    ON la.application_id = cs.application_id
WHERE la.status = 'Rejected'
  AND cs.credit_score >= 700
ORDER BY cs.credit_score DESC;
