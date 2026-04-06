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
