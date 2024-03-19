# Real Estate Data Collection Project

Overview

This project involves a Scrapy spider designed to scrape real estate listings from domoplius.lt, a Lithuanian property listing website. The primary goal is to collect data on property sales and rentals, including details such as price, location, area, number of rooms, condition, and heating type. The scraped data is processed and stored in a MySQL database, ensuring that each city, district, and street entry is unique and properly referenced.

Features

- Data Scraping: Automated extraction of real estate listings with detailed attributes.
- Data Processing: Cleansing and normalization of data before database insertion.
- Database Storage: Efficient storage of structured data into a MySQL database with proper relational integrity.

Database Schema

The database consists of several tables with foreign key relationships:

- Cities: Contains city names and unique identifiers.
- Districts: Contains district names linked to their respective cities.
- Streets: Contains street names.
- Locations: Aggregates cities, districts, and streets for location-based queries.
- Listings: Stores the listing data, including a reference to the Locations table.

# Real Estate Data Analysis

Analysis Objectives

The next phase of the Real Estate Data Collection Project is focused on analyzing the collected data to gain insights into the real estate market in Lithuania. The analysis aims to uncover patterns, trends, and anomalies within the sales, facilitating better understanding for potential buyers, sellers, and renters. 

#### Market Distribution by City and District: 
--kur kiek yra parduodamu objektu:

#### Average Price Analysis by different aspects:

- Overall:
```sql
SELECT ROUND(AVG(Price)) as AveragePrice, 
MIN(Price) as MinPrice, MAX(Price) as MaxPrice
FROM Listings
WHERE Status = "For Sale"
```
![1](https://github.com/gabwowce/Real-Estate-Data-Collection-and-Analysis-Project/assets/134537965/e76624ce-90d1-435b-85e3-f68b0fe38c8f)


#### Price Influences Based on Property Characteristics:

#### Comparison of Sales and Rental Markets:

#### Condition and Price Relationshi:
