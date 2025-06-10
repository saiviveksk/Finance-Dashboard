Finance Dashboard – MySQL & Power BI

About
This project focuses on analyzing loan and repayment data from a financial institution to assess customer risk, monitor repayment behavior, and track financial KPIs.

Dataset
1)finance_1.csv (Loan Application Data):
member_id, loan_amnt, grade, sub_grade
home_ownership, verification_status, issue_d
loan_status, zip_code, addr_state
2)finance_2.csv (Loan Repayment and Credit Data):
id (links to member_id)
revol_bal, total_acc, total_pymnt
last_pymnt_d, last_pymnt_amnt, last_credit_pull_d

Methodology / Techniques
• Loaded both datasets into MySQL and created a JOIN on member_id = id
• Cleaned and standardized date formats (issue_d, last_pymnt_d)
• Used SQL to filter, group, and aggregate key metrics
• Built Power BI model using Power Query and DAX measures
• Created interactive visuals to filter by Grade, State, Time of issue, and Payment behavior

KPIs Tracked
• Total Loan Amount Issued
• Average Loan per Grade (A-G)
• Outstanding Balance (Revolving Balances)
• Average Total Payment Made
• Last Payment Date Trends
• Home Ownership vs Loan Approval
• State-wise Loan Distribution

Results
• Analyzed over 80,000+ loan records across multiple dimensions (Grade, State, Payment Behavior)
• Enabled risk categorization based on payment history, grade, and verification status
• Built a dashboard with 12+ interactive visuals including KPI cards, line trends, and bar graphs
• Reduced report generation time by ~65% compared to spreadsheet models
• Verified users in Grade B and C accounted for over 50% of total loans issued
• Renters had higher loan issuance but slightly lower repayment performance

Conclusion
The dashboard provides a 360° financial view of the lending portfolio, enabling better insights into customer risk and repayment trends.
Demonstrates effective use of SQL for backend processing and Power BI for visual storytelling. Suitable for financial analysts, loan managers, and risk teams aiming to drive decisions based on data.
