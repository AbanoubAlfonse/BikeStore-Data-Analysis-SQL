# 🚴 BikeStore Data Analysis Project (SQL)

Welcome to the **BikeStore Data Analysis** project. This repository contains advanced SQL scripts designed to perform Exploratory Data Analysis (EDA) on a relational database of a bike retail store. The goal of this project is to extract critical business Key Performance Indicators (KPIs) and provide actionable insights for sales, inventory management, and customer behavior.

This project was completed as part of my intensive training at the **National Telecommunication Institute (NTI)**.

---

## 📊 Key Business Insights & Findings

* **Top Performing Category**: `Cruisers Bicycles` emerged as the most sold product category.
* **Brand Popularity**: `Electra` is the most loved and frequently ordered brand by customers.
* **Geographical Highlights**: **New York (NY)** is the highest revenue-generating state, outperforming others significantly.
* **Operational Red Flags**: `Electric Bikes` showed the highest rate of rejected/canceled orders, suggesting a need for quality control or pricing adjustments.
* **Inventory Insights**: The `Santa Cruz Bikes` store maintains the highest stock levels for the top-performing brands.

---

## 🛠️ Tech Stack & SQL Skills Demonstrated

* **Database Engine**: Microsoft SQL Server (T-SQL)
* **Advanced Joins**: Utilizing `INNER JOIN` and `LEFT OUTER JOIN` to bridge data across multiple relational tables (Sales, Production).
* **Data Aggregation**: Implementation of `SUM()`, `COUNT()`, `AVG()`, `GROUP BY`, and `HAVING` clauses for financial and performance reporting.
* **Date Manipulation**: Using advanced time-based functions like `DATEADD()` to filter records dynamically (e.g., analyzing sales over the last 8 months).

---

## 📂 Database Schema Overview

The analysis spans across two main schemas:
1. **Production**: Brands, Categories, Products, and Stocks.
2. **Sales**: Customers, Orders, Order Items, Staffs, and Stores.

---

## 🚀 How to Run the Script

1. Download or clone this repository.
2. Open Microsoft SQL Server Management Studio (SSMS).
3. Import the `BikeStore_Analysis.sql` script.
4. Execute the queries against your BikeStore database instance to see the results.

---

## 🎯 Next Steps
* Exporting the query results into **Power BI** to build an interactive, data-driven executive dashboard.

---
*Special thanks to my instructor and the NTI team for their continuous support and guidance during this project!*
