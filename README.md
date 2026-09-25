# Adult Tobacco Use & Control in India: GATS 2016

## 📊 Project Overview

This project presents an end-to-end **Data Analytics analysis of adult tobacco use and tobacco-control indicators in India**, using data from the **Global Adult Tobacco Survey (GATS) India 2016** conducted by the World Health Organization (WHO).

The analysis examines patterns in **smoking and smokeless tobacco use** across demographic and geographic groups, along with tobacco-control practices, health-risk awareness, tobacco information exposure, and age at tobacco initiation.

The project demonstrates a complete analytics workflow from **data cleaning and exploratory analysis to SQL analysis and interactive Power BI dashboard development**.

---

## 🎯 Objectives

The main objectives of this project are to:

* Analyze current smoking and smokeless tobacco use among adult respondents.
* Examine tobacco-use patterns across gender, age, education, occupation, residence, and region.
* Analyze tobacco-control indicators such as home smoking rules.
* Explore awareness of health risks associated with smoking.
* Analyze reported age at first smoking and smokeless tobacco use.
* Use SQL to perform structured analysis and extract key insights.
* Build an interactive Power BI dashboard to communicate findings effectively.

---

## 🗂️ Dataset

**Source:** World Health Organization (WHO) — Global Adult Tobacco Survey (GATS)

**Dataset:** GATS India 2016
**Reference:** `IND_2016_GATS_v01`
**Records analyzed:** 74,037 adult respondents
**Original variables:** 464

The dataset contains information related to tobacco use, demographics, tobacco-control indicators, health awareness, and other survey characteristics.

> **Note:** The original WHO microdata is not included in this repository due to the data-use and redistribution terms associated with the dataset. The repository contains analysis code, SQL queries, documentation, and permitted project outputs instead.

---

## 🛠️ Tools & Technologies

* **Python**

  * Pandas
  * NumPy
  * Matplotlib
* **MySQL**

  * Data validation
  * SQL querying
  * Aggregation and analysis
* **Power BI**

  * Interactive dashboard
  * DAX measures
  * KPI cards
  * Slicers
  * Data visualization
* **Jupyter Notebook**

---

## 🔄 Project Workflow

### 1. Data Selection & Preparation

The original GATS dataset contained 464 variables. Relevant variables were selected based on the project objectives, resulting in a focused analytical dataset.

The selected data covered:

* Demographic characteristics
* Smoking status
* Smokeless tobacco use
* Tobacco initiation
* Education and work status
* Residence and region
* Tobacco-control indicators
* Health-risk awareness
* Tobacco information exposure
* Survey weights

### 2. Data Cleaning with Python

Python and Pandas were used to prepare the dataset for analysis.

Key cleaning activities included:

* Handling special survey response codes such as "Don't know" and "Refused".
* Converting appropriate special codes to missing values.
* Standardizing categorical values.
* Converting numeric fields to appropriate data types.
* Identifying and handling invalid age-at-initiation records.
* Creating analytical variables such as age groups and current tobacco-use indicators.
* Validating missing values and duplicate records.
* Retaining survey weights for potential weighted analysis.

The final analytical dataset contained **74,037 records and 31 selected fields**.

### 3. Exploratory Data Analysis

Exploratory analysis was performed to understand tobacco-use patterns across different population groups.

The analysis included:

* Smoking by gender
* Smoking by age group
* Smoking by education
* Smoking by work status
* Smoking by residence
* Smoking by region
* Smokeless tobacco use by gender
* Smokeless tobacco use by age group
* Smokeless tobacco use by education
* Smokeless tobacco use by work status
* Home smoking rules
* Health-risk awareness
* Age at first smoking
* Age at first smokeless tobacco use
* Tobacco information exposure
* Quit attempts
* Healthcare visits

### 4. MySQL Analysis

The cleaned analytical data was imported into MySQL for structured querying and validation.

SQL analysis was performed using:

* `SELECT`
* `WHERE`
* `GROUP BY`
* `ORDER BY`
* `COUNT()`
* `AVG()`
* Conditional aggregation
* Percentage calculations
* Multi-dimensional analysis

The SQL analysis was used to examine tobacco-use patterns across demographic, geographic, behavioural, and awareness-related variables.

### 5. Power BI Dashboard

An interactive one-page Power BI dashboard was developed to communicate the analysis.

The dashboard includes:

**KPIs**

* Total Respondents
* Current Smokers
* Current Smoking %
* Current Smokeless Tobacco Users
* Current Smokeless Tobacco %

**Dashboard Sections**

* Smoking Profile
* Smokeless Tobacco Profile
* Demographic & Geographic Patterns
* Tobacco Control & Awareness
* Tobacco Initiation

**Interactive Filters**

* Gender
* Age Group
* Region
* Residence
* Education Level

The dashboard uses DAX measures, KPI cards, slicers, bar charts, line charts, stacked charts, and distribution visuals to present the findings.

---

## 🔍 Key Findings

The analysis identified several descriptive patterns in the GATS India 2016 data:

* Current smoking prevalence varied substantially across gender groups.
* Current smokeless tobacco use also showed differences across gender groups.
* Tobacco-use prevalence varied across age groups, education levels, work-status categories, residence types, and regions.
* Month-to-month demographic and behavioural differences were explored through multiple dimensions of the survey.
* Reported awareness that smoking causes lung cancer was high across the smoking-status groups examined.
* Reported home smoking rules differed across smoking-status groups.
* The average reported age at first starting daily smoking among respondents with valid values was **21.66 years**.
* The average reported age at first starting daily smokeless tobacco use among respondents with valid values was **23.35 years**.

> These findings are descriptive associations from the survey data and should not be interpreted as evidence of causation.

---

## 📈 Dashboard

### Dashboard Title

**Adult Tobacco Use & Control in India: GATS 2016**

### Dashboard Preview

--- PowerbiScreenshot.png

## 📁 Repository Structure

```text
Adult-Tobacco-Use-GATS-India-2016/
│
├── README.md
│
├── HealthcarePandas/
│   └── Healthcare Pandas.ipynb
│
├── sqlhealth/
│   └── Health_tobacco.sql
│
├── HealthcarePowerBI/
│   └── healthpowerbi.pbix
│
└── screenshothealth/
    └── PowerbiScreenshot.png
```

> The repository structure may be adjusted according to the files permitted for publication.

---

## 💡 Skills Demonstrated

This project demonstrates practical experience in:

**Data Analysis:**
Data Cleaning • Data Preparation • Exploratory Data Analysis • Data Validation • Descriptive Analysis

**Python:**
Pandas • NumPy • Matplotlib

**SQL:**
MySQL • Aggregation • Conditional Analysis • Grouping • Percentage Calculations

**Power BI:**
DAX • KPI Development • Interactive Dashboards • Slicers • Data Visualization • Dashboard Design

**Analytical Skills:**
Pattern Identification • Demographic Analysis • Tobacco-Use Analysis • Data Interpretation • Insight Communication

---

## 📚 Data Source & Reference

The dataset was obtained from the **World Health Organization (WHO) NCD Microdata Repository**, Global Adult Tobacco Survey (GATS), India 2016.

**Dataset Reference:** `IND_2016_GATS_v01`

Official data dictionary and dataset documentation should be accessed through the WHO NCD Microdata Repository.

---

## ⚠️ Data Disclaimer

This project is intended for **educational and portfolio purposes**.

The original GATS India 2016 microdata is not redistributed through this repository. Users interested in accessing the underlying dataset should obtain it directly through the appropriate WHO data repository and comply with its applicable terms of use.

---

## 👩‍💻 Author

**Sejal Jain**

Aspiring Data Analyst | Python | SQL | Power BI | Excel

[LinkedIn](https://www.linkedin.com/in/sejal-jain-555350289) • [GitHub](https://github.com/sejaljain2005)
