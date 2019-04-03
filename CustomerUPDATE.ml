.LOGTABLE financial.log_new;
.logon 192.168.128.128/dbc,dbc;

.BEGIN MLOAD TABLES financial.customer_new;
.LAYOUT CUSTOMER;
.FIELD in_cust_id * VARCHAR(30);
.FIELD in_income * VARCHAR(30);
.FIELD in_age * VARCHAR(30);
.FIELD in_years_with_bank * VARCHAR(30);
.FIELD in_nbr_children * VARCHAR(30);
.FIELD in_gender * VARCHAR(30);
.FIELD in_marital_status * VARCHAR(30);

.DML LABEL UPDCUST
DO INSERT FOR  MISSING UPDATE ROWS;
UPDATE financial.customer_new
SET YEARS_WITH_BANK=:in_years_with_bank , income = :in_income ,age=:in_age 
WHERE CUST_ID=:in_cust_id ;

INSERT INTO financial.customer_new
(CUST_ID,INCOME,AGE,YEARS_WITH_BANK,NBR_CHILDREN,GENDER,MARITAL_STATUS)
VALUES
(:in_cust_id,
 :in_income,
 :in_age,
 :in_years_with_bank,
 :in_nbr_children,
 :in_gender,
 :in_marital_status);


.IMPORT INFILE Customer_DATA.txt
FORMAT VARTEXT'|'
LAYOUT CUSTOMER APPLY UPDCUST;
.END MLOAD;
.LOGOFF;


