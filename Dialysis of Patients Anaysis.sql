Create database healthcare_analysis;
use healthcare_analysis;

-- KPI
-- 1.Number of Patients across various summaries

SELECT 
SUM(No_of_patients_in_transfusion_summary) AS Total_Patients_in_TS,
SUM(No_of_patients_in_hypercalcemia_summary) AS Total_Patients_in_HS,
SUM(No_of_patients_in_Serum_phosphorus_summary) AS Total_Patients_in_SPS,
SUM(No_of_patients_in_hospitalization_summary) AS Total_Patients_in_HospS,
SUM(No_of_hospitalizatns_in_hospital_readmiss_summary) AS Total_Patients_in_Hosp_read_Summary,
SUM(No_of_Patients_in_survival_summary) AS Total_Patients_in_SS,
SUM(No_of_Patients_in_fistula_summary) AS Total_Patients_in_FS,
SUM(No_of_patients_in_LT_catheter_summary) AS Total_Patients_in_LT_Cat_Summary,
SUM(No_of_patients_in_nPCR_summary) AS Total_Patients_in_nPCR
FROM Dialysis;

-- 2.Profit Vs Non-Profit Stats
SELECT DISTINCT(`Profit_or_Non-Profit`) AS Profit_Non_Profit,
COUNT(`Profit_or_Non-Profit`) AS COUNTS
FROM Dialysis
WHERE `Profit_or_Non-Profit` IN ('Profit','Non-Profit')
GROUP BY  `Profit_or_Non-Profit`;

-- 3.Chain Organizations w.r.t. Total Performance Score as No Score
SELECT DISTINCT(Chain_Organization) , COUNT(Total_Performance_Score) AS Total_Performance_Score
FROM Dialysis
WHERE Total_Performance_Score = 'No Score'
GROUP BY Chain_Organization;

-- 4.Dialysis Stations Stats
SELECT DISTINCT(Chain_Organization) , SUM(Dialysis_Stations) AS Dialysis_Stations
FROM Dialysis
GROUP BY Chain_Organization;

-- 5.# of Category Text  - As Expected
SELECT 
    SUM(CASE WHEN Patient_Transfusion_category_text = 'As Expected' THEN 1 ELSE 0 END) AS Transfusion_As_Expected_Count,
    SUM(CASE WHEN Patient_hospitalization_category_text = 'As Expected' THEN 1 ELSE 0 END) AS Hospitalization_As_Expected_Count,
    SUM(CASE WHEN Patient_Hospital_Readmission_Category = 'As Expected' THEN 1 ELSE 0 END) AS Hospital_Readmission_As_Expected_Count,
    SUM(CASE WHEN Patient_Survival_Category_Text = 'As Expected' THEN 1 ELSE 0 END) AS Survival_As_Expected_Count,
    SUM(CASE WHEN Patient_Infection_category_text = 'As Expected' THEN 1 ELSE 0 END) AS Infection_As_Expected_Count,
    SUM(CASE WHEN Fistula_Category_Text = 'As Expected' THEN 1 ELSE 0 END) AS Fistula_As_Expected_Count,
    SUM(CASE WHEN SWR_category_text = 'As Expected' THEN 1 ELSE 0 END) AS SWR_As_Expected_Count,
    SUM(CASE WHEN PPPW_category_text = 'As Expected' THEN 1 ELSE 0 END) AS PPPW_As_Expected_Count
FROM Dialysis;

-- 6.Average Payment Reduction Rate
SELECT 
AVG(CASE WHEN `Payment_Reduction_Percentage` NOT LIKE '%NA%' THEN CAST(REPLACE(`Payment_Reduction_Percentage`, '%', '') AS DECIMAL(10, 2))
ELSE NULL 
END) AS Average_Reduction
FROM Dialysis;

