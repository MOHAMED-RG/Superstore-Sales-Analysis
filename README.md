# Superstore Sales Analysis — SQL & Power BI

An end-to-end sales analysis project using **PostgreSQL, SQL, and Power BI** to analyze retail sales performance and identify patterns across products, customers, regions, and shipping modes.

## 📊 Project Overview

This project analyzes the Superstore dataset using SQL for data cleaning, validation, and analysis, followed by Power BI for interactive visualization and dashboard development.

The goal is to transform raw sales data into clear business insights and present the results through an interactive dashboard.

## 📂 Dataset

[Superstore Sales Dataset](https://www.kaggle.com/datasets/rohitsahoo/sales-forecasting)

- **Rows:** 9,801
- **Columns:** 18

The dataset contains retail sales information including:

- Orders
- Customers
- Products
- Categories
- Regions
- Shipping modes
- Sales

## 🧹 Data Preparation & Validation

PostgreSQL was used to prepare and validate the dataset before analysis.

The preparation process included:

- Checking for missing values
- Validating data types
- Handling missing sales values
- Reviewing NULL values
- Validating product and customer information
- Checking data consistency before analysis

## 🎯 Analysis Questions

The project explores questions such as:

- What is the overall sales performance?
- How do sales change over time?
- Which product category generates the highest sales?
- Which region generates the highest sales?
- Which shipping mode generates the highest sales?
- Which customers generate the highest sales?

## 📈 SQL Analysis

SQL was used to perform exploratory and business-oriented analysis, including:

- Total sales analysis
- Sales by year
- Sales by category
- Sales by region
- Sales by shipping mode
- Top customers by sales
- Top cities by profit
- Top products
- Negative-profit products

## 📊 Power BI Dashboard

Power BI was used to create an interactive dashboard presenting the main findings from the SQL analysis.

The dashboard includes:

- **Total Sales**
- **Total Orders**
- **Total Customers**
- **Total Products**
- **Sales by Year**
- **Sales by Category**
- **Sales by Region**
- **Sales by Ship Mode**
- **Top 10 Customers by Sales**
- **Category and Region slicers**

## 💡 Key Insights

- **Total Sales:** approximately **$2.26M**
- **Technology** generated the highest sales among the three categories.
- **West** generated the highest sales among the four regions.
- **Standard Class** generated the highest sales among shipping modes.
- **2018** recorded the highest annual sales.
- **Sean Miller** was the top customer by sales.

## 🖥️ Dashboard Preview

![Superstore Dashboard](superstore.png)

## 🛠️ Tools & Technologies

- PostgreSQL
- SQL
- Power BI
- DAX
- Data Cleaning
- Data Validation
- Data Analysis
- Data Visualization

## 📌 Methodology

The project followed an end-to-end analytical workflow:

1. Imported the Superstore dataset into PostgreSQL.
2. Cleaned and validated the data using SQL.
3. Performed exploratory and business analysis using SQL queries.
4. Connected the prepared data to Power BI.
5. Created DAX measures for key performance indicators.
6. Built an interactive dashboard.
7. Summarized the main findings and business insights.

## 💼 Business & Analytical Value

This project demonstrates the ability to:

- Work with relational databases using PostgreSQL
- Write SQL queries for business analysis
- Clean and validate real-world datasets
- Create analytical KPIs using DAX
- Build interactive Power BI dashboards
- Analyze sales performance across multiple dimensions
- Identify high-performing and low-performing areas
- Communicate analytical findings through data visualization

## 📂 Project Structure

```text
superstore-sales-analysis/
│
├── README.md
├── superstore.png
└── superstore_analysis.sql
```

## 📌 Conclusion

The analysis provides an overview of Superstore sales performance across
time, product categories, regions, customers, and shipping modes.

The results highlight differences in sales performance across these
dimensions and demonstrate how SQL and Power BI can be combined to
transform raw retail data into clear business insights.
