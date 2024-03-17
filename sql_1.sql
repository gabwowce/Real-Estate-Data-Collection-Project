SELECT count(*) FROM listings l  

SELECT price, Area, Rooms, Status, CityID, DistrictID, StreetID, COUNT(*)
FROM listings l 
LEFT JOIN locations lc ON l.LocationID = lc.LocationID 
GROUP BY price, Area, Rooms, Status, CityID, DistrictID, StreetID
HAVING COUNT(*) > 1;


SELECT price, Area, Rooms, Status, CityID, DistrictID, StreetID
FROM listings l 
LEFT JOIN locations lc ON l.LocationID = lc.LocationID 

SELECT * FROM listings l 
LEFT JOIN locations l2 ON l.LocationID =l2.LocationID 

SELECT CityID, count(*) FROM listings l 
LEFT JOIN locations l2 ON l.LocationID =l2.LocationID 
GROUP BY CityID
HAVING count(*) > 1

SELECT * FROM streets s 

SELECT * FROM districts d 

UPDATE locations  
SET StreetID = (
    SELECT MIN(StreetID) 
    FROM streets s1 
    WHERE s1.StreetName = (SELECT StreetName FROM streets s2 WHERE s2.StreetID = locations.StreetID)
)

SELECT StreetID, count(*) FROM locations l GROUP BY StreetID 



DELETE FROM streets 
WHERE StreetID NOT IN (
    SELECT MIN(StreetID) 
    FROM streets 
    GROUP BY StreetName
)

DELETE FROM streets 
WHERE StreetID NOT in 
(SELECT * FROM 
(SELECT min(StreetID) FROM streets s2 
GROUP BY StreetName)AS temp1)



SELECT StreetName, MIN(StreetID) 
    FROM streets 
    GROUP BY StreetName
    
SELECT MIN(DistrictID) as MINid, DistrictName
FROM districts d 
GROUP BY DistrictName

SELECT * FROM streets s 
SELECT * FROM cities c  
SELECT * FROM districts d 


UPDATE locations  
SET StreetID = (
    SELECT MIN(StreetID) 
    FROM streets s1 
    WHERE s1.StreetName = (SELECT StreetName FROM streets s2 WHERE s2.StreetID = locations.StreetID)
)
