# Commercial Lending Management & Analytics

## Project Overview

A PostgreSQL-based Commercial Lending Management System designed to analyze the complete lending lifecycle — from loan application and approval to portfolio exposure, credit risk, and repayment performance.

The project combines SQL analysis with business-focused insights to support lending, risk, and portfolio management decisions.

---

## Business Objective

The objective of this project is to analyze commercial lending data and answer key business questions such as:

- What is the overall loan application approval rate?
- Which branches perform best?
- Which loan products have the highest exposure?
- What is the credit-risk profile of approved and rejected applications?
- Which customers have the highest loan exposure?
- Which loans are overdue?
- Where is the highest outstanding repayment risk?

---

## Technology Stack

- PostgreSQL
- SQL
- pgAdmin
- GitHub
- Power BI *(Dashboard in progress)*

---

## Database Design

The database contains multiple entities representing a commercial lending environment, including:

- Customers
- Loan Applications
- Loans
- Loan Products
- Branches
- Employees
- Credit Scores
- Payments
- Documents
- Transactions
- Loan Status History

### ER Diagram

![Commercial Lending ER Diagram](ERD.png)

---

# SQL Analysis

The project contains five major analytical areas:

### 1. Loan Origination

Analysis of:

- Application status
- Approval rate
- Requested loan amounts
- Application trends
- Loan purposes

### 2. Branch Performance

Analysis of:

- Applications by branch
- Loan volume
- Loan exposure
- Overdue exposure
- Branch approval rates

### 3. Credit Risk

Analysis of:

- Average credit score
- Credit score by application status
- Requested loan amount by risk outcome
- Product-level approval performance
- Approved vs rejected credit profiles

### 4. Portfolio Analysis

Analysis of:

- Total portfolio size
- Outstanding balance
- Product-level exposure
- Customer concentration
- Loan status
- Individual loan exposure

### 5. Repayment Analysis

Analysis of:

- Outstanding balances
- Overdue loans
- Product-level repayment exposure
- Loan lifecycle status
- High-exposure loans

---

# Key Business Insights

### Loan Portfolio

- Total loans: **20**
- Total loan amount: **₹115 million**
- Outstanding balance: **₹55 million**
- Average loan amount: **₹5.75 million**
- Overall outstanding exposure: **47.83%**

### Application Performance

- **60%** of applications were approved.
- **20%** were pending.
- **20%** were rejected.

### Branch Performance

The highest branch approval rate was **83.33%**, recorded by Delhi, Nagpur, Pune, and Bengaluru branches.

Hyderabad and Mumbai recorded **0% approval** in the analyzed dataset and may require further investigation.

### Credit Risk

Approved applications had an average credit score of **691.20**, compared with **684.40** for rejected applications.

This indicates that credit score alone may not explain the approval decision and should be evaluated alongside other lending factors.

### Portfolio Risk

- **12 active loans**
- **4 overdue loans**
- **4 closed loans**
- Overdue outstanding exposure: **₹7.875 million**

Equipment Finance had the highest outstanding percentage at **65%**.

---

# Project Structure

```text
Commercial-Lending-Management-System
│
├── analysis/
│   ├── 01_loan_origination.sql
│   ├── 02_branch_performance.sql
│   ├── 03_credit_risk.sql
│   ├── 04_portfolio_analysis.sql
│   └── 05_repayment_analysis.sql
│
├── results/
│   ├── 01_loan_origination_results.md
│   ├── 02_branch_performance_results.md
│   ├── 03_credit_risk_results.md
│   ├── 04_portfolio_analysis_results.md
│   └── 05_repayment_analysis_results.md
│
├── database/
│   └── SQL database scripts
│
├── ERD.png
│
└── README.md
