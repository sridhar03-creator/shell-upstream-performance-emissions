CREATE DATABASE shell_upstream_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

USE shell_upstream_db;

CREATE TABLE dim_date (
    date DATE NOT NULL,
    day TINYINT UNSIGNED NOT NULL,
    month_num TINYINT UNSIGNED NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    quarter CHAR(2) NOT NULL,
    year SMALLINT UNSIGNED NOT NULL,
    yearmonth CHAR(7) NOT NULL,
    is_weekend VARCHAR(40) NOT NULL,

    PRIMARY KEY (date),

    INDEX idx_date_year (year),
    INDEX idx_date_year_month (yearmonth)
) ENGINE=InnoDB;

CREATE TABLE dim_asset (
    asset_id VARCHAR(10) NOT NULL,
    asset_name VARCHAR(100) NOT NULL,
    region VARCHAR(50) NOT NULL,
    segment VARCHAR(50) NOT NULL,
    asset_type VARCHAR(50) NOT NULL,
    baseline_production_boe_d INT UNSIGNED NOT NULL,
    operational_efficiency DECIMAL(5,3) NOT NULL,
    asset_risk VARCHAR(10) NOT NULL,

    PRIMARY KEY (asset_id),

    INDEX idx_asset_region (region),
    INDEX idx_asset_segment (segment),
    INDEX idx_asset_risk (asset_risk)
) ENGINE=InnoDB;

CREATE TABLE fact_production (
    production_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    date DATE NOT NULL,
    asset_id VARCHAR(10) NOT NULL,
    production_boe_d INT UNSIGNED NOT NULL,
    production_status VARCHAR(10) NOT NULL,

    PRIMARY KEY (production_id),

    INDEX idx_production_date (date),
    INDEX idx_production_asset (asset_id),

    CONSTRAINT fk_production_date
        FOREIGN KEY (date)
        REFERENCES dim_date(date),

    CONSTRAINT fk_production_asset
        FOREIGN KEY (asset_id)
        REFERENCES dim_asset(asset_id)
) ENGINE=InnoDB;

CREATE TABLE fact_prices (
    date DATE NOT NULL,
    brent_price_usd_bbl DECIMAL(8,2) NOT NULL,
    price_band VARCHAR(20) NOT NULL,

    PRIMARY KEY (date),

    CONSTRAINT fk_prices_date
        FOREIGN KEY (date)
        REFERENCES dim_date(date)
) ENGINE=InnoDB;

CREATE TABLE fact_financial (
    financial_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    date DATE NOT NULL,
    asset_id VARCHAR(10) NOT NULL,
    region VARCHAR(50) NOT NULL,
    segment VARCHAR(50) NOT NULL,

    revenue_usd DECIMAL(18,2) NOT NULL,
    cost_usd DECIMAL(18,2) NOT NULL,
    margin_usd DECIMAL(18,2) NOT NULL,
    margin_pct DECIMAL(7,2) NOT NULL,
    revenue_per_boe_usd DECIMAL(12,2) NOT NULL,

    PRIMARY KEY (financial_id),

    INDEX idx_financial_date (date),
    INDEX idx_financial_asset (asset_id),
    INDEX idx_financial_region (region),

    CONSTRAINT fk_financial_date
        FOREIGN KEY (date)
        REFERENCES dim_date(date),

    CONSTRAINT fk_financial_asset
        FOREIGN KEY (asset_id)
        REFERENCES dim_asset(asset_id)
) ENGINE=InnoDB;

CREATE TABLE fact_emissions (
    emissions_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    date DATE NOT NULL,
    asset_id VARCHAR(10) NOT NULL,
    region VARCHAR(50) NOT NULL,

    scope1_tco2e DECIMAL(14,2) NOT NULL,
    scope2_tco2e DECIMAL(14,2) NOT NULL,
    scope3_tco2e DECIMAL(14,2) NOT NULL,
    total_emissions_tco2e DECIMAL(14,2) NOT NULL,

    emission_intensity_tco2e_per_boe DECIMAL(10,5) NOT NULL,
    emissions_performance VARCHAR(10) NOT NULL,

    PRIMARY KEY (emissions_id),

    INDEX idx_emissions_date (date),
    INDEX idx_emissions_asset (asset_id),
    INDEX idx_emissions_region (region),

    CONSTRAINT fk_emissions_date
        FOREIGN KEY (date)
        REFERENCES dim_date(date),

    CONSTRAINT fk_emissions_asset
        FOREIGN KEY (asset_id)
        REFERENCES dim_asset(asset_id)
) ENGINE=InnoDB;

CREATE TABLE fact_maintenance (
    maintenance_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    date DATE NOT NULL,
    asset_id VARCHAR(10) NOT NULL,

    maintenance_type VARCHAR(20) NOT NULL,
    planned_unplanned VARCHAR(15) NOT NULL,

    downtime_hours DECIMAL(10,2) NOT NULL,
    maintenance_cost_usd DECIMAL(18,2) NOT NULL,

    maintenance_priority VARCHAR(10) NOT NULL,

    PRIMARY KEY (maintenance_id),

    INDEX idx_maintenance_date (date),
    INDEX idx_maintenance_asset (asset_id),

    CONSTRAINT fk_maintenance_date
        FOREIGN KEY (date)
        REFERENCES dim_date(date),

    CONSTRAINT fk_maintenance_asset
        FOREIGN KEY (asset_id)
        REFERENCES dim_asset(asset_id)
) ENGINE=InnoDB;

CREATE TABLE dim_targets (
    year SMALLINT UNSIGNED NOT NULL,

    target_scope1_tco2e DECIMAL(14,0) NOT NULL,
    target_scope2_tco2e DECIMAL(14,0) NOT NULL,
    target_scope3_tco2e DECIMAL(14,0) NOT NULL,

    target_emission_intensity_tco2e_per_boe DECIMAL(10,5) NOT NULL,
    reduction_target_pct DECIMAL(6,2) NOT NULL,

    PRIMARY KEY (year)
) ENGINE=InnoDB;

CREATE TABLE dim_scenario (
    scenario_id VARCHAR(10) NOT NULL,
    scenario VARCHAR(50) NOT NULL,

    oil_price_usd_bbl DECIMAL(8,2) NOT NULL,
    production_growth_pct DECIMAL(7,2) NOT NULL,
    renewable_share_pct DECIMAL(7,2) NOT NULL,
    emission_factor_change_pct DECIMAL(7,2) NOT NULL,
    maintenance_efficiency_change_pct DECIMAL(7,2) NOT NULL,

    scenario_description VARCHAR(255),

    PRIMARY KEY (scenario_id),

    UNIQUE KEY uq_scenario_name (scenario)
) ENGINE=InnoDB;

USE shell_upstream_db;

CREATE TABLE fact_production_backup AS
SELECT *
FROM fact_production;

CREATE TABLE fact_production_new AS
SELECT
    MIN(production_id) AS production_id,
    date,
    asset_id,
    ROUND(AVG(production_boe_d)) AS production_boe_d,
    MAX(production_status) AS production_status
FROM fact_production
GROUP BY date, asset_id;

SELECT COUNT(*) AS row_count
FROM fact_production_new;

SELECT
    date,
    asset_id,
    COUNT(*) AS records
FROM fact_production_new
GROUP BY date, asset_id
HAVING COUNT(*) > 1;

SELECT
    (SELECT COUNT(*) FROM fact_production) AS old_rows,
    (SELECT COUNT(*) FROM fact_production_new) AS new_rows;
    
    USE shell_upstream_db;

RENAME TABLE fact_production
TO fact_production_old;

RENAME TABLE fact_production_new
TO fact_production;

SELECT COUNT(*) AS production_rows
FROM fact_production;

SELECT
    date,
    asset_id,
    COUNT(*) AS records
FROM fact_production
GROUP BY date, asset_id
HAVING COUNT(*) > 1;

DESCRIBE fact_financial;

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'shell_upstream_db'
  AND TABLE_NAME = 'fact_financial'
ORDER BY ORDINAL_POSITION;

SELECT COUNT(*) AS old_rows
FROM fact_financial;

SELECT
    date,
    asset_id,
    region,
    segment,
    COUNT(*) AS records
FROM fact_financial
GROUP BY
    date,
    asset_id,
    region,
    segment
HAVING COUNT(*) > 1;

SELECT
    SUM(records - 1) AS duplicate_rows_to_remove
FROM (
    SELECT
        date,
        asset_id,
        region,
        segment,
        COUNT(*) AS records
    FROM fact_financial
    GROUP BY date, asset_id, region, segment
    HAVING COUNT(*) > 1
) AS d;

SELECT
    date,
    asset_id,
    region,
    segment,
    COUNT(*) AS records,
    MIN(revenue_usd) AS min_revenue,
    MAX(revenue_usd) AS max_revenue,
    MIN(cost_usd) AS min_cost,
    MAX(cost_usd) AS max_cost,
    MIN(margin_usd) AS min_margin,
    MAX(margin_usd) AS max_margin
FROM fact_financial
GROUP BY date, asset_id, region, segment
HAVING COUNT(*) > 1
LIMIT 20;

CREATE TABLE fact_financial_new AS
SELECT
    MIN(f.financial_id) AS financial_id,
    f.date,
    f.asset_id,
    f.region,
    f.segment,

    SUM(f.revenue_usd) AS revenue_usd,
    SUM(f.cost_usd) AS cost_usd,
    SUM(f.margin_usd) AS margin_usd,

    CASE
        WHEN SUM(f.revenue_usd) <> 0
        THEN (SUM(f.margin_usd) / SUM(f.revenue_usd)) * 100
        ELSE 0
    END AS margin_pct,

    CASE
        WHEN MAX(p.production_boe_d) <> 0
        THEN SUM(f.revenue_usd) / MAX(p.production_boe_d)
        ELSE 0
    END AS revenue_per_boe_usd

FROM fact_financial f

LEFT JOIN fact_production p
    ON f.date = p.date
    AND f.asset_id = p.asset_id

GROUP BY
    f.date,
    f.asset_id,
    f.region,
    f.segment;
    
    SHOW WARNINGS;
    
    SELECT COUNT(*) AS new_rows
FROM fact_financial_new;
    
    SELECT
    date,
    asset_id,
    region,
    segment,
    COUNT(*) AS records
FROM fact_financial_new
GROUP BY
    date,
    asset_id,
    region,
    segment
HAVING COUNT(*) > 1;

SHOW CREATE TABLE fact_financial_new;

SELECT
    COLUMN_NAME,
    COLUMN_TYPE,
    IS_NULLABLE,
    NUMERIC_PRECISION,
    NUMERIC_SCALE
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'fact_financial_new'
  AND COLUMN_NAME IN (
      'margin_pct',
      'revenue_per_boe_usd'
  );
  
  SHOW WARNINGS LIMIT 20;
  
  SELECT
    TABLE_NAME,
    COLUMN_NAME,
    COLUMN_TYPE,
    NUMERIC_PRECISION,
    NUMERIC_SCALE
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME IN ('fact_financial', 'fact_production')
  AND COLUMN_NAME IN (
      'revenue_usd',
      'cost_usd',
      'margin_usd',
      'production_boe_d'
  )
ORDER BY TABLE_NAME, COLUMN_NAME;

CREATE TABLE fact_financial_new2 AS
SELECT
    MIN(f.financial_id) AS financial_id,
    f.date,
    f.asset_id,
    f.region,
    f.segment,

    SUM(f.revenue_usd) AS revenue_usd,
    SUM(f.cost_usd) AS cost_usd,
    SUM(f.margin_usd) AS margin_usd,

    CASE
        WHEN SUM(f.revenue_usd) <> 0
        THEN ROUND(
            (SUM(f.margin_usd) / SUM(f.revenue_usd)) * 100,
            6
        )
        ELSE 0
    END AS margin_pct,

    CASE
        WHEN MAX(p.production_boe_d) <> 0
        THEN ROUND(
            SUM(f.revenue_usd) / MAX(p.production_boe_d),
            6
        )
        ELSE 0
    END AS revenue_per_boe_usd

FROM fact_financial f

LEFT JOIN fact_production p
    ON f.date = p.date
    AND f.asset_id = p.asset_id

GROUP BY
    f.date,
    f.asset_id,
    f.region,
    f.segment;
    
    SELECT COUNT(*) AS new_rows
FROM fact_financial_new2;

SELECT
    date,
    asset_id,
    region,
    segment,
    COUNT(*) AS records
FROM fact_financial_new2
GROUP BY
    date,
    asset_id,
    region,
    segment
HAVING COUNT(*) > 1;

SELECT
    'OLD' AS source,
    COUNT(*) AS rows_count,
    SUM(revenue_usd) AS total_revenue,
    SUM(cost_usd) AS total_cost,
    SUM(margin_usd) AS total_margin
FROM fact_financial

UNION ALL

SELECT
    'NEW' AS source,
    COUNT(*) AS rows_count,
    SUM(revenue_usd) AS total_revenue,
    SUM(cost_usd) AS total_cost,
    SUM(margin_usd) AS total_margin
FROM fact_financial_new2;

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    COLUMN_TYPE,
    IS_NULLABLE
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME IN ('fact_financial', 'fact_financial_new2')
ORDER BY
    COLUMN_NAME,
    TABLE_NAME;
    
    SELECT
    COUNT(*) AS total_rows,
    SUM(
        revenue_usd IS NULL
        OR cost_usd IS NULL
        OR margin_usd IS NULL
        OR margin_pct IS NULL
        OR revenue_per_boe_usd IS NULL
    ) AS rows_with_nulls
FROM fact_financial_new2;

ALTER TABLE fact_financial_new2
    MODIFY financial_id BIGINT UNSIGNED NOT NULL,
    MODIFY date DATE NOT NULL,
    MODIFY asset_id VARCHAR(10) NOT NULL,
    MODIFY region VARCHAR(50) NOT NULL,
    MODIFY segment VARCHAR(50) NOT NULL,
    MODIFY revenue_usd DECIMAL(18,2) NOT NULL,
    MODIFY cost_usd DECIMAL(18,2) NOT NULL,
    MODIFY margin_usd DECIMAL(18,2) NOT NULL,
    MODIFY margin_pct DECIMAL(12,2) NOT NULL,
    MODIFY revenue_per_boe_usd DECIMAL(12,2) NOT NULL;
    
    SHOW WARNINGS;
    
    SELECT
    COUNT(*) AS total_rows,
    SUM(
        ABS(n2.margin_pct - n1.margin_pct) > 0.000001
    ) AS margin_pct_changed,
    SUM(
        ABS(n2.revenue_per_boe_usd - n1.revenue_per_boe_usd) > 0.000001
    ) AS revenue_per_boe_changed
FROM fact_financial_new2 n2
JOIN fact_financial_new n1
    ON n2.financial_id = n1.financial_id;
    
    SHOW INDEX FROM fact_financial;
    
    SHOW INDEX FROM fact_financial_new;
    
    SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT financial_id) AS unique_financial_ids
FROM fact_financial_new;

ALTER TABLE fact_financial_new
    ADD PRIMARY KEY (financial_id),
    ADD INDEX idx_financial_date (date),
    ADD INDEX idx_financial_asset (asset_id),
    ADD INDEX idx_financial_region (region);
    
    SHOW INDEX FROM fact_financial_new;
    
    SELECT
    COLUMN_NAME,
    COLUMN_TYPE,
    IS_NULLABLE
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'fact_financial_new'
ORDER BY ORDINAL_POSITION;

RENAME TABLE
    fact_financial TO fact_financial_old,
    fact_financial_new TO fact_financial;
    
    SELECT
    COUNT(*) AS rows_count,
    SUM(revenue_usd) AS total_revenue,
    SUM(cost_usd) AS total_cost,
    SUM(margin_usd) AS total_margin
FROM fact_financial;


DESCRIBE fact_maintenance;

USE shell_upstream_db;

CREATE TABLE fact_maintenance_backup AS
SELECT *
FROM fact_maintenance;

SELECT
    date,
    asset_id,
    maintenance_type,
    planned_unplanned,
    COUNT(*) AS records
FROM fact_maintenance
GROUP BY
    date,
    asset_id,
    maintenance_type,
    planned_unplanned
HAVING COUNT(*) > 1
ORDER BY records DESC;

SELECT
    MIN(margin_pct) AS min_margin_pct,
    MAX(margin_pct) AS max_margin_pct,
    AVG(margin_pct) AS avg_margin_pct,
    MIN(revenue_per_boe_usd) AS min_revenue_per_boe,
    MAX(revenue_per_boe_usd) AS max_revenue_per_boe,
    AVG(revenue_per_boe_usd) AS avg_revenue_per_boe
FROM fact_financial;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT maintenance_id) AS unique_maintenance_ids,
    SUM(maintenance_id IS NULL) AS null_maintenance_id,
    SUM(asset_id IS NULL) AS null_asset_id,
    SUM(date IS NULL) AS null_date,
    SUM(downtime_hours IS NULL) AS null_downtime,
    SUM(maintenance_cost_usd IS NULL) AS null_maintenance_cost
FROM fact_maintenance;

SHOW INDEX FROM fact_maintenance;

SELECT
    COLUMN_NAME,
    COLUMN_TYPE,
    IS_NULLABLE
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'fact_maintenance'
ORDER BY ORDINAL_POSITION;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT emissions_id) AS unique_emissions_ids,
    SUM(emissions_id IS NULL) AS null_emissions_id,
    SUM(asset_id IS NULL) AS null_asset_id,
    SUM(date IS NULL) AS null_date,
    SUM(emissions_performance IS NULL) AS null_emissions_performance,
    SUM(scope1_tco2e IS NULL) AS null_scope1,
    SUM(scope2_tco2e IS NULL) AS null_scope2,
    SUM(scope3_tco2e IS NULL) AS null_scope3
FROM fact_emissions;

SHOW INDEX FROM fact_emissions;

SELECT
    COLUMN_NAME,
    COLUMN_TYPE,
    IS_NULLABLE
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'fact_emissions'
ORDER BY ORDINAL_POSITION;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT production_id) AS unique_production_ids,
    SUM(production_id IS NULL) AS null_production_id,
    SUM(asset_id IS NULL) AS null_asset_id,
    SUM(date IS NULL) AS null_date,
    SUM(production_boe_d IS NULL) AS null_production_boe_d
FROM fact_production;

SHOW INDEX FROM fact_production;

SELECT
    COLUMN_NAME,
    COLUMN_TYPE,
    IS_NULLABLE
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'fact_production'
ORDER BY ORDINAL_POSITION;

ALTER TABLE fact_production
    MODIFY production_id BIGINT UNSIGNED NOT NULL,
    ADD PRIMARY KEY (production_id),
    ADD INDEX idx_production_date (date),
    ADD INDEX idx_production_asset (asset_id);
    
    SHOW INDEX FROM fact_production;