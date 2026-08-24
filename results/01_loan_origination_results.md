# Loan Origination Results

This file contains selected results from the loan origination analysis.

## Key Questions

- Which applications are being approved?
- Which loan products have higher approval rates?
- How many applications are approved versus rejected?
- What is the average requested loan amount?

## Analysis

The SQL queries used for this analysis are available in:

`analysis/01_loan_origination.sql`

## Results

### Overall Application Status

| Status | Application Count | Percentage |
|---|---:|---:|
| Approved | 30 | 60.00% |
| Pending | 10 | 20.00% |
| Rejected | 10 | 20.00% |

### Business Insight

The dataset shows that 60% of loan applications were approved, while 20% were rejected and another 20% remained pending.

This provides a quick view of the overall application pipeline and approval outcome.

### Applications by Loan Purpose

| Loan Purpose | Application Count |
|---|---:|
| Equipment purchase | 10 |
| Commercial property | 10 |
| Working capital requirement | 10 |
| Inventory financing | 10 |
| Business expansion | 10 |

### Business Insight

Applications are evenly distributed across the five loan purposes, with 10 applications for each category.

### Requested Loan Amount by Application Status

| Status | Applications | Average Requested Amount | Minimum Requested Amount | Maximum Requested Amount |
|---|---:|---:|---:|---:|
| Approved | 30 | 5,775,000.00 | 750,000.00 | 12,000,000.00 |
| Pending | 10 | 6,375,000.00 | 750,000.00 | 12,000,000.00 |
| Rejected | 10 | 4,550,000.00 | 750,000.00 | 8,000,000.00 |

### Business Insight

Pending applications have the highest average requested loan amount, while rejected applications have the lowest. Approved applications have a higher average requested amount than rejected applications.
