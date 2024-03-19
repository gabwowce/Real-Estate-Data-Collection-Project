Real Estate Data Collection Project

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

```sql
SELECT CityName, DistrictName, round(AVG(price),2) avrPrice FROM listings l 
LEFT JOIN locations l2 ON l.LocationID = l2.LocationID 
LEFT JOIN cities c ON l2.CityID = c.CityID 
LEFT JOIN districts d  ON l2.DistrictID = d.DistrictID 
WHERE l.Status = "For Sale"
GROUP BY CityName, DistrictName 
ORDER BY avrPrice DESC
```
