# Shell Upstream Performance & Emissions Command Center

> **An end-to-end analytics project for monitoring upstream production, financial performance, emissions, asset reliability, and business scenarios through a structured data model and interactive dashboard.**

**Completed by:** Sridhar P

---

## 📌 Project Overview

The **Shell Upstream Performance & Emissions Command Center** is a data analytics and business intelligence project designed to bring key upstream operational, financial, sustainability, and maintenance metrics into a single analytical framework.

The project combines a structured **MySQL data model**, data-quality and consolidation workflows, and an interactive dashboard experience to support performance monitoring and management-level decision making.

The database is organized around production, financial, emissions, maintenance, crude-oil pricing, asset, date, target, and scenario data.

---

## 🎯 Business Objective

The primary objective is to create a centralized performance command center that helps stakeholders:

- Monitor daily and historical upstream production.
- Evaluate revenue, cost, margin, and revenue-per-BOE performance.
- Track Scope 1, Scope 2, and Scope 3 emissions.
- Monitor emissions intensity and emissions performance.
- Analyze maintenance activity, downtime, cost, and priority.
- Compare asset and regional performance.
- Track sustainability targets and reduction objectives.
- Evaluate business scenarios involving oil price, production growth, renewable share, emissions factors, and maintenance efficiency.
- Identify operational and financial areas that may require management attention.

---

## 🏗️ Solution Architecture

```text
                    ┌─────────────────────────────┐
                    │        Source Data          │
                    │ Production / Finance /      │
                    │ Emissions / Maintenance /   │
                    │ Prices / Targets / Scenarios│
                    └──────────────┬──────────────┘
                                   │
                                   ▼
                    ┌─────────────────────────────┐
                    │       MySQL Database        │
                    │     shell_upstream_db       │
                    └──────────────┬──────────────┘
                                   │
                    ┌──────────────┴──────────────┐
                    ▼                             ▼
          ┌───────────────────┐         ┌────────────────────┐
          │ Data Quality &    │         │ Analytical Data    │
          │ Validation        │         │ Model              │
          │                   │         │                    │
          │ • Duplicates      │         │ • Dimensions       │
          │ • NULL checks     │         │ • Fact tables      │
          │ • Keys & indexes  │         │ • KPI calculations │
          │ • Reconciliation  │         │ • Targets          │
          └─────────┬─────────┘         └──────────┬─────────┘
                    │                              │
                    └──────────────┬───────────────┘
                                   ▼
                    ┌─────────────────────────────┐
                    │   Interactive BI Dashboard   │
                    │                               │
                    │ Production | Finance |       │
                    │ Emissions | Maintenance |    │
                    │ Assets | Scenarios           │
                    └──────────────┬──────────────┘
                                   │
                                   ▼
                    ┌─────────────────────────────┐
                    │     Business Insights       │
                    │ Performance | Risk | Cost |  │
                    │ Sustainability | Operations  │
                    └─────────────────────────────┘
```

---

## 🗄️ Database Design

The project uses the database:

```sql
shell_upstream_db
```

The schema follows a dimensional/star-schema-oriented structure with dedicated dimension and fact tables.

### Dimension Tables

| Table | Purpose |
|---|---|
| `dim_date` | Calendar attributes including day, month, quarter, year, year-month, and weekend indicator |
| `dim_asset` | Asset master data including region, segment, asset type, baseline production, operational efficiency, and risk |
| `dim_targets` | Annual Scope 1/2/3 targets, emission-intensity targets, and reduction targets |
| `dim_scenario` | Scenario assumptions such as oil price, production growth, renewable share, emission-factor change, and maintenance-efficiency change |

### Fact Tables

| Table | Purpose |
|---|---|
| `fact_production` | Daily production measured in BOE/day with production status |
| `fact_prices` | Daily Brent crude price and price band |
| `fact_financial` | Revenue, cost, margin, margin percentage, and revenue per BOE |
| `fact_emissions` | Scope 1, Scope 2, Scope 3, total emissions, and emission intensity |
| `fact_maintenance` | Maintenance activity, planned/unplanned status, downtime, cost, and priority |

The SQL schema establishes relationships between the fact tables and the date/asset dimensions using foreign keys and supporting indexes.

---

## 📊 Core KPIs

The data model supports the following major KPI categories.

### 🛢️ Production KPIs

- Production (BOE/day)
- Production by asset
- Production by region
- Production by segment
- Production status
- Baseline production comparison

### 💰 Financial KPIs

- Revenue (USD)
- Cost (USD)
- Margin (USD)
- Margin %
- Revenue per BOE (USD/BOE)
- Financial performance by asset
- Financial performance by region and segment

### 🌱 Emissions KPIs

- Scope 1 emissions
- Scope 2 emissions
- Scope 3 emissions
- Total emissions
- Emission intensity (tCO₂e/BOE)
- Emissions performance
- Annual emissions targets
- Reduction target %

### 🔧 Maintenance KPIs

- Downtime hours
- Maintenance cost
- Maintenance type
- Planned vs unplanned maintenance
- Maintenance priority
- Maintenance activity by asset

### 🛢️ Market KPIs

- Brent crude price (USD/bbl)
- Price band
- Production and financial performance in relation to oil-price conditions

### 🔮 Scenario KPIs

The scenario model supports analysis using:

- Oil price assumptions
- Production growth %
- Renewable share %
- Emission-factor change %
- Maintenance-efficiency change %
- Scenario descriptions

---

## 🧹 Data Quality & Transformation

A significant part of the SQL workflow focuses on improving analytical data quality before dashboard consumption.

### Duplicate Detection

Duplicate records are checked using business-level keys such as:

```text
Production:
date + asset_id

Financial:
date + asset_id + region + segment

Maintenance:
date + asset_id + maintenance_type + planned_unplanned
```

### Production Consolidation

Duplicate production records are consolidated at the `date + asset_id` level, using the average production value and retaining a representative production status.

### Financial Consolidation

Financial duplicates are consolidated by:

```text
date + asset_id + region + segment
```

Revenue, cost, and margin are aggregated, while derived metrics such as margin percentage and revenue per BOE are recalculated.

### Validation Checks

The SQL workflow also includes checks for:

- Duplicate records
- NULL values
- Unique IDs
- Row counts
- Revenue/cost/margin reconciliation
- Data types and numeric precision
- Primary keys
- Indexes
- Old vs. new data totals

This provides a controlled data-preparation layer before analytics and dashboard reporting.

---

## 📈 Dashboard

The project includes an interactive dashboard designed around management-oriented performance monitoring.

The dashboard brings together:

- Production performance
- Financial performance
- Emissions and sustainability metrics
- Maintenance and operational reliability
- Asset/region/segment analysis
- Scenario-based performance evaluation

### Typical Dashboard Interactions

The analytical model is designed to support filtering and comparison by dimensions such as:

- Date
- Year
- Month
- Quarter
- Asset
- Region
- Segment
- Asset type
- Risk
- Price band
- Emissions performance
- Maintenance priority
- Scenario

> **Note:** Dashboard screenshots and the BI implementation are maintained separately from the SQL database script in the project repository.

---

## 💡 Business Questions Addressed

The solution is designed to help answer questions such as:

1. Which assets are contributing the most to production?
2. Which regions or segments are delivering stronger financial performance?
3. How are revenue, cost, and margin changing over time?
4. What is the revenue generated per BOE?
5. Which assets have higher emissions intensity?
6. How do Scope 1, Scope 2, and Scope 3 emissions contribute to total emissions?
7. Are emissions performance and intensity aligned with annual targets?
8. Which assets experience higher maintenance downtime?
9. What is the financial impact of maintenance activity?
10. How does oil price influence production and financial performance?
11. How could different business scenarios affect production and emissions?
12. Which assets or operational areas may require closer management attention?

---

## 🛠️ Technology Stack

| Technology | Usage |
|---|---|
| **MySQL** | Database creation, schema design, data validation, transformation, and consolidation |
| **SQL** | Data cleaning, aggregation, KPI preparation, validation, and database management |
| **BI Dashboard** | Interactive visualization and business analysis |
| **GitHub** | Version control and project documentation |

---

## 📁 Recommended Repository Structure

```text
shell-upstream-performance-emissions-command-center/
│
├── README.md
│
├── sql/
│   └── shell_upstream_performance_emissions_command_center.sql
│
├── dashboard/
│   ├── dashboard_file/
│   └── screenshots/
│
├── documentation/
│   └── project_documentation.md
│
└── assets/
    └── images/
```

---

## 🚀 How to Run the SQL Project

### 1. Clone the repository

```bash
git clone <your-repository-url>
cd shell-upstream-performance-emissions-command-center
```

### 2. Open MySQL

Use MySQL Workbench, MySQL CLI, or another compatible SQL client.

### 3. Execute the SQL script

Run:

```text
sql/shell_upstream_performance_emissions_command_center.sql
```

The script creates:

```text
shell_upstream_db
```

and defines the project's dimensions, fact tables, validation workflows, transformations, and indexes.

### 4. Verify the database

```sql
USE shell_upstream_db;

SHOW TABLES;
```

You can then validate the primary analytical tables using:

```sql
SELECT COUNT(*) FROM fact_production;
SELECT COUNT(*) FROM fact_financial;
SELECT COUNT(*) FROM fact_emissions;
SELECT COUNT(*) FROM fact_maintenance;
```

---

## 🔍 Data Governance & Reliability

The project emphasizes analytical reliability by incorporating:

- Relational constraints
- Foreign keys
- Primary keys
- Supporting indexes
- Duplicate detection
- Duplicate consolidation
- NULL validation
- Row-count reconciliation
- Financial total reconciliation
- Data-type validation
- Derived KPI recalculation

This helps ensure that dashboard metrics are based on a controlled and consistent analytical dataset.

---

## 📌 Project Highlights

### Data Engineering

- Designed a structured upstream analytics database.
- Created fact and dimension tables.
- Implemented relational constraints and indexes.
- Performed duplicate-record analysis and consolidation.
- Added data-quality validation checks.

### Business Intelligence

- Structured the data model around operational and management KPIs.
- Enabled production, finance, emissions, maintenance, asset, and scenario analysis.
- Prepared data for interactive dashboard reporting.

### Sustainability Analytics

- Incorporated Scope 1, Scope 2, and Scope 3 emissions.
- Included emission-intensity monitoring.
- Added annual emissions targets and reduction targets.
- Included scenario variables related to renewable share and emission factors.

### Operational Analytics

- Included maintenance downtime and maintenance cost.
- Differentiated planned and unplanned maintenance.
- Included maintenance priority and asset-level analysis.

---

## ⚠️ Important Note

This repository is a **portfolio/project implementation** intended to demonstrate database design, SQL data engineering, business intelligence, KPI modeling, and analytical storytelling.

It should not be interpreted as an official Shell corporate reporting system or as a source of verified Shell operational data.

---

## 👤 Author

**Sridhar P**

Data Analytics | SQL | Business Intelligence | Dashboard Development

---

## ⭐ Project Focus

```text
Operational Performance
        +
Financial Performance
        +
Emissions & Sustainability
        +
Maintenance & Reliability
        +
Market & Scenario Analysis
        ↓
Upstream Performance Command Center
```

---

## 📜 License

This project is intended for portfolio and educational purposes.

If you reuse or adapt the project structure, please provide appropriate attribution to the original author.

---

**Built by Sridhar P — Shell Upstream Performance & Emissions Command Center**
