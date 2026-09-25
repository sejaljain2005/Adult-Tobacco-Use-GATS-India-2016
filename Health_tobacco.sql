CREATE DATABASE gats_tobacco_analysis;
USE gats_tobacco_analysis;
CREATE TABLE healthcare (
    Age INT NULL,
    Residence INT NULL,
    State_ID INT NULL,
    Region_ID INT NULL,
    Survey_Weight DOUBLE NULL,
    A01 INT NULL,
    A04 DOUBLE NULL,
    A05 DOUBLE NULL,
    B01 INT NULL,
    Age_First_Smoking DOUBLE NULL,
    C01 INT NULL,
    Age_First_Smokeless_Tobacco DOUBLE NULL,
    Smoking_Quit_Attempt DOUBLE NULL,
    Healthcare_Visits_12M DOUBLE NULL,
    Home_Smoking_Rules DOUBLE NULL,
    Smoking_Allowed_Every_Room DOUBLE NULL,
    Tobacco_Info_Notice_A DOUBLE NULL,
    Tobacco_Info_Notice_B DOUBLE NULL,
    Tobacco_Info_Notice_C DOUBLE NULL,
    Smoking_Causes_Stroke DOUBLE NULL,
    Smoking_Causes_Heart_Attack DOUBLE NULL,
    Smoking_Causes_Lung_Cancer DOUBLE NULL,
    Smoking_Causes_Chronic_Cough_TB DOUBLE NULL,
    Gender VARCHAR(20) NULL,
    Residence_Type VARCHAR(20) NULL,
    Smoking_Status VARCHAR(30) NULL,
    Smokeless_Tobacco_Status VARCHAR(30) NULL,
    Education_Level VARCHAR(100) NULL,
    Work_Status VARCHAR(100) NULL,
    Age_Group VARCHAR(20) NULL,
    Current_Smoker BOOLEAN NULL
);
describe healthcare;
select * from healthcare;
SELECT COUNT(*) AS Total_Records
FROM healthcare;
SHOW TABLES;
SELECT COUNT(*) AS Total_Rows,
       COUNT(*) - COUNT(DISTINCT CONCAT_WS('|',
           Age, Residence, State_ID, Region_ID, Survey_Weight,
           A01, A04, A05, B01, Age_First_Smoking, C01,
           Age_First_Smokeless_Tobacco, Smoking_Quit_Attempt,
           Healthcare_Visits_12M, Home_Smoking_Rules,
           Smoking_Allowed_Every_Room, Tobacco_Info_Notice_A,
           Tobacco_Info_Notice_B, Tobacco_Info_Notice_C,
           Smoking_Causes_Stroke, Smoking_Causes_Heart_Attack,
           Smoking_Causes_Lung_Cancer, Smoking_Causes_Chronic_Cough_TB,
           Gender, Residence_Type, Smoking_Status,
           Smokeless_Tobacco_Status, Education_Level, Work_Status,
           Age_Group, Current_Smoker
       )) AS Possible_Duplicate_Rows
FROM healthcare;
SELECT COUNT(*) AS Total_Records
FROM healthcare;
SELECT *
FROM healthcare
LIMIT 10;
SET SQL_SAFE_UPDATES = 0;
UPDATE healthcare
SET Age_Group = REPLACE(Age_Group, 'â€“', '-')
WHERE Age_Group IS NOT NULL;
SET SQL_SAFE_UPDATES = 1;
SELECT DISTINCT Age_Group
FROM healthcare;
select * from healthcare limit 5;
SELECT COUNT(*) AS Total_Records
FROM healthcare;

ALTER TABLE healthcare
ADD COLUMN Current_Smokeless_Tobacco TINYINT(1);
--- daily,less than daily (1),not(0)---
UPDATE healthcare
SET Current_Smokeless_Tobacco =
    CASE
        WHEN Smokeless_Tobacco_Status IN ('Daily', 'Less than daily') THEN 1
        WHEN Smokeless_Tobacco_Status = 'Not at all' THEN 0
    END;
    
    
-- 1 Overall current smoking 1(smoke) 0(not) --
select Current_Smoker,count(*) as Total_Respondents ,
round(count(*)*100.0/(select count(*) from healthcare),2) as Percentage
from healthcare group by Current_Smoker;
-- current smokeless--
select Current_Smokeless_Tobacco,count(*) as Total_Respondents ,
round(count(*)*100.0/(select count(*) from healthcare),2) as Percentage
from healthcare group by Current_Smokeless_Tobacco;

-- 2 Current smoking by gender --
select Current_Smoker,Gender,count(*) as Total_Respondents from healthcare group by Current_Smoker,Gender;
select Current_Smoker,Gender,count(*) as Total_Respondents,
round(count(*)*100.0/sum(count(*)) over (PARTITION by Gender),2) as Percentage
from healthcare group by Current_Smoker,Gender order by Current_Smoker,Gender;

-- 3 Current smoking by age group --
select Current_Smoker,Age_Group,count(*) as Total_Respondents,
round(count(*)*100.0/sum(count(*)) over (partition by Age_Group),2) as Percentage
from healthcare group by Current_Smoker,Age_Group 
order by Age_Group ,Current_Smoker;

-- 4 Current smokeless tobacco use by gender --
select Gender,Current_Smokeless_Tobacco,count(*) as Total_Respondents,
round(count(*)*100.0/sum(count(*)) over (partition by Gender),2 ) as percentage from healthcare
group by Gender,Current_Smokeless_Tobacco order by Gender,Current_Smokeless_Tobacco;

-- 5 Current smokeless tobacco use by age group --
select Age_Group,Current_Smokeless_Tobacco,count(*) as Total_Respondents,
round(count(*)*100.0/sum(count(*)) over (partition by Age_Group),2) as percentage
from healthcare group by Age_Group,Current_Smokeless_Tobacco order by Age_Group,Current_Smokeless_Tobacco;

-- 6 Current smoking by education level --
select Current_Smoker,Education_Level,count(*) as Total_Respondents
,round(count(*)*100.0/sum(count(*)) over (partition by Education_Level),2) as percentage
from healthcare group by Education_Level,Current_Smoker order by Education_Level,Current_Smoker;

-- 7 Current smoking by work status --
SELECT Work_Status,Current_Smoker,COUNT(*) AS Total_Respondents,
ROUND(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER (PARTITION BY Work_Status),2) AS Percentage
FROM healthcare GROUP BY Work_Status, Current_Smoker ORDER BY Work_Status, Current_Smoker;

-- 8 Current smokeless tobacco use by education level--
SELECT Education_Level,Current_Smokeless_Tobacco,count(*) as Total_Respondents,
round(count(*)*100.0/sum(count(*)) over (partition by Education_Level),2) as percentage
from healthcare group by Education_Level,Current_Smokeless_Tobacco 
order by Education_Level,Current_Smokeless_Tobacco;

-- 9 Current smokeless tobacco use by work status --
SELECT Work_Status,Current_Smokeless_Tobacco,COUNT(*) AS Total_Respondents,
ROUND(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER (PARTITION BY Work_Status),2) AS Percentage
FROM healthcare GROUP BY Work_Status, Current_Smokeless_Tobacco 
ORDER BY Work_Status, Current_Smokeless_Tobacco;
select * from healthcare limit 5;

-- 10 Smoking Status vs Home Smoking Rules --
select Smoking_Status,Home_Smoking_Rules,count(*),
round(count(*)*100.0/sum(count(*)) over (partition by Smoking_Status),2) as percentage
from healthcare group by Smoking_Status,Home_Smoking_Rules order by Smoking_Status,Home_Smoking_Rules;

-- 11 Smoking Status vs Lung Cancer Awareness yes(1) no(2)--
SELECT Smoking_Status,Smoking_Causes_Lung_Cancer,COUNT(*) AS Total_Respondents,
ROUND(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER (PARTITION BY Smoking_Status),2) AS Percentage
FROM healthcare GROUP BY Smoking_Status, Smoking_Causes_Lung_Cancer
ORDER BY Smoking_Status, Smoking_Causes_Lung_Cancer;

-- 12 Average,MIN,MAX age at which respondents started smoking--
select round(avg(Age_First_Smoking),2) as avg_age,
min(Age_First_Smoking) as min_age,max(Age_First_Smoking) as max_age
from healthcare where Age_First_Smoking is not null;

-- 13 Average,MIN,MAX age at First Smokeless Tobacco Use --
SELECT ROUND(AVG(Age_First_Smokeless_Tobacco), 2) AS Average_Age_First_Smokeless_Tobacco,
MIN(Age_First_Smokeless_Tobacco) AS Minimum_Age,
MAX(Age_First_Smokeless_Tobacco) AS Maximum_Age
FROM healthcare WHERE Age_First_Smokeless_Tobacco IS NOT NULL;

-- 14 Current Smoking by Residence--
SELECT Residence_Type,Current_Smoker,
COUNT(*) AS Total_Respondents,
ROUND(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER (PARTITION BY Residence_Type),2) AS Percentage
FROM healthcare GROUP BY Residence_Type, Current_Smoker
ORDER BY Residence_Type, Current_Smoker;

-- 15 Current Smokeless Tobacco Use by Residence--
SELECT Residence_Type,Current_Smokeless_Tobacco,COUNT(*) AS Total_Respondents,
ROUND(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER (PARTITION BY Residence_Type),2) AS Percentage
FROM healthcare GROUP BY Residence_Type, Current_Smokeless_Tobacco
ORDER BY Residence_Type, Current_Smokeless_Tobacco;
-- 16 Current Smoking by Region --
SELECT Region_ID,Current_Smoker,
COUNT(*) AS Total_Respondents,
ROUND(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER (PARTITION BY Region_ID),2) AS Percentage
FROM healthcare GROUP BY Region_ID, Current_Smoker
ORDER BY Region_ID, Current_Smoker;

-- 17 Current Smokeless Tobacco Use by Region --
SELECT Region_ID,Current_Smokeless_Tobacco,
COUNT(*) AS Total_Respondents,
ROUND(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER (PARTITION BY Region_ID),2) AS Percentage
FROM healthcare
GROUP BY Region_ID, Current_Smokeless_Tobacco
ORDER BY Region_ID, Current_Smokeless_Tobacco;

-- 18 Current Smoking by State --
SELECT State_ID,Current_Smoker,COUNT(*) AS Total_Respondents,
ROUND(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER (PARTITION BY State_ID),2) AS Percentage
FROM healthcare
GROUP BY State_ID, Current_Smoker
ORDER BY State_ID, Current_Smoker;

-- 19 Current Smokeless Tobacco Use by State--
SELECT State_ID,Current_Smokeless_Tobacco,COUNT(*) AS Total_Respondents,
ROUND(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER (PARTITION BY State_ID),2) AS Percentage
FROM healthcare
GROUP BY State_ID, Current_Smokeless_Tobacco
ORDER BY State_ID, Current_Smokeless_Tobacco;

-- 20 Current Smoking by Gender and Residence --
select Gender,Current_Smoker,Residence_Type,count(*) as Total_Respondents,
round(count(*)*100.0/sum(count(*)) over (partition by Gender,Residence_Type),2) as percentage
from healthcare
group by Gender,Current_Smoker,Residence_Type
order by Gender,Current_Smoker,Residence_Type;

-- 21 Current Smokeless Tobacco Use by Gender and Residence --
select Gender,Current_Smokeless_Tobacco,Residence_Type,count(*) as Total_Respondents,
round(count(*)*100.0/sum(count(*)) over (partition by Gender,Residence_Type),2) as percentage
from healthcare
group by Gender,Current_Smokeless_Tobacco,Residence_Type
order by Gender,Current_Smokeless_Tobacco,Residence_Type;

-- 22 Current Smoking by Age Group and Gender --
select Age_Group,Gender,Current_Smoker,count(*) as Total_Respondents,
round(count(*)*100.0/sum(count(*)) over (partition by Age_Group,Gender),2) as percentage
from healthcare
group by Age_Group,Gender,Current_Smoker
order by Age_Group,Gender,Current_Smoker;

-- 23 Current Smokeless Tobacco Use by Age Group and Gender--
select Age_Group,Gender,Current_Smokeless_Tobacco,count(*) as Total_Respondents,
round(count(*)*100.0/sum(count(*)) over (partition by Age_Group,Gender),2) as percentage
from healthcare
group by Age_Group,Gender,Current_Smokeless_Tobacco
order by Age_Group,Gender,Current_Smokeless_Tobacco;

-- 24 Current Smoking by Education and Gender--
SELECT Education_Level,Gender,Current_Smoker,
COUNT(*) AS Total_Respondents,
ROUND(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER (PARTITION BY Education_Level, Gender),2) AS Percentage
FROM healthcare
GROUP BY Education_Level, Gender, Current_Smoker
ORDER BY Education_Level, Gender, Current_Smoker;

-- 25 Current Smokeless Tobacco Use by Education and Gender--
SELECT Education_Level,Gender,Current_Smokeless_Tobacco,
COUNT(*) AS Total_Respondents,
ROUND(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER (PARTITION BY Education_Level, Gender),2) AS Percentage
FROM healthcare
GROUP BY Education_Level, Gender, Current_Smokeless_Tobacco
ORDER BY Education_Level, Gender, Current_Smokeless_Tobacco;

-- 26 Current Smoking by Work Status and Gender --
SELECT Work_Status,Gender,Current_Smoker,
COUNT(*) AS Total_Respondents,
ROUND(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER (PARTITION BY Work_Status, Gender),2) AS Percentage
FROM healthcare
GROUP BY Work_Status, Gender, Current_Smoker
ORDER BY Work_Status, Gender, Current_Smoker;

-- 27 Current Smokeless Tobacco Use by Work Status and Gender --
SELECT Work_Status,Gender,Current_Smokeless_Tobacco,
COUNT(*) AS Total_Respondents,
ROUND(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER (PARTITION BY Work_Status, Gender),2) AS Percentage
FROM healthcare
GROUP BY Work_Status, Gender, Current_Smokeless_Tobacco
ORDER BY Work_Status, Gender, Current_Smokeless_Tobacco;

-- 28 Smoking Status vs Age at First Smoking(AVG,MIN,MAX)--
SELECT Smoking_Status,COUNT(Age_First_Smoking) AS Respondents,
ROUND(AVG(Age_First_Smoking), 2) AS Average_Age_First_Smoking,
MIN(Age_First_Smoking) AS Minimum_Age,MAX(Age_First_Smoking) AS Maximum_Age
FROM healthcare
WHERE Age_First_Smoking IS NOT NULL
GROUP BY Smoking_Status ORDER BY Smoking_Status;

-- 29 Smoking Quit Attempts by Gender--
SELECT Gender,Smoking_Quit_Attempt,COUNT(*) AS Total_Respondents,
ROUND(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER (PARTITION BY Gender),2) AS Percentage
FROM healthcare
GROUP BY Gender, Smoking_Quit_Attempt
ORDER BY Gender, Smoking_Quit_Attempt;

-- 30 Smoking Quit Attempts by Current Smoking Status --
SELECT
    Smoking_Status,
    Smoking_Quit_Attempt,
    COUNT(*) AS Total_Respondents,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY Smoking_Status),
        2
    ) AS Percentage
FROM healthcare
GROUP BY Smoking_Status, Smoking_Quit_Attempt
ORDER BY Smoking_Status, Smoking_Quit_Attempt;

-- 31 Healthcare Visits by Current Smoking Status--
SELECT
    Smoking_Status,
    Healthcare_Visits_12M,
    COUNT(*) AS Total_Respondents,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY Smoking_Status),
        2
    ) AS Percentage
FROM healthcare
GROUP BY Smoking_Status, Healthcare_Visits_12M
ORDER BY Smoking_Status, Healthcare_Visits_12M;

-- 32 Healthcare Visits by Current Smoker Status -- 
SELECT
    Current_Smoker,
    Healthcare_Visits_12M,
    COUNT(*) AS Total_Respondents,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY Current_Smoker),
        2
    ) AS Percentage
FROM healthcare
GROUP BY Current_Smoker, Healthcare_Visits_12M
ORDER BY Current_Smoker, Healthcare_Visits_12M;
-- 33 Home Smoking Rules × Current Smoker
SELECT
    Current_Smoker,
    Home_Smoking_Rules,
    COUNT(*) AS Total_Respondents,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY Current_Smoker),
        2
    ) AS Percentage
FROM healthcare
GROUP BY Current_Smoker, Home_Smoking_Rules
ORDER BY Current_Smoker, Home_Smoking_Rules;

-- 34 Tobacco Information Exposure (A) × Current Smoker--
SELECT
    Current_Smoker,
    Tobacco_Info_Notice_A,
    COUNT(*) AS Total_Respondents,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY Current_Smoker),
        2
    ) AS Percentage
FROM healthcare
GROUP BY Current_Smoker, Tobacco_Info_Notice_A
ORDER BY Current_Smoker, Tobacco_Info_Notice_A;

-- 35 Tobacco Information Exposure (B) × Current Smoker
select * from healthcare limit 2;
SELECT
    Current_Smoker,
    Tobacco_Info_Notice_B,
    COUNT(*) AS Total_Respondents,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY Current_Smoker),
        2
    ) AS Percentage
FROM healthcare
GROUP BY Current_Smoker, Tobacco_Info_Notice_B
ORDER BY Current_Smoker, Tobacco_Info_Notice_B;

-- 36 Tobacco Information Exposure — Channel C × Current Smoker--
SELECT
    Current_Smoker,
    Tobacco_Info_Notice_C,
    COUNT(*) AS Total_Respondents,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY Current_Smoker),
        2
    ) AS Percentage
FROM healthcare
GROUP BY Current_Smoker, Tobacco_Info_Notice_C
ORDER BY Current_Smoker, Tobacco_Info_Notice_C;

-- 37 Health Awareness(Include all) × Current Smoker --
SELECT
    Current_Smoker,
    ROUND(AVG(Smoking_Causes_Stroke = 1) * 100, 2) AS Stroke_Yes_Percentage,
    ROUND(AVG(Smoking_Causes_Heart_Attack = 1) * 100, 2) AS Heart_Attack_Yes_Percentage,
    ROUND(AVG(Smoking_Causes_Lung_Cancer = 1) * 100, 2) AS Lung_Cancer_Yes_Percentage,
    ROUND(AVG(Smoking_Causes_Chronic_Cough_TB = 1) * 100, 2) AS Chronic_Cough_TB_Yes_Percentage
FROM healthcare
GROUP BY Current_Smoker
ORDER BY Current_Smoker;