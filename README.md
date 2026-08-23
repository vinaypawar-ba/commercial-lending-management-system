# Commercial Lending Management System

A PostgreSQL-based project built around a commercial lending lifecycle.

I built this project to work with lending data the way a Business Analyst would: starting with loan applications, looking at credit risk and approvals, and then following the portfolio through disbursement and repayment.

The data is synthetic and created for portfolio and learning purposes.

## Business Areas

- Loan origination
- Credit assessment
- Approval and rejection
- Loan portfolio exposure
- Branch performance
- Repayment and overdue exposure

## Database

The database contains related tables covering customers, branches, loan products, loan applications, credit scores, loans, payments, documents, employees and loan status history.

The tables are connected through primary and foreign keys to represent a realistic lending workflow.

## Business Questions

The analysis focuses on questions such as:

- Which applications are being approved or rejected?
- Which branches are performing better?
- Which loan products have stronger approval rates?
- Is credit score related to application outcomes?
- Where is the loan portfolio concentrated?
- Which customers have higher outstanding exposure?
- Where is overdue exposure concentrated?
- How is repayment performance varying across the portfolio?

## SQL Analysis

The `analysis` folder contains separate analysis areas:

1. **Loan Origination** — application and approval patterns
2. **Branch Performance** — branch-level lending performance
3. **Credit Risk** — credit score and application outcomes
4. **Portfolio Analysis** — loan exposure and outstanding balances
5. **Repayment Analysis** — repayment and overdue exposure

The queries use PostgreSQL features including joins, aggregations, subqueries, CTEs, conditional logic and business-focused calculations.

## Key Findings

A few observations stood out from the analysis:

### Loan Origination
- 50 applications were analysed.
- 30 were approved, giving an overall approval rate of 60%.
- 10 applications were pending and 10 were rejected.

### Branch Performance
- Approval performance varied considerably across branches.
- Delhi, Nagpur and Pune showed stronger approval performance in the sample.
- Hyderabad and Mumbai had no approved applications in the available data.

### Credit Risk
- Approved applications had an average credit score of 691.2.
- Pending applications averaged 659.5.
- Rejected applications averaged 684.4.
- This suggests that credit score alone does not explain every lending decision.

### Portfolio
- Total loan exposure analysed was ₹115M.
- ₹55M was outstanding.
- Exposure was distributed differently across branches and loan products.

### Repayment
- Repayment analysis was used to identify outstanding and overdue exposure.
- Delhi had the highest overdue exposure rate among branches with active disbursement.
- Branches with no disbursement were kept separate when interpreting overdue risk.

### Business Takeaway

The analysis shows that lending performance cannot be judged using one metric alone. Approval rates, credit scores, branch performance, portfolio exposure and repayment behaviour need to be considered together.

## Project Structure

```text
commercial-lending-management-system/
│
├── database/
│   └── 01_create_tables.sql
│
├── analysis/
│   ├── 01_loan_origination.sql
│   ├── 02_branch_performance.sql
│   ├── 03_credit_risk.sql
│   ├── 04_portfolio_analysis.sql
│   ├── 05_repayment_analysis.sql
│   └── README.md
│
└── README.md
