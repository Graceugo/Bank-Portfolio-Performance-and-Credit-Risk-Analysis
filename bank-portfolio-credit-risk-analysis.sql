/**Business Question 1: What is the overall performance of the bank's loan portfolio?**/
--Total Loan Application
SELECT COUNT (*) AS Total_Loan_App1ications FROM Bank_Loan_data
--Total Funded Amount
SELECT SUM  (Loan_amount) AS Total_Funded_Amount FROM Bank_Loan_data
--Total Amount Recieved
SELECT SUM  (Total_Payment)AS Total_Amount_Received FROM Bank_Loan_data

/**Loan Status Analysis including total loans, total amount issued,and Total amount recovered for fully paid, charged off and
current loans respectively**/
SELECT 
loan_status,  
COUNT (*) AS Loan_Count,  
SUM (Loan_amount) AS Total_Funded,
SUM (total_payment) AS Total_Received 
FROM Bank_Loan_data 
GROUP BY loan_status

--Total Default Rate
SELECT
ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END)/ COUNT(*), 2) AS Total_Default_Rate
FROM Bank_Loan_Data;

--Fully Paid Rate
SELECT
ROUND(100.0 * SUM(CASE WHEN loan_status = 'Fully Paid' THEN 1 ELSE 0 END)/ COUNT(*), 2) AS Fully_Paid_Rate
FROM Bank_Loan_Data;

--Estimated Financial Loss from Defaults
SELECT
SUM(CASE WHEN loan_status = 'Charged Off'THEN loan_amount - total_payment ELSE 0
END) AS Estimated_Loss
FROM bank_loan_data;


/** Business Question 2: Which customer characteristics are associated with higher loan default rate?**/
--Annual Income Band (Total loan, Default and Default Rate)
SELECT
Annual_Income_Band,
COUNT(*) AS Total_Loans,
SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS Defaults,
ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END)/ COUNT(*),2) AS Default_Rate
FROM Bank_Loan_Data
GROUP BY Annual_Income_Band
ORDER BY Default_Rate DESC;

--Home Ownership Default Rate (Total loan, default and default rate
SELECT
home_ownership,
COUNT(*) AS Total_Loans,
SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS Defaulted_Loans,
ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END)/ COUNT(*),2) AS Default_Rate
FROM Bank_Loan_Data
GROUP BY home_ownership
ORDER BY Default_Rate DESC;

--Employment Length Experience Group Default rate
SELECT
Empt_Lgth_Experience_Group,
COUNT(*) AS Total_Loans,
SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS Defaulted_Loans,
ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END)/ COUNT(*),2) AS Default_Rate
FROM Bank_Loan_Data
GROUP BY Empt_Lgth_Experience_Group
ORDER BY Default_Rate DESC;


/* Business Question 3: Which Loan characteristics are associated with higher loan default rate?*/
--Grade Default Rate
SELECT
grade,COUNT(*) AS Total_Loans,SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS Defaulted_Loans,
ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END)/ COUNT(*),2) AS Default_Rate
FROM Bank_Loan_Data
GROUP BY grade
ORDER BY Default_Rate DESC;

--Term Default Rate
SELECT term,
ROUND(100.0*SUM(CASE WHEN loan_status='charged off' THEN 1 ELSE 0 END)/COUNT(*),2)
AS default_rate
FROM Bank_Loan_data
GROUP BY term

--Purpose Default Rate
SELECT 
Purpose,
ROUND(100.0*SUM(CASE WHEN loan_status='charged off' THEN 1 ELSE 0 END)/COUNT(*),2)
AS default_rate
FROM bank_Loan_data
GROUP BY Purpose
ORDER BY default_rate DESC;

/* Business Question 4: Which state present the highest credit Risk?*/
--Default Rate by state
SELECT
State,COUNT(*) AS total_Loans,SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS defaults,
ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END)/ COUNT(*),2) AS Default_Rate
FROM Bank_Loan_data
GROUP BY state
HAVING COUNT(*) >=50
ORDER by Default_rate DESC;


/*Business Question 5: Does Income verification reduce the likelihood of loan default?*/
--Default Rate by Verification
SELECT
verification_status,COUNT(*) AS total_Loans,SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS defaults,
ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END)/ COUNT(*),2) AS Default_Rate
FROM Bank_Loan_data
GROUP BY verification_status
ORDER by Default_rate DESC;


/*Business Question 6: what does a high-risk borrowers profile look like?*/
--High-Risk borrower profile
SELECT
    grade,
    term,
    Annual_Income_Band,
    DTI_Band,
    home_ownership,
    COUNT(*) AS Borrowers
FROM Bank_Loan_Data
WHERE loan_status = 'Charged Off'
GROUP BY
    grade,
    term,
    Annual_Income_Band,
    DTI_Band,
    home_ownership
ORDER BY Borrowers DESC;















