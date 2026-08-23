-- Table: public.branches

-- DROP TABLE IF EXISTS public.branches;

CREATE TABLE IF NOT EXISTS public.branches
(
    branch_id integer NOT NULL DEFAULT nextval('branches_branch_id_seq'::regclass),
    branch_code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    branch_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    city character varying(50) COLLATE pg_catalog."default" NOT NULL,
    state character varying(50) COLLATE pg_catalog."default" NOT NULL,
    country character varying(50) COLLATE pg_catalog."default" DEFAULT 'India'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT branches_pkey PRIMARY KEY (branch_id),
    CONSTRAINT branches_branch_code_key UNIQUE (branch_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.branches
    OWNER to postgres;


-- Table: public.customers

-- DROP TABLE IF EXISTS public.customers;

CREATE TABLE IF NOT EXISTS public.customers
(
    customer_id integer NOT NULL DEFAULT nextval('customers_customer_id_seq'::regclass),
    customer_code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    business_name character varying(150) COLLATE pg_catalog."default" NOT NULL,
    business_type character varying(50) COLLATE pg_catalog."default" NOT NULL,
    pan_number character varying(10) COLLATE pg_catalog."default" NOT NULL,
    registration_number character varying(30) COLLATE pg_catalog."default",
    mobile_number character varying(15) COLLATE pg_catalog."default" NOT NULL,
    email character varying(100) COLLATE pg_catalog."default",
    address character varying(250) COLLATE pg_catalog."default",
    city character varying(50) COLLATE pg_catalog."default",
    state character varying(50) COLLATE pg_catalog."default",
    annual_revenue numeric(15,2),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT customers_pkey PRIMARY KEY (customer_id),
    CONSTRAINT customers_customer_code_key UNIQUE (customer_code),
    CONSTRAINT customers_pan_number_key UNIQUE (pan_number),
    CONSTRAINT customers_registration_number_key UNIQUE (registration_number),
    CONSTRAINT customers_annual_revenue_check CHECK (annual_revenue >= 0::numeric)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.customers
    OWNER to postgres;


-- Table: public.employees

-- DROP TABLE IF EXISTS public.employees;

CREATE TABLE IF NOT EXISTS public.employees
(
    employee_id integer NOT NULL DEFAULT nextval('employees_employee_id_seq'::regclass),
    employee_code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    first_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    job_title character varying(50) COLLATE pg_catalog."default" NOT NULL,
    branch_id integer NOT NULL,
    email character varying(100) COLLATE pg_catalog."default",
    hire_date date NOT NULL,
    status character varying(20) COLLATE pg_catalog."default" DEFAULT 'Active'::character varying,
    CONSTRAINT employees_pkey PRIMARY KEY (employee_id),
    CONSTRAINT employees_email_key UNIQUE (email),
    CONSTRAINT employees_employee_code_key UNIQUE (employee_code),
    CONSTRAINT fk_employee_branch FOREIGN KEY (branch_id)
        REFERENCES public.branches (branch_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.employees
    OWNER to postgres;


-- Table: public.loan_products

-- DROP TABLE IF EXISTS public.loan_products;

CREATE TABLE IF NOT EXISTS public.loan_products
(
    product_id integer NOT NULL DEFAULT nextval('loan_products_product_id_seq'::regclass),
    product_code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    product_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    product_type character varying(50) COLLATE pg_catalog."default" NOT NULL,
    min_loan_amount numeric(15,2),
    max_loan_amount numeric(15,2),
    interest_rate numeric(5,2),
    max_tenure_months integer,
    status character varying(20) COLLATE pg_catalog."default" DEFAULT 'Active'::character varying,
    CONSTRAINT loan_products_pkey PRIMARY KEY (product_id),
    CONSTRAINT loan_products_product_code_key UNIQUE (product_code),
    CONSTRAINT loan_products_min_loan_amount_check CHECK (min_loan_amount >= 0::numeric),
    CONSTRAINT loan_products_check CHECK (max_loan_amount > min_loan_amount),
    CONSTRAINT loan_products_interest_rate_check CHECK (interest_rate >= 0::numeric),
    CONSTRAINT loan_products_max_tenure_months_check CHECK (max_tenure_months > 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.loan_products
    OWNER to postgres;


-- Table: public.loan_applications

-- DROP TABLE IF EXISTS public.loan_applications;

CREATE TABLE IF NOT EXISTS public.loan_applications
(
    application_id integer NOT NULL DEFAULT nextval('loan_applications_application_id_seq'::regclass),
    application_number character varying(20) COLLATE pg_catalog."default" NOT NULL,
    customer_id integer NOT NULL,
    product_id integer NOT NULL,
    branch_id integer NOT NULL,
    employee_id integer NOT NULL,
    requested_amount numeric(15,2) NOT NULL,
    application_date date NOT NULL,
    status character varying(20) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Pending'::character varying,
    decision_date date,
    loan_purpose character varying(150) COLLATE pg_catalog."default",
    CONSTRAINT loan_applications_pkey PRIMARY KEY (application_id),
    CONSTRAINT loan_applications_application_number_key UNIQUE (application_number),
    CONSTRAINT fk_application_branch FOREIGN KEY (branch_id)
        REFERENCES public.branches (branch_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_application_customer FOREIGN KEY (customer_id)
        REFERENCES public.customers (customer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_application_employee FOREIGN KEY (employee_id)
        REFERENCES public.employees (employee_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_application_product FOREIGN KEY (product_id)
        REFERENCES public.loan_products (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT loan_applications_requested_amount_check CHECK (requested_amount > 0::numeric),
    CONSTRAINT loan_applications_status_check CHECK (status::text = ANY (ARRAY['Pending'::character varying, 'Approved'::character varying, 'Rejected'::character varying, 'Withdrawn'::character varying]::text[]))
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.loan_applications
    OWNER to postgres;

-- Table: public.credit_scores

-- DROP TABLE IF EXISTS public.credit_scores;

CREATE TABLE IF NOT EXISTS public.credit_scores
(
    credit_score_id integer NOT NULL DEFAULT nextval('credit_scores_credit_score_id_seq'::regclass),
    customer_id integer NOT NULL,
    score integer NOT NULL,
    score_date date NOT NULL,
    bureau_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT credit_scores_pkey PRIMARY KEY (credit_score_id),
    CONSTRAINT fk_credit_score_customer FOREIGN KEY (customer_id)
        REFERENCES public.customers (customer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT credit_scores_score_check CHECK (score >= 300 AND score <= 900)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.credit_scores
    OWNER to postgres;

-- Table: public.loans

-- DROP TABLE IF EXISTS public.loans;

CREATE TABLE IF NOT EXISTS public.loans
(
    loan_id integer NOT NULL DEFAULT nextval('loans_loan_id_seq'::regclass),
    loan_number character varying(20) COLLATE pg_catalog."default" NOT NULL,
    application_id integer NOT NULL,
    customer_id integer NOT NULL,
    product_id integer NOT NULL,
    principal_amount numeric(15,2) NOT NULL,
    interest_rate numeric(5,2) NOT NULL,
    tenure_months integer NOT NULL,
    disbursement_date date NOT NULL,
    maturity_date date NOT NULL,
    outstanding_balance numeric(15,2) NOT NULL,
    status character varying(20) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Active'::character varying,
    CONSTRAINT loans_pkey PRIMARY KEY (loan_id),
    CONSTRAINT loans_application_id_key UNIQUE (application_id),
    CONSTRAINT loans_loan_number_key UNIQUE (loan_number),
    CONSTRAINT fk_loan_application FOREIGN KEY (application_id)
        REFERENCES public.loan_applications (application_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_loan_customer FOREIGN KEY (customer_id)
        REFERENCES public.customers (customer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_loan_product FOREIGN KEY (product_id)
        REFERENCES public.loan_products (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT loans_principal_amount_check CHECK (principal_amount > 0::numeric),
    CONSTRAINT loans_interest_rate_check CHECK (interest_rate >= 0::numeric),
    CONSTRAINT loans_tenure_months_check CHECK (tenure_months > 0),
    CONSTRAINT loans_outstanding_balance_check CHECK (outstanding_balance >= 0::numeric),
    CONSTRAINT loans_status_check CHECK (status::text = ANY (ARRAY['Active'::character varying, 'Closed'::character varying, 'Overdue'::character varying, 'Defaulted'::character varying]::text[])),
    CONSTRAINT chk_loan_dates CHECK (maturity_date >= disbursement_date)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.loans
    OWNER to postgres;

-- Table: public.loan_status_history

-- DROP TABLE IF EXISTS public.loan_status_history;

CREATE TABLE IF NOT EXISTS public.loan_status_history
(
    status_history_id integer NOT NULL DEFAULT nextval('loan_status_history_status_history_id_seq'::regclass),
    loan_id integer NOT NULL,
    status character varying(20) COLLATE pg_catalog."default" NOT NULL,
    status_date date NOT NULL,
    remarks character varying(250) COLLATE pg_catalog."default",
    CONSTRAINT loan_status_history_pkey PRIMARY KEY (status_history_id),
    CONSTRAINT fk_status_history_loan FOREIGN KEY (loan_id)
        REFERENCES public.loans (loan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT loan_status_history_status_check CHECK (status::text = ANY (ARRAY['Approved'::character varying, 'Disbursed'::character varying, 'Active'::character varying, 'Overdue'::character varying, 'Closed'::character varying, 'Defaulted'::character varying]::text[]))
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.loan_status_history
    OWNER to postgres;

-- Table: public.documents

-- DROP TABLE IF EXISTS public.documents;

CREATE TABLE IF NOT EXISTS public.documents
(
    document_id integer NOT NULL DEFAULT nextval('documents_document_id_seq'::regclass),
    application_id integer NOT NULL,
    document_type character varying(50) COLLATE pg_catalog."default" NOT NULL,
    document_name character varying(150) COLLATE pg_catalog."default" NOT NULL,
    submission_date date NOT NULL,
    verification_status character varying(20) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Pending'::character varying,
    remarks character varying(250) COLLATE pg_catalog."default",
    CONSTRAINT documents_pkey PRIMARY KEY (document_id),
    CONSTRAINT fk_document_application FOREIGN KEY (application_id)
        REFERENCES public.loan_applications (application_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT documents_verification_status_check CHECK (verification_status::text = ANY (ARRAY['Pending'::character varying, 'Verified'::character varying, 'Rejected'::character varying]::text[]))
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.documents
    OWNER to postgres;
