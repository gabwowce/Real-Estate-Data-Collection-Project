# Nekilnojamojo turto duomenų rinkimo ir analizė projektas


Šiame projekte Scrapy voras (Scraping_real_estate failas), skirtas skrebinti nekilnojamojo turto sąrašus iš Lietuvos nekilnojamojo turto svetainės domoplius.lt. Pagrindinis tikslas yra rinkti duomenis apie nekilnojamojo turto pardavimą ir nuomą, įskaitant tokią informaciją kaip kaina, vieta, plotas, kambarių skaičius, būklė ir šildymo tipas. Duomenys saugomi MySQL duomenų bazėje, užtikrinant, kad kiekvienas miestas, rajonas ir gatvės įrašas būtų unikalus ir tinkamai nurodytas.

- Duomenų išgryninimas: automatizuotas nekilnojamojo turto sąrašų ištraukimas su išsamiais atributais.
- Duomenų apdorojimas: duomenų apdiorojimas prieš įterpiant į duomenų bazę.
- Duomenų bazės saugykla: efektyvus struktūrinių duomenų saugojimas MySQL duomenų bazėje.

#### Duomenų bazės schema:
![3](https://github.com/gabwowce/Real-Estate-Data-Collection-and-Analysis-Project/assets/134537965/8de41895-ff80-4bdd-8e70-7c9aa1685e69)


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
