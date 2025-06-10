									--	NEW DATABASE --
 create database finance;
 use finance;

									-- NEW TABLES --
									# finance_table_1
 create table finance_1(member_id int,loan_amnt int,grade varchar(2),sub_grade varchar(3),
 home_ownership varchar(10),verification_status varchar(15),issue_d date,loan_status varchar(12),
 zip_code varchar(9),addr_state varchar(4));

 
									#finance_table_2
 create table finance_2(id int,revol_bal int,total_acc int,total_pymnt decimal(10,2),
 last_pymnt_amnt decimal(10,2));



								-- INFILE DATA LOAD METHOD --
										#finance_1
 load data infile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\finance_1.csv"
into table finance_1
fields terminated  by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

										#finance_2
load data infile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\finance_2.csv"
into table finance_2
fields terminated  by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

										-- DATA VIEW  --
select * from finance_1;
select * from finance_2;
					-- CREATING INDEXES FOR COMMONLY USED COLUMNS[retrieve data fast,query optimize,time saving] --
#indexes
create index idx_loan_status on finance_1(loan_status);
create index grade on finance_1(grade);
create index idx_homeownership on finance_1(homeownership);
create index idx_verification_status on finance_1(verification_status);
create index sub_grade on finance_1(sub_grade);
show index from finance_1;
 
									-- PRIMARY KPI'S --

									# Total Borrowers
select format(count(distinct member_id),0) as Total_Borrowers from finance_1;

								# Total Loan Amount Issued
select concat(round(sum(loan_amnt)/10000000,2),"Cr") as Total_Loan_Amnt from finance_1;

                                # Total Payment Received
select concat(round(sum(total_pymnt)/10000000,2),"Cr") as Total_Payment from finance_2;

								# Total Active Loans
select format(count(*),0) as Active_Loans from finance_1 where loan_status = "Current";

								# Loan Status Distribution(GRADE WISE LOAN AMNT DISTRIBUTION)
select grade, concat(round(sum(loan_amnt)/10000000,2),"Cr") as Loan_Amnt  from finance_1
group by grade
order by sum(loan_amnt) desc;

							# Charge-off Rate(RISK METRIC/RISK UNDERSTAND)
select concat(round(sum(case when loan_status="Charged Off" then loan_amnt else 0 end)
/sum(loan_amnt)*100,2),"%") as Charged_Off_Rate from finance_1;


						# Average Payment per Loan(REPAYMENT PERFORMANCE)
select  round(avg(total_pymnt/loan_amnt),2) as Avg_Pymnt_Per_Loan from finance_1 join finance_2
 on finance_2.id=finance_1.member_id;
 
						# Average Interest Rate 
select concat(round(avg(interest_rate),2),"%") as Avg_Interest_Rate from finance_1;

                        #Average Revolving Balance(BORROWERS EXISTING DEBT LOAN)
select round(avg(revol_bal),2) as Avg_Revolt_blc from finance_2;

						-- SECONDARY KPI'S --
                        
						# Grade-wise Default Rate(GRADEWISE CREDIT RISK)
select grade,
concat(round(sum(case when loan_status = "Charged Off" then 1 else 0 end)
/count(*),2),"%")as Default_rate
from finance_1
group by grade
order by Default_rate Desc;
                        
						# Home Ownership vs Default Rate(ANALYSES RISK BASED ON HOME OWNERSHIP)
select * from finance_1 limit 2;
select home_ownership,
concat(round(sum(case when loan_status = "Charged Off" then 1 else 0 end)/count(*),2),"%") as default_rate
from finance_1
group by home_ownership
order by default_rate desc;

						# Verification Status vs Default Rate( CHECKS VERIFIED STATUS DEFAULT RATE)
select verification_status,
concat(round(sum(case when loan_status = "Charged Off" then 1 else 0 end)
/count(*),2),"%")as Default_rate
from finance_1
group by verification_status
order by Default_rate Desc;

							# State-wise Loan Distribution
select addr_state,concat(round(sum(loan_amnt)/10000000,2),"Cr") as Loan_Amnt
from finance_1 group by addr_state
order by loan_Amnt desc
limit 5;
							# Sub-grade-wise Performance
select sub_grade,round(avg(total_pymnt/loan_amnt),2) as Performance from finance_1
join finance_2 on finance_1.member_id=finance_2.id
group by sub_grade
order by Performance desc
limit 5;

							# Last Payment Amount Trend(UNDERSTANDS REPAYMNET EFFICIENCY)
select round(avg(last_pymnt_amnt),2) as Last_Pymnt from finance_2;

							# Revolving Balance to Total Account Ratio(DEBIT VS CREDIT HISTORY)
select round(avg(revol_bal/total_acc),2) as debt_vs_credit from finance_2;
		
							# Loan Issuance Trend Over Time(YEARLY LOAN AMNT GROWTH)
select  year(issue_d) as yearly ,concat(round(sum(loan_amnt)/10000000,2),"Cr") as Loan_Amnt
from finance_1 group by yearly order by yearly;
