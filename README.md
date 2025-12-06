# Customer Segmentation

## Table of Contents

### Project Overview

This project focuses on understanding customer purchasing behavior using RFM (Recency, Frequency, Monetary) analysis and clustering techniques. The goal is to segment customers into meaningful groups and uncover the patterns that drive customer value, loyalty, and churn risk. Using Python for data processing and Power BI for interactive visualization, the project transforms raw transactional data into actionable marketing insights.

The final dashboard enables stakeholders to explore customer segments, compare performance across groups, and answer both “what is happening?” and “why is it happening?” This equips the business with a data-driven foundation for customer retention, targeted marketing, and revenue optimization.

### Business Problem

The business has thousands of customers with different spending habits, levels of activity, and purchasing value. However, without a structured customer segmentation strategy, it is difficult to answer important questions such as:

- Which customers are the most loyal and profitable?

- Which customers are at risk of churn due to long inactivity?

- Which customers buy frequently but spend little?

- Which segments should receive targeted promotions or retention campaigns?

The lack of insight leads to inefficient marketing, missed revenue opportunities, and poor customer retention.
To make informed decisions, the business needs a clear, data-driven way to group customers and understand what drives their behavior.

### Project Objectives

This project aims to:

- Primary Objectives

  - Segment customers using RFM analysis (Recency, Frequency, Monetary) to identify patterns in customer value and engagement.

  - Use clustering (K-Means) to categorize customers into distinct behavioral groups.

  - Build an interactive Power BI dashboard to visualize segments and monitor customer performance.

- Insight Objectives (Answering “Why?”)

  - Explain why each customer segment behaves the way it does using annotations, tooltips, and DAX-based insights.

  - Identify drivers of high customer value, churn risk, and cross-selling opportunities.

  - Provide recommendations for marketing actions based on segment behavior.

- Outcome Objectives

  - Enable the business to improve retention, allocate marketing budgets more effectively, and personalize customer communication.

### Dataset Description

The dataset used for this project represents transaction-level customer behavior that has been transformed into RFM metrics. After preprocessing, feature engineering, and clustering, the final dataset contains the following columns:

[Final Dataset Fields](https://github.com/onatolumayowa/customer_segmentation/blob/main/data/processed/rfm_marketing_segments.csv)

|Column Name|Description|
|-----------|-----------|
|customer_id|A unique identifier assigned to each customer.|
|recency|Number of days since the customer’s last purchase. Lower values = more recent activity.|
|frequency|Total number of purchases made by the customer within the analysis period.|
|monetary|Total amount spent by the customer. Represents customer lifetime value in currency.|
|Cluster|The customer’s assigned cluster (e.g., 0, 1, 2, 3) from the K-Means algorithm.|
|segment_label|Human-friendly segment name mapped from each cluster (e.g., Champions, Loyal, At Risk).|

[Where the Dataset Comes From](https://github.com/onatolumayowa/customer_segmentation/tree/main/data/raw)

- Raw transaction data contained purchase IDs, customer IDs, purchase dates, and amounts.

- Data was cleaned to remove null values, duplicates, and invalid transactions using SQL.

- RFM features were engineered using Python.

- K-Means clustering grouped customers based on RFM similarity.

- Results were exported to Power BI for interactive dashboarding.

### Data Preparation & Cleaning Steps

Before performing RFM analysis and clustering, several cleaning and transformation steps using SQL were applied to ensure data quality and accuracy.

[Data Cleaning](https://github.com/onatolumayowa/customer_segmentation/blob/main/sql/data_cleaning.sql)

- Remove Duplicates

  - Checked for duplicate transaction records and removed them to avoid inflating frequency or monetary values.

- Handle Missing Values

  - Verified that important fields (customer_id, transaction_date, amount) contained no nulls.

  - Removed or corrected incomplete rows if necessary.

[Final Fact Table](https://github.com/onatolumayowa/customer_segmentation/blob/main/sql/customer_orders_fact.sql)

[Feature Engineering (Creating RFM Metrics)](https://github.com/onatolumayowa/customer_segmentation/blob/main/notebooks/rfm_analysis_and_kmeans_clustering.ipynb)

- Recency

Calculated as:

```python

recency = (analysis_date - last_purchase_date).days

```
