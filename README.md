# Commercial Lending Management System

A PostgreSQL project based on a commercial lending lifecycle.

I built this project to explore how lending data moves from loan application
through credit assessment, approval, disbursement and repayment.

The database contains synthetic data and is designed around 10 related tables,
including customers, branches, loan applications, credit scores, loans,
payments and documents.

## What I wanted to answer

- Which applications are being approved?
- Which branches are performing better?
- Which loan products have higher approval rates?
- Does credit score explain rejection?
- How much money has been disbursed?
- Where is overdue exposure concentrated?

## Some findings

The current dataset contains 50 loan applications.

30 are approved, 10 are rejected and 10 are pending, giving an overall
approval rate of 60%.

The portfolio contains 20 loans with ₹11.5 crore in principal disbursed.

The payment data shows an 89.13% collection rate, with ₹14 lakh classified
as overdue.

One interesting finding was that rejected applications did not have a
dramatically lower average credit score than approved applications. This
suggested that credit score alone was not enough to explain the decisions,
so I looked at other factors such as loan product and branch.

## Database

10 tables:

customers
branches
employees
loan_products
loan_applications
credit_scores
loans
payments
loan_status_history
documents

## SQL analysis

The analysis is being organized around business questions rather than
individual SQL concepts.

More analysis and documentation will be added as the project develops.

## Tools

PostgreSQL | pgAdmin | SQL | GitHub

## Data

All data in this repository is synthetic and created for portfolio purposes.
No real customer or banking data is included.
