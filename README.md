# Customer Support SQL Analysis

## Overview
This project analyzes customer support performance using SQL and a customer support dataset imported into MySQL. I transformed a raw CSV into relational tables and used SQL queries to evaluate customer satisfaction, agent performance, product-category trends, revenue patterns, and operational support insights.

The goal of the project was to identify which support channels, product categories, and agents were associated with stronger or weaker customer satisfaction outcomes, while also exploring revenue-linked support activity.
## Business Problem
Customer support teams need to understand which channels, product categories, and operational factors are tied to higher or lower customer satisfaction. They also need visibility into which product areas generate the most support activity and revenue impact.

This project explores:
- Which support channels have the highest customer satisfaction
- Which agents are top and low performers based on CSAT
- Which product categories drive the most support-related revenue
- Which issue categories show lower customer satisfaction
- How support volume varies across cities and shifts
## Dataset
The analysis uses a customer support dataset containing ticket-level information such as:
- support channel
- support category and sub-category
- order ID
- customer city
- product category
- item price
- agent, supervisor, and manager
- agent shift
- CSAT score
- handling time

The raw CSV was imported into MySQL and then transformed into relational tables for customers, agents, orders, and support tickets. :contentReference[oaicite:1]{index=1}

## Tools Used
- MySQL
- MySQL Workbench
- SQL
- GitHub
## Database Design
I started with a raw imported table and then created a simplified relational structure:

- `customers`
- `agents`
- `orders`
- `support_tickets`

This structure made it possible to perform joins across customer, order, and support data and answer business questions more efficiently.
## Key Findings

### CSAT by Channel
- Inbound had the highest average CSAT at **4.21** across **3813** tickets
- Outcall had an average CSAT of **4.13** across **965** tickets
- Email had the lowest average CSAT at **3.87** across **133** tickets

### Best Agents by CSAT
- David Smith had an average CSAT of **4.92** across **26** tickets
- Corlyn Sullivan had an average CSAT of **4.44** across **25** tickets

### High-Volume / High-Quality Agents
Among agents with at least 20 CSAT-scored tickets:
- David Smith: **4.92** across **26** tickets
- Wendy Taylor: **4.82** across **22** tickets
- Ryan Thompson: **4.62** across **21** tickets
- Tammy Cochran: **4.50** across **20** tickets

### Lowest Performing Agents
Among agents with at least 20 CSAT-scored tickets:
- Jamie Smith: **3.30** across **20** tickets
- Stacy Singh: **3.70** across **23** tickets
- Kathryn Jones: **4.05** across **20** tickets

### CSAT by Product Category
- Lifestyle: **4.04** across **235** tickets
- Electronics: **3.95** across **240** tickets
- Furniture: **3.87** across **23** tickets
- Books & General Merchandise: **3.81** across **187** tickets
- Home Appliances: **3.77** across **90** tickets
- Mobile: **3.72** across **135** tickets
- Home: **3.50** across **82** tickets

### Revenue by Product Category
- Mobile generated the highest support-linked revenue at **3,102,167**
- Home Appliances generated **1,344,308**
- Electronics generated **1,228,542**
- Lifestyle generated **221,172**

### CSAT by Agent Shift
- Split shift had the highest average CSAT at **4.40**
- Afternoon shift averaged **4.29**
- Evening shift averaged **4.24**
- Night shift averaged **4.16**
- Morning shift had the lowest average CSAT at **4.09**

### Top Cities by Support Volume
- One blank or uncategorized city field accounted for **3622** tickets
- Hyderabad had **56** tickets
- New Delhi had **41**
- Pune had **27**
- Bangalore had **26**

### Lowest CSAT Issue Categories
- Others: **3.50**
- Cancellation: **3.90**
- Order Related: **4.03**
- Feedback: **4.05**

### Response Time vs CSAT
- The response-time grouping returned only a **Fast** bucket with average CSAT of **4.19** across **4911** tickets, suggesting either limited handling-time variation or a need for better bucketing logic.

### Monthly Ticket Trend Limitation
- The monthly trend query returned mostly null values, indicating that the order date field likely needs additional cleaning or conversion before reliable time-series analysis can be performed.
## Business Insights
This analysis suggests that inbound support is currently the strongest-performing customer channel and that email may be an area for service improvement. Product-category results show that Mobile, Home Appliances, and Electronics drive the most support-linked revenue, making them especially important for customer experience strategy.

Agent-level analysis identified both high-performing and lower-performing agents, which could support coaching, training, and quality assurance efforts. Shift-based results suggest there
## Project Files
- `README.md` – project overview, findings, and recommendations
- `sql_queries.sql` – SQL queries used for table creation and analysis
- `SQL Info.pdf` – exported notes and query findings
- `Customer_support_data.csv` – raw source dataset
