-- Branch Performance Analysis
-- Comparing application outcomes, loan volume and repayment exposure.


-- 1. Application performance by branch

SELECT
    b.branch_name,
    COUNT(la.application_id) AS total_applications,

    COUNT(*) FILTER (
        WHERE la.status = 'Approved'
    ) AS approved_applications,

    COUNT(*) FILTER (
        WHERE la.status = 'Rejected'
    ) AS rejected_applications,

    ROUND(
        COUNT(*) FILTER (WHERE la.status = 'Approved') * 100.0
        / NULLIF(COUNT(la.application_id), 0),
        2
    ) AS approval_rate

FROM branches b
LEFT JOIN loan_applications la
    ON b.branch_id = la.branch_id

GROUP BY
    b.branch_id,
    b.branch_name

ORDER BY approval_rate DESC;


-- 2. Loan portfolio by branch

SELECT
    b.branch_name,
    COUNT(l.loan_id) AS total_loans,
    COALESCE(SUM(l.principal_amount), 0) AS total_disbursed,
    COALESCE(SUM(l.outstanding_balance), 0) AS total_outstanding

FROM branches b
LEFT JOIN loan_applications la
    ON b.branch_id = la.branch_id
LEFT JOIN loans l
    ON la.application_id = l.application_id

GROUP BY
    b.branch_id,
    b.branch_name

ORDER BY total_disbursed DESC;


-- 3. Overdue exposure by branch

SELECT
    b.branch_name,

    COUNT(DISTINCT l.loan_id) AS total_loans,

    COALESCE(
        SUM(
            CASE
                WHEN p.payment_status = 'Overdue'
                THEN p.due_amount - p.paid_amount
                ELSE 0
            END
        ),
        0
    ) AS overdue_amount

FROM branches b
LEFT JOIN loan_applications la
    ON b.branch_id = la.branch_id
LEFT JOIN loans l
    ON la.application_id = l.application_id
LEFT JOIN payments p
    ON l.loan_id = p.loan_id

GROUP BY
    b.branch_id,
    b.branch_name

ORDER BY overdue_amount DESC;


-- 4. Overdue exposure compared with branch disbursement

WITH branch_portfolio AS (
    SELECT
        b.branch_id,
        b.branch_name,
        COALESCE(SUM(l.principal_amount), 0) AS total_disbursed
    FROM branches b
    LEFT JOIN loan_applications la
        ON b.branch_id = la.branch_id
    LEFT JOIN loans l
        ON la.application_id = l.application_id
    GROUP BY
        b.branch_id,
        b.branch_name
),

branch_overdue AS (
    SELECT
        b.branch_id,
        COALESCE(
            SUM(
                CASE
                    WHEN p.payment_status = 'Overdue'
                    THEN p.due_amount - p.paid_amount
                    ELSE 0
                END
            ),
            0
        ) AS overdue_amount
    FROM branches b
    LEFT JOIN loan_applications la
        ON b.branch_id = la.branch_id
    LEFT JOIN loans l
        ON la.application_id = l.application_id
    LEFT JOIN payments p
        ON l.loan_id = p.loan_id
    GROUP BY b.branch_id
)

SELECT
    bp.branch_name,
    bp.total_disbursed,
    bo.overdue_amount,

    ROUND(
        bo.overdue_amount * 100.0
        / NULLIF(bp.total_disbursed, 0),
        2
    ) AS overdue_exposure_rate

FROM branch_portfolio bp
JOIN branch_overdue bo
    ON bp.branch_id = bo.branch_id

ORDER BY overdue_exposure_rate DESC NULLS LAST;
