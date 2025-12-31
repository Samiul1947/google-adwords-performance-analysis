# 🧾 Google AdWords Performance Analysis  

**End-to-End Marketing Analytics Pipeline for Keyword Performance, Cost Optimization, and Traffic Insights**  
 Excel · Python · MySQL · Power BI


---

[![Python Version](https://img.shields.io/badge/Python-3.9-blue)](https://www.python.org/)
[![MySQL](https://img.shields.io/badge/Database-MySQL-informational)](https://www.mysql.com/)
[![Power BI](https://img.shields.io/badge/Visualization-Power_BI-yellow)](https://www.microsoft.com/power-platform/products/power-bi)

---

## 📌 Table of Contents

- <a href="#overview">Overview</a>
- <a href="#business-problem">Business Problem</a>
- <a href="#project-objectives">Project Objectives</a>
- <a href="#tools-&-technologies">Tools & Technologies</a>
- <a href="#end-to-end-data-workflow">End-to-End Data Workflow</a>
- <a href="#dataset">Dataset</a>
- <a href="#data-cleanning-&-preparation">Data Cleaning & Preparation</a>
- <a href="#data-modeling-&-sql-schema">Data Modeling & SQL Schema</a>
- <a href="#sql-schema">SQL Schema (Core with Queries)</a>
- <a href="#relationship-diagram-(EER)">Relationship Diagram (EER)</a>
- <a href="#power-bi-data-model">Power BI Data Model</a>
- <a href="#power-bi-dashboard">Power BI Dashboard</a>
- <a href="#key-outcomes-insights--future-improvements">Key Outcomes, Insights & Future Improvements</a>
- <a href="#how-to-run-this-project">How to Run This Project</a>
- <a href="#repository-structure">Repository Structure</a>
- <a href="#author-&-contacts">Author & Contacts</a>

---
- <h2><a class="anchor" id="overview"></a>📌 Overview</h2>


This project presents a **complete, real-world Google AdWords analytics pipeline**, transforming raw keyword-level marketing data into **actionable insights and interactive dashboards**.

The solution simulates an **enterprise-grade ETL + BI workflow**, commonly used by:

- Digital marketing teams  
- Growth & performance analysts  
- Business intelligence units  

From **raw Excel files** to **Python-based preprocessing**, **normalized MySQL modeling**, and **Power BI dashboards**, this project demonstrates strong fundamentals in **data engineering, analytics, and visualization**.

---
- <h2><a class="anchor" id="business-problem"></a>🎯 Business Problem</h2>


Marketing teams often struggle to answer questions such as:

- Which keywords generate the most traffic at the lowest cost?
- Are we overspending on high-CPC, low-return keywords?
- How does keyword difficulty affect traffic contribution?
- What are the monthly and seasonal traffic trends?
- Which keywords should be scaled, optimized, or paused?

This project addresses these challenges by building a **structured analytics framework** for Google AdWords performance evaluation.

---
- <h2><a class="anchor" id="project-objectives"></a>🎯 Project Objectives</h2>


- Analyze keyword-level traffic, cost, and competition metrics
- Identify high-impact and low-efficiency keywords
- Track search demand and CPC trends over time
- Build a normalized relational database schema
- Deliver interactive Power BI dashboards for decision-making

---

- <h2><a class="anchor" id="tools-&-technologies"></a>🛠 Tools & Technologies</h2>


| Tool | Purpose |
|----|----|
| **Excel** | Raw data preparation, formulas, lookup tables |
| **Python (pandas)** | Data cleaning, keyword ID generation |
| **MySQL** | Relational modeling & SQL querying |
| **Power BI** | Data modeling, DAX, dashboards |
| **Git & GitHub** | Version control & documentation |

---

- <h2><a class="anchor" id="end-to-end-data-workflow"></a>🔁 End-to-End Data Workflow</h2>


```mermaid
graph LR
    A[Raw Excel Files] --> B[Excel Formulas]
    B --> C[Python Processing]
    C --> D[MySQL Database]
    D --> E[Power BI Dashboard]
```

Each stage feeds clean, structured data into the next—mirroring real production analytics pipelines.

---

 - <h2><a class="anchor" id="dataset"></a>📂 Dataset</h2>
 

### 📑 Dataset Description

🔹 **Source:** Public dataset downloaded from **Kaggle** (Google AdWords–style keyword performance data)

🔹 **Raw_data.xlsx** (Simulated Google AdWords export) containing variables:

- Keyword  
- Current & previous positions  
- Cost Per Click (CPC)  
- Traffic  
- Competition  
- Search volume  
- Number of SERP results  

---

 - <h2><a class="anchor" id="data-cleanning-&-preparation"></a>🧹 Data Cleaning & Preparation</h2>


### Step 1: Excel Processing

Excel formulas were used to:

- Aggregate search volume using `SUMIF()`
- Calculate average keyword difficulty using `AVERAGEIF()`
- Categorize difficulty levels using `IF()` logic
- Create lookup tables using `VLOOKUP()`

### Step 2: Python Processing

Using **pandas**, the following steps were performed:

- Loaded raw Excel data with `pd.read_excel()`
- Generated unique `keyword_ID` values
- Ensured consistent foreign-key mapping across tables

```python
df['keyword_ID'] = df['keyword'].astype('category').cat.codes
```

### Step 3: Lookup Table Creation

The cleaned data was split into three reference tables:

- `keyword.csv` — Unique keywords with IDs
- `search_volume.csv` — Aggregated search volume
- `keyword_difficulty.csv` — Average difficulty and difficulty labels

### Excel Formulas Used

| Formula                        | Purpose                       |
| ------------------------------ | ----------------------------- |
| `SUMIF()`                      | Aggregate total search volume |
| `AVERAGEIF()`                  | Compute average difficulty    |
| `IF(B2>=50,"Hard","Moderate")` | Assign difficulty level       |
| `VLOOKUP()`                    | Map keyword metadata          |

✅ These lookup tables support normalization and ensure data integrity in the SQL schema. These tables act as lookup/reference tables for SQL.

---

 - <h2><a class="anchor" id="data-modeling-&-sql-schema"></a>🗂 Data Modeling & SQL Schema</h2>

### Dimension Tables

🔹 keyword

| Column       | Description  |
| ------------ | ------------ |
| `keyword_ID` | Primary key  |
| `keyword`    | Keyword text |

🔹 search_volume

| Column          | Description           |
| --------------- | --------------------- |
| `keyword_ID`    | Foreign key           |
| `search_volume` | Monthly search volume |

🔹 keyword_difficulty

| Column             | Description              |
| ------------------ | ------------------------ |
| `keyword_ID`       | Foreign key              |
| `avg_difficulty`   | Average difficulty score |
| `difficulty_level` | Hard / Moderate          |

### 🔹 Fact Table: website_traffic_data

| Column                 | Description             |
| ---------------------- | ----------------------- |
| `title`                | Campaign / landing page |
| `keyword`              | Keyword text            |
| `keyword_ID`           | Foreign key             |
| `positions`            | Current position        |
| `previous_positions`   | Previous position       |
| `last_seen`            | Date                    |
| `Search_Volume`        | Monthly demand          |
| `CPC`                  | Cost per click          |
| `Traffic`              | Estimated traffic       |
| `Traffic_Percent`      | Share of total traffic  |
| `Traffic_Cost`         | Cost attribution        |
| `Traffic_Cost_Percent` | Cost share              |
| `Competition`          | Competition score       |
| `Number_of_Results`    | SERP results            |
| `Keyword_difficulty`   | Difficulty reference    |

✅ This acts as the central **fact table** enabling all analytical queries.


### Main Table View:

<img width="1920" height="1080" alt="main_table" src="https://github.com/user-attachments/assets/b3895f17-0bbb-4d7b-bec5-e0393b0893fa" />





---
 - <h2><a class="anchor" id="sql-schema"></a>🗃 SQL Schema (Core with Queries)</h2>


```sql
CREATE DATABASE IF NOT EXISTS traffic_project;
USE traffic_project;

CREATE TABLE website_traffic_data (
    title VARCHAR(250),
    keyword VARCHAR(250),
    keyword_ID INT,
    positions INT,
    previous_positions INT,
    last_seen DATE,
    Search_Volume INT,
    CPC DECIMAL(10,2),
    Traffic INT,
    Traffic_Percent DECIMAL(10,2),
    Traffic_Cost INT,
    Traffic_Cost_Percent DECIMAL(10,2),
    Competition DECIMAL(10,2),
    Number_of_Results INT,
    Keyword_difficulty INT
);

CREATE TABLE keyword (
    keyword_ID INT PRIMARY KEY,
    keyword VARCHAR(250)
);

CREATE TABLE keyword_difficulty (
    keyword_ID INT PRIMARY KEY,
    avg_difficulty DECIMAL(10,2),
    difficulty_level VARCHAR(50)
);

CREATE TABLE search_volume (
    keyword_ID INT PRIMARY KEY,
    Search_Volume INT
);

ALTER TABLE website_traffic_data
ADD FOREIGN KEY (keyword_ID) REFERENCES keyword(keyword_ID);
```

---

Foreign-key constraints ensure data integrity and normalization.
These keys ensure consistent data joins between tables.

### 📘 Schema Screenshot:

<img width="1920" height="1080" alt="mysql_schema_editor" src="https://github.com/user-attachments/assets/c4185903-aa9b-43dd-931e-817d4245c024" />

### 🔑 Keys & Normalization

Imported the other CSVs into MySQL:

- `keyword`
- `search_volume`
- `keyword_difficulty`

Then established relational integrity:

```sql
ALTER TABLE website_traffic_data
ADD FOREIGN KEY (keyword_ID) REFERENCES keyword(keyword_ID);
```

These keys ensure consistent data joins between tables.

---
- <h2><a class="anchor" id="relationship-diagram-(EER)"></a>🧠 Relationship Diagram (EER)</h2>


### EER Diagram:

<img width="1920" height="1080" alt="EER_Diagram" src="https://github.com/user-attachments/assets/f217f694-cd49-4104-ab1a-8c52077aa8ce" />

These diagrams visualize the 1-to-many relationships between:

- Keywords → Traffic Data
- Keyword Difficulty → Traffic Data
- Search Volume → Traffic Data

---

---
- <h2><a class="anchor" id="power-bi-data-model"></a>🧩 Power BI Data Model</h2>

The dashboard follows a **star-schema data model**, ensuring accurate filtering, optimized performance, and scalable reporting.

### Relationships:

- Fact: `website_traffic_data`
- Dimensions:
  - `keyword` (via keyword_ID)
  - `keyword_difficulty`
  - `search_volume`

✅ This model ensures accurate filtering and joins.

### Power BI Data Model:

<img width="1920" height="1037" alt="powerbi_data_model" src="https://github.com/user-attachments/assets/105dd2ac-85ed-4c63-9e93-a7902e1579e6" />

---

## 🔢 DAX Measures Used

### 📊 Key Measures

```DAX
Average CPC = AVERAGE(website_traffic_data[CPC])
Total Traffic = SUM(website_traffic_data[Traffic])
Total Search Volume = SUM(website_traffic_data[Search_Volume])
Total Traffic Cost = SUM(website_traffic_data[Traffic_Cost])
Traffic Percent = AVERAGE(website_traffic_data[Traffic_Percent])

Start Date = MIN(website_traffic_data[last_seen])
Last Date = MAX(website_traffic_data[last_seen])

Calendar = 
CALENDAR(
    [Start Date],
    [Last Date]
)

Month = FORMAT(Calendar[Date], "MMMM")
Quarter = QUARTER(Calendar[Date])
Year = YEAR(Calendar[Date])
Year & QTR = Year & " Q" & Quarter
```

---

These enable filtering, aggregation, and time-based visualizations.

---

---
- <h2><a class="anchor" id="power-bi-dashboard"></a>📈 Power BI Dashboard</h2>


The Power BI report connects directly to MySQL database and provides interactive insights.

### Dashboard Features

- **KPI Cards**: Total Traffic, CPC, Search Volume, Cost
- **Line Chart**: Traffic trends over time
- **Bar Chart**: Traffic by keyword
- **Treemap**: Search volume distribution
- **Pie/Donut Charts**: Traffic distribution by keyword difficulty and by month
- **Slicers**: Year, Quarter, Keyword filter

### Power BI Dashboard Insights:


<img width="1920" height="1037" alt="power-bi-dashboard" src="https://github.com/user-attachments/assets/1d937d91-f264-4730-9d44-210ef9690325" />

---

- <h2><a class="anchor" id="key-outcomes-insights--future-improvements"></a>🚀 Key Outcomes, Insights & Future Improvements</h2>

### Key Outcomes

- Identified high-traffic, low-CPC keywords for scaling
- Revealed high-cost, low-return keywords for optimization
- Highlighted difficulty-based traffic contribution
- Delivered a reusable marketing analytics framework

### Insights Generated

- High-search-volume keywords do not always deliver proportional traffic
- Certain keywords have high CPC but low traffic efficiency
- Majority of traffic comes from moderate to high difficulty keywords
- Monthly traffic trends reveal seasonal demand patterns

### Outcome & Impact

- Enabled campaign performance monitoring through a single dashboard
- Improved keyword prioritization strategy
- Supported cost optimization decisions
- Demonstrated the full analytics lifecycle: data modeling → SQL → BI

### Future Improvements

- Automate data ingestion using Google Ads API or scheduled ETL pipelines  
- Add advanced KPIs such as CTR, Conversion Rate, and ROAS  
- Implement time-series analysis for MoM/YoY and seasonality trends  
- Enhance the data model with campaign, device, and location dimensions  
- Introduce keyword clustering and performance forecasting  
- Deploy the solution on cloud platforms for scalability and real-time analytics  

---

- <h2><a class="anchor" id="repository-structure"></a>📂 Repository Structure</h2>

```bash
📦 google-adwords-performance-analysis
 ┣ 📄 Raw_data.xlsx
 ┣ 📄 website_traffic_data.csv
 ┣ 📄 keyword.csv
 ┣ 📄 keyword_difficulty.csv
 ┣ 📄 search_volume.csv
 ┣ 📄 SQL_schema_script.sql
 ┣ 📄 AdWords_Traffic_Dashboard.pbix
 ┣ 📁 Images
 ┃ ┣ 📷 main_table.png
 ┃ ┣ 📷 EER_Diagram.png
 ┃ ┣ 📷 mysql_schema_editor.png
 ┃ ┣ 📷 power_bi_dashboard.png
 ┃ ┗ 📷 powerbi_data_model.png
 ┗ 📄 README.md
 ```

---

- <h2><a class="anchor" id="how-to-run-this-project"></a>📈 ⚙ How to Run This Project</h2>


### 1️⃣ Clone the Repository

```bash
git clone https://github.com/Samiul1947/google-adwords-performance-analysis.git
```

### 2️⃣ Review Source Files

- Inspect `Raw_data.xlsx` and the processed `.csv` files
- (Optional) Modify data using Excel formulas if needed

### 3️⃣ Set Up MySQL Database

- Import all `.csv` files using MySQL Workbench
- Execute the provided SQL schema to create tables and relationships
- Ensure foreign keys are applied correctly

### 4️⃣ Open Power BI Dashboard

- Open the provided .pbix file to view the interactive report
- Or connect manually via: `Home → Get Data → MySQL`


---
- <h2><a class="anchor" id="author-&-contacts"></a>👤 Author & Contacts</h2>

**Samiul Gazi** | Aspiring Data Analyst
Passionate about data storytelling, unsupervised data exploration, and real-world analytics.
🎓 M.Sc. Economics – University of Calcutta  
📍 Kolkata, West Bengal  

📧 **Email:** [sgaziamumh@gmail.com](mailto:sgaziamumh@gmail.com)  
🔗 **LinkedIn:** [linkedin.com/in/samiul-gazi](https://www.linkedin.com/in/samiul-gazi)  
🌐 **GitHub:** [github.com/Samiul1947](https://github.com/Samiul1947)  

If you liked this project, please ⭐ the repo!

⭐ **For Recruiters & Hiring Managers**  
📌 This project demonstrates hands-on experience in **ETL design, relational data modeling, SQL querying, DAX measures, and BI storytelling**, which are core competencies for **Data Analyst and Business Intelligence roles**.

---
