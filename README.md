# Shell Upstream Performance & Emissions Command Center

An interactive **Microsoft Power BI analytics solution** for analyzing upstream oil & gas production, operations, financial performance, emissions, decarbonization, and strategic scenarios.

> **Industry:** Oil & Gas — Upstream  
> **Primary BI Platform:** Microsoft Power BI  
> **Database:** MySQL  
> **ETL / Data Preparation:** Power Query  
> **Dashboard Pages:** 5

---

## 1. Project Title

**Shell Upstream Performance & Emissions Command Center**

A professional Power BI command center designed to bring upstream production, operational performance, financial results, emissions, decarbonization targets, and scenario analysis into one interactive management view.

---

## 2. Project Overview

The **Shell Upstream Performance & Emissions Command Center** provides a consolidated analytical view of upstream business performance.

The dashboard covers five major analytical areas:

1. **Executive Overview** — management-level summary of production, finance, and emissions.
2. **Production & Operations** — production, assets, downtime, maintenance, and operational cost.
3. **Financial Performance** — revenue, cost, margin, regional and segment performance, and Brent-price context.
4. **Emissions & Decarbonization** — Scope 1, Scope 2, Scope 3, regional emissions, targets, and emissions composition.
5. **Scenario Analysis** — comparison of oil-price, production-growth, revenue, emissions, and renewable-share assumptions.

The solution is intended to support management, operations, finance, sustainability, and planning teams.

---

## 3. Project Objectives

- Build a centralized management dashboard for upstream performance.
- Monitor production trends by time, region, and asset.
- Analyze downtime and maintenance performance.
- Evaluate revenue, cost, margin, and profitability.
- Provide Brent-price context for financial analysis.
- Monitor Scope 1, Scope 2, and Scope 3 emissions.
- Compare emissions against reduction targets.
- Identify high-emitting and high-downtime assets.
- Evaluate alternative business scenarios.
- Present complex business information through interactive Power BI visuals.
- Support data-driven operational, financial, environmental, and strategic decision-making.

---

## 4. Tools & Technologies

| Tool / Technology | Purpose |
|---|---|
| **MySQL** | Database layer for storing and organizing project data |
| **Microsoft Power BI** | Dashboard development, visualization, and business intelligence |
| **Power Query** | Data extraction, transformation, cleaning, validation, and loading |
| **DAX** | KPI calculations and reusable analytical measures |
| **Power BI Visuals** | KPI cards, line charts, bar charts, composition charts, tables, and scenario visuals |
| **Filters & Slicers** | Interactive analysis by scenario, year, region, asset, segment, and related dimensions |

---

## 5. Dataset Description

The dataset represents upstream business information required to analyze:

### Production
- Production volumes
- Monthly production trends
- Regional production
- Asset-level production

### Operations & Maintenance
- Downtime hours
- Maintenance categories
- Downtime by asset
- Maintenance cost
- Maintenance type

### Finance
- Revenue
- Cost
- Margin
- Margin percentage
- Segment revenue
- Regional revenue
- Brent price

### Emissions
- Total emissions
- Scope 1 emissions
- Scope 2 emissions
- Scope 3 emissions
- Regional emissions
- Asset emissions
- Emission intensity
- Reduction targets

### Scenario Analysis
- Oil price assumptions
- Production growth
- Revenue growth
- Expected production
- Expected revenue
- Expected emissions
- Renewable share

### Time
- Month
- Year
- Time-based trend analysis

**Data-source note:** The supplied project documentation does not specify the exact external source-system names, database server, database name, physical file locations, or refresh architecture. These details are therefore not assumed in this README.

---

## 6. SQL Analysis

MySQL is used as the structured database layer of the project. The database organizes the business information into logical analytical areas before the data is consumed by Power BI.

### Logical Data Areas

- Production Data
- Operations / Maintenance Data
- Financial Data
- Emissions Data
- Emissions Target Data
- Scenario Data
- Date / Calendar Data

### SQL Analysis Goals

SQL/database preparation supports:

- Organizing production records.
- Managing operational and maintenance information.
- Structuring financial data.
- Storing emissions and target information.
- Managing scenario assumptions.
- Preparing time-based analytical data.
- Providing structured data for Power BI ETL and modeling.

> The supplied documentation does not provide the exact physical MySQL table names, so this README intentionally uses the documented logical data areas rather than inventing table names.

---

## 7. Power BI Dashboard

The Power BI report contains **five interactive dashboard pages**.

### Page 1 — Executive Overview

**Purpose:** Provide a management-level snapshot of production, finance, and emissions.

**Main visuals:**
- Total Production
- Total Revenue
- Total Margin
- Total Cost
- Total Emissions
- Emission Intensity
- Monthly Emissions Trend
- Monthly Production Trend
- Production by Region
- Emissions by Scope

### Page 2 — Production & Operations

**Purpose:** Analyze production, asset contribution, downtime, maintenance, and operational cost.

**Main visuals:**
- Total Production
- Average Production
- Total Downtime Hours
- Production by Region
- Production Trend
- Top Production Assets
- Top 10 Assets by Downtime
- Downtime by Maintenance Type
- Maintenance Cost by Type

### Page 3 — Financial Performance

**Purpose:** Analyze revenue, cost, margin, regional/segment performance, and Brent-price context.

**Main visuals:**
- Total Revenue
- Total Cost
- Total Margin
- Margin %
- Average Brent Price
- Revenue vs Cost Trend
- Margin Trend
- Revenue by Segment
- Revenue by Region
- Revenue vs Brent Price

### Page 4 — Emissions & Decarbonization

**Purpose:** Monitor emissions, emissions composition, regional emissions, targets, and decarbonization priorities.

**Main visuals:**
- Total Emissions
- Total Scope 1
- Total Scope 2
- Total Scope 3
- Emission Intensity
- Reduction Target
- Emissions Trend by Scope
- Emissions by Region
- Scope 1 Actual vs Target
- Top 10 Assets by Emissions
- Emissions Composition

### Page 5 — Scenario Analysis

**Purpose:** Compare alternative assumptions and understand trade-offs between oil price, production growth, revenue, emissions, and renewable share.

**Main visuals:**
- Oil Price by Scenario
- Emissions by Scenario
- Renewable Share % by Scenario
- Expected Revenue by Scenario
- Expected Emissions by Scenario
- Scenario Summary
- Expected Production
- Expected Revenue
- Expected Emissions

---

## 8. Key KPIs

The dashboard includes the following major KPIs.

| KPI | Documented Value / Purpose |
|---|---|
| **Total Production** | ~951.1M |
| **Total Revenue** | ~109.1bn |
| **Total Margin** | ~55.5bn |
| **Total Cost** | ~53.6bn |
| **Total Emissions** | ~106.0M |
| **Emission Intensity** | 0.11 |
| **Average Brent Price** | ~79.42 |
| **Total Scope 1** | ~21.7M |
| **Total Scope 2** | ~7.4M |
| **Total Scope 3** | ~76.9M |
| **Reduction Target** | 12.0% |
| **Expected Production — Scenario** | ~1027M |
| **Expected Revenue — Scenario** | ~117.8bn |
| **Expected Emissions — Scenario** | ~116.8M |
| **Selected Oil Price — Scenario** | 95 |
| **Selected Production Growth — Scenario** | 8% |

Values above represent the documented dashboard state and may change when different filters or scenarios are selected.

---

## 9. Key Insights

### Operational Insights

- Europe is the highest displayed production region at approximately **204M**.
- Production varies by month, making trend monitoring useful for identifying peaks and low-output periods.
- Corrective maintenance is a major downtime category and the highest displayed maintenance-cost category.
- High-downtime assets can be prioritized for reliability improvement and root-cause analysis.

### Financial Insights

- Displayed total revenue is approximately **109.05bn**.
- Displayed total margin is approximately **55.50bn**.
- Revenue is distributed across multiple business segments and regions.
- Brent price provides useful context for interpreting upstream revenue movements.
- Revenue and margin should be monitored together because revenue growth does not automatically imply stronger profitability.

### Emissions Insights

- Displayed total emissions are approximately **106.0M**.
- **Scope 3** is the largest displayed emissions component at approximately **76.9M**.
- High-emitting assets can be prioritized for emissions-reduction investigations.
- Actual-versus-target analysis supports environmental performance monitoring.

### Strategic Insights

- The **Growth Scenario** has the highest displayed production growth at **8%**.
- **Accelerated Transition** has the highest displayed renewable share at **30%**.
- Scenario comparison makes strategic trade-offs visible.
- Scenario results should be treated as planning comparisons rather than guaranteed forecasts.

---

## 10. Project Workflow

```text
Business Requirement Identification
            ↓
Dataset Preparation
            ↓
MySQL Database Layer
            ↓
MySQL → Power BI Connection
            ↓
Power Query / ETL
            ↓
Data Cleaning & Validation
            ↓
Data Modeling & Relationships
            ↓
DAX KPI Development
            ↓
Dashboard Design
            ↓
Filters, Slicers & Navigation
            ↓
Dashboard Validation
            ↓
Business Insights
            ↓
Final Documentation & Presentation
```

### Workflow Explanation

1. Identify business requirements and management questions.
2. Prepare production, operations, finance, emissions, target, scenario, and date information.
3. Organize the information in MySQL.
4. Connect MySQL with Power BI.
5. Extract and transform data using Power Query.
6. Clean and validate the data.
7. Build the analytical data model and relationships.
8. Create reusable DAX measures.
9. Build five Power BI dashboard pages.
10. Add filters, slicers, tooltips, and page navigation.
11. Validate KPI values, totals, interactions, and readability.
12. Interpret operational, financial, environmental, and strategic insights.

---

## 11. Repository Structure

A recommended GitHub repository structure is:

```text
Shell-Upstream-Performance-Emissions-Command-Center/
│
├── README.md
│
├── Dashboard/
│   └── Shell_Upstream_Performance_Emissions.pbix
│
├── SQL/
│   ├── database_schema.sql
│   ├── data_loading.sql
│   └── analysis_queries.sql
│
├── Data/
│   ├── Production/
│   ├── Operations/
│   ├── Finance/
│   ├── Emissions/
│   ├── Targets/
│   ├── Scenarios/
│   └── Calendar/
│
├── Documentation/
│   └── Shell_Upstream_Performance_Emissions_Command_Center_Documentation.docx
│
├── Screenshots/
│   ├── executive-overview.png
│   ├── production-operations.png
│   ├── financial-performance.png
│   ├── emissions-decarbonization.png
│   └── scenario-analysis.png
│
└── Assets/
    └── dashboard-assets/
```

> Replace filenames with the actual files used in your final GitHub repository.

---

## 12. Dashboard Screenshots

Add the five exported dashboard screenshots to the `Screenshots/` folder and use the following Markdown in GitHub:

### Executive Overview

```markdown
![Uploading Executive Overview.png…]()
```

### Production & Operations

```markdown
<img width="872" height="486" alt="Production   Operations" src="https://github.com/user-attachments/assets/cccbc8c6-11db-4018-bc75-e9f842b4bfe2" />

```

### Financial Performance

```markdown
<img width="875" height="486" alt="Financial performance" src="https://github.com/user-attachments/assets/cdc6cdb4-cd5e-4276-965b-b93f88b46f72" />

```

### Emissions & Decarbonization

```markdown
<img width="872" height="493" alt="Emission   Decarbonization" src="https://github.com/user-attachments/assets/9a508ff3-e30e-4348-b69b-c94c56e90bd9" />

```

### Scenario Analysis

```markdown
<img width="875" height="491" alt="scenario_analysis" src="https://github.com/user-attachments/assets/1a854ef2-597c-4f18-aa27-5814af50fd3a" />

```

**Note:** The supplied documentation describes the five dashboard pages but does not contain separate screenshot image files. Therefore, the README provides ready-to-use screenshot paths rather than inventing image files.

---

## 13. How to Run the Project

### Prerequisites

Install or have access to:

- MySQL
- MySQL Workbench
- Microsoft Power BI Desktop
- Power Query through Power BI
- Required project dataset files
- The project `.pbix` file, if available

### Step 1 — Set Up MySQL

Create the required database and load the project data into the appropriate logical data areas.

```sql
CREATE DATABASE <database_name>;
USE <database_name>;
```

Use the actual database name and SQL scripts from the project repository.

### Step 2 — Load the Dataset

Load the production, operations, financial, emissions, target, scenario, and calendar data into MySQL.

Validate:

- Data types
- Missing values
- Duplicate records
- Category consistency
- Date fields
- Numeric values
- Important totals

### Step 3 — Connect MySQL to Power BI

1. Open **Power BI Desktop**.
2. Select the **MySQL database connector**.
3. Enter the MySQL server and database details.
4. Authenticate using the required credentials.
5. Select the required project data.
6. Load the data into **Power Query**.

### Step 4 — Perform ETL

Use Power Query to:

- Clean column names.
- Set correct data types.
- Handle blanks and invalid values.
- Standardize categories.
- Validate dates.
- Validate totals.
- Prepare tables for modeling.

### Step 5 — Build the Data Model

Create the required relationships between the prepared tables and establish the analytical structure required by the dashboard.

### Step 6 — Create DAX Measures

Create the documented KPI calculations such as:

```DAX
Total Production =
SUM(Production[Production])
```

```DAX
Total Revenue =
SUM(Finance[Revenue])
```

```DAX
Total Cost =
SUM(Finance[Cost])
```

```DAX
Total Margin =
[Total Revenue] - [Total Cost]
```

```DAX
Margin % =
DIVIDE([Total Margin], [Total Revenue], 0)
```

```DAX
Total Emissions =
SUM(Emissions[Emissions])
```

```DAX
Average Brent Price =
AVERAGE(Finance[Brent Price])
```

> These are documentation-level examples. Replace table and column names with the actual names in your Power BI model.

### Step 7 — Open the Dashboard

Open the `.pbix` file in Power BI Desktop.

Check:

- KPI values
- Filters
- Slicers
- Page navigation
- Visual interactions
- Tooltips
- Relationships
- Formatting
- Dashboard readability

### Step 8 — Analyze the Dashboard

Use the five report pages to move from executive-level KPIs to detailed operational, financial, emissions, and scenario analysis.

---

## 14. Filters & Slicers

The documented dashboard contains:

- **Scenario slicer** on the Scenario Analysis page.
- **Year slicer** on the Emissions & Decarbonization page.
- Region, asset, and segment are used within report visuals and can participate in visual cross-filtering.
- Tooltips provide additional detail.
- Left-side navigation buttons move between the five pages.

---

## 15. Business Value

The project demonstrates how business intelligence can combine operational, financial, environmental, and strategic data into a single decision-support environment.

The dashboard enables users to:

- Monitor production performance.
- Identify operational bottlenecks.
- Investigate downtime and maintenance.
- Evaluate revenue and profitability.
- Monitor emissions performance.
- Compare emissions with targets.
- Identify high-emission assets.
- Evaluate alternative scenarios.
- Support data-driven planning and management decisions.

---

## 16. Future Enhancements

Potential future improvements include:

- Automated data refresh.
- Data-quality monitoring.
- Drill-through asset analysis.
- Deeper Scope 3 emissions analysis.
- Multi-year emissions target tracking.
- Side-by-side scenario comparison.
- More detailed reliability analytics.
- Automated alerts for critical KPI changes.

---

## 17. Author

**Completed by:** sridhar.P

**Project:** Shell Upstream Performance & Emissions Command Center  
**Industry:** Oil & Gas — Upstream  
**Primary Tool:** Microsoft Power BI  
**Database:** MySQL  
**Focus Areas:** Operations, Finance, Emissions & Decarbonization, Scenario Planning

---

## 18. Conclusion

The **Shell Upstream Performance & Emissions Command Center** demonstrates an end-to-end Business Intelligence workflow connecting database organization, ETL, data cleaning, data modeling, DAX, dashboard design, interactive filtering, and business insight generation.

The solution brings upstream operations, financial performance, environmental performance, and strategic scenario analysis into one interactive Power BI report, enabling users to move from high-level KPIs to detailed analysis and forward-looking planning.

---

## Project at a Glance

| Item | Details |
|---|---|
| Project | Shell Upstream Performance & Emissions Command Center |
| Industry | Oil & Gas — Upstream |
| BI Platform | Microsoft Power BI |
| Database | MySQL |
| ETL | Power Query / Power BI ETL |
| Dashboard Pages | 5 |
| Core Domains | Operations, Finance, Emissions & Decarbonization, Scenario Planning |
| Primary Audience | Management, Operations, Finance, Sustainability & Planning Teams |
