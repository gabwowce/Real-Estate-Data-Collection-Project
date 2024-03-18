###Average price of apartments for sale###

#By cities:

SELECT CityName, round(AVG(price),2) avrPrice FROM listings l 
LEFT JOIN locations l2 ON l.LocationID = l2.LocationID 
LEFT JOIN cities c ON l2.CityID = c.CityID 
WHERE l.Status = "For Sale"
GROUP BY CityName 
ORDER BY avrPrice DESC 


#By City/Districts:

SELECT CityName, DistrictName, round(AVG(price),2) avrPrice FROM listings l 
LEFT JOIN locations l2 ON l.LocationID = l2.LocationID 
LEFT JOIN cities c ON l2.CityID = c.CityID 
LEFT JOIN districts d  ON l2.DistrictID = d.DistrictID 
WHERE l.Status = "For Sale"
GROUP BY CityName, DistrictName 
ORDER BY avrPrice DESC 

###Analysis of apartment size and number of rooms###

#The ratio of the number of rooms to the price:
SELECT Rooms, Count(*), avg(price) avg FROM listings l 
GROUP BY Rooms 
WHERE l.Status = "For Sale"
ORDER BY avg DESC 

#Area and price ratio:
#m2 avarage price in Liyhuania:

#m2 avarage price by city/district:


###Influence of housing condition and type of heating on the price###