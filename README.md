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
