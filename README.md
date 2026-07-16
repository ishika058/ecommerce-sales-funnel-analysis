# 📊 E-Commerce Sales Funnel Analysis

## 📌 Project Overview

This project analyzes customer behavior across an e-commerce sales funnel using **SQL** and **Power BI**. The goal is to identify where customers drop off, evaluate marketing channel performance, measure conversion rates, analyze customer journey duration, and provide actionable business recommendations to improve conversions and revenue.

---

## 🎯 Business Objectives

This project answers the following business questions:

1. How many users reached each stage of the sales funnel?
2. What are the conversion rates between each funnel stage?
3. Which marketing channels generate the highest traffic and conversions?
4. How long does it take users to complete the purchase journey?
5. What are the key revenue metrics, including Total Revenue, Average Order Value, Revenue per Buyer, and Revenue per Visitor?

---

## 🛠 Tools & Technologies

- SQL (MySQL)
- Power BI
- DAX
- Power Query

---

## 📊 Dashboard Preview

### Overview Page

### Performance Overall view

### Performance Detailed view

---

## 📈 Key Insights

-- The website attracted **4,268 unique visitors**, resulting in **708 purchases**, with an **overall conversion rate of 17%**.
-- The largest customer drop-off occurred between **Page View** and **Add to Cart**, making it the primary opportunity for funnel optimization.
-- **Organic Search** generated the highest traffic and the most purchases, while **Email Marketing** delivered the highest conversion rates despite the lowest visitor volume.
-- **Social Media** drove significant traffic but recorded the lowest conversion performance, indicating a need for improved targeting and landing page optimization.
-- Users completed the purchase journey in an average of **24.55 minutes**, with only **13.36 minutes** between adding an item to the cart and completing the purchase.
-- The business generated **₹76,037.93** in revenue, with an **Average Order Value (AOV)** of **₹107.40** and **Revenue per Visitor of ₹17.82**.

---

## 💡 Business Recommendations

-- Optimize product pages to improve the **Page View → Add to Cart** conversion rate, where the largest user drop-off occurs.
-- Continue investing in **Organic Search**, as it delivers the highest visitor volume and total purchases.
-- Increase investment in **Email Marketing**, which consistently achieves the highest conversion rates and attracts high-quality traffic.
-- Optimize **Social Media campaigns** by improving audience targeting, creatives, and landing pages to convert more visitors into customers.
-- Since **Cart → Purchase conversion remains consistent across all traffic sources (≈49–57%)**, prioritize increasing the number of users who reach the cart stage rather than focusing solely on the checkout process.

---

## 📁 Repository Structure

```
ecommerce-sales-funnel-analysis/
│
├── README.md
├── ECommerce Sales Funnel Analysis.pbix
│
├── images/
│   ├── overview.png
│   ├── performance_overall_view.png
│   └── performance_detailed_view.png
│
├── sql/
│   └── business_analysis.sql
```

---

## 🚀 Project Workflow

```
Raw Event Data
        │
        ▼
Import into MySQL
        │
        ▼
SQL Business Analysis
        │
        ▼
Power BI Data Model
        │
        ▼
DAX Measures
        │
        ▼
Interactive Dashboard
        │
        ▼
Business Insights & Recommendations
```


