# Nekilnojamojo turto duomenų rinkimo ir analizė projektas


Šiame projekte Scrapy voras (Scraping_real_estate failas), skirtas skrebinti nekilnojamojo turto sąrašus iš Lietuvos nekilnojamojo turto svetainės domoplius.lt. Pagrindinis tikslas yra rinkti duomenis apie nekilnojamojo turto pardavimą ir nuomą, įskaitant tokią informaciją kaip kaina, vieta, plotas, kambarių skaičius, būklė ir šildymo tipas. Duomenys saugomi MySQL duomenų bazėje, užtikrinant, kad kiekvienas miestas, rajonas ir gatvės įrašas būtų unikalus ir tinkamai nurodytas.

- Duomenų išgryninimas: automatizuotas nekilnojamojo turto sąrašų ištraukimas su išsamiais atributais.
- Duomenų apdorojimas: duomenų apdiorojimas prieš įterpiant į duomenų bazę.
- Duomenų bazės saugykla: efektyvus struktūrinių duomenų saugojimas MySQL duomenų bazėje.

#### Duomenų bazės schema:
![2](https://github.com/gabwowce/Real-Estate-Data-Collection-and-Analysis-Project/assets/134537965/86304f48-a8a5-46e7-b8b7-1aac388d008a)


# Nekilnojamojo turto duomenų analizė

Tikslas: Apskaičiuoti vidutinę kvadratinio metro kainą nekilnojamojo turto skelbimuose, atsižvelgiant į įvairius aspektus, tokius kaip miestas/rajonas, būsto būklė, šildymo tipas ir nekilnojamojo turto statusas. Ši analizė padės suprasti, kaip šie veiksniai įtakoja nekilnojamojo turto kainodarą skirtingose vietovėse ir situacijose.

## Parduodamų būtų analizė

#### Bendra vidutinė butų Lietuvoje kvadratinio metro kaina: 
```sql
SELECT ROUND(AVG(price/area),4) 
AS Vidutinė_m2_kaina_Lietuvoje 
FROM listings l 
WHERE Status = "For Sale"
```
Rezultatas:

![4](https://github.com/gabwowce/Real-Estate-Data-Collection-and-Analysis-Project/assets/134537965/13b93ce2-5f17-4f51-803f-3977ecfc33c8)

#### Vidutinė butų Lietuvoje kvadratinio metro kaina pagal lokacija: 
- Pagal miestą/rajoną:
```sql
SELECT CityName, ROUND(AVG(price/area),4) 
AS Vidutinė_m2_kaina 
FROM listings l 
LEFT JOIN locations l2 ON l.LocationID = l2.LocationID
LEFT JOIN cities c ON l2.CityID = c.CityID 
WHERE Status = "For Sale"
GROUP BY CityName 
ORDER BY Vidutinė_m2_kaina DESC 
```
Rezultatas:

![6](https://github.com/gabwowce/Real-Estate-Data-Collection-and-Analysis-Project/assets/134537965/fa695200-903d-49ab-ae5f-fee1b825d055)

...

![5](https://github.com/gabwowce/Real-Estate-Data-Collection-and-Analysis-Project/assets/134537965/10bad50b-c9d9-4105-bdbc-a87f0fa38fc0)

- Pagal miestą ir rajoną:
```sql
SELECT CityName, DistrictName, ROUND(AVG(price/area),4) 
AS Vidutinė_m2_kaina 
FROM listings l 
LEFT JOIN locations l2 ON l.LocationID = l2.LocationID
LEFT JOIN cities c ON l2.CityID = c.CityID 
LEFT JOIN districts d ON l2.DistrictID = d.DistrictID 
WHERE Status = "For Sale"
GROUP BY CityName, DistrictName 
ORDER BY Vidutinė_m2_kaina DESC 
```
Rezultatas:

![7](https://github.com/gabwowce/Real-Estate-Data-Collection-and-Analysis-Project/assets/134537965/8e4760d8-f57f-4953-967b-a686e5e87694)

...

![8](https://github.com/gabwowce/Real-Estate-Data-Collection-and-Analysis-Project/assets/134537965/7fd8de34-afc3-4830-affb-687c7ba16d40)

- Pagal miest1 ir gatvę:
```sql
SELECT CityName, DistrictName, StreetName, ROUND(AVG(price/area),4) 
AS Vidutinė_m2_kaina 
FROM listings l 
LEFT JOIN locations l2 ON l.LocationID = l2.LocationID
LEFT JOIN cities c ON l2.CityID = c.CityID 
LEFT JOIN districts d ON l2.DistrictID = d.DistrictID 
LEFT JOIN streets s ON l2.StreetID  = s.StreetID 
WHERE Status = "For Sale"
GROUP BY CityName, DistrictName, StreetName 
ORDER BY Vidutinė_m2_kaina DESC 
```
Rezultatas:

![9](https://github.com/gabwowce/Real-Estate-Data-Collection-and-Analysis-Project/assets/134537965/916d9567-be9b-43d4-8a46-15da3423414b)

...

![10](https://github.com/gabwowce/Real-Estate-Data-Collection-and-Analysis-Project/assets/134537965/0066e296-6671-4366-b187-004e22b209d6)

#### Vidutinė butų Lietuvoje kvadratinio metro kaina pagal būsto būklę: 
- Bendras vidurkis:
```sql
SELECT `Condition`, ROUND(AVG(price/area), 4) 
AS Vidutinė_m2_kaina_Lietuvoje
FROM listings
WHERE Status = "For Sale"
GROUP BY `Condition`
ORDER BY Vidutinė_m2_kaina_Lietuvoje DESC 
```
Rezultatas:

![image](https://github.com/gabwowce/Real-Estate-Data-Collection-and-Analysis-Project/assets/134537965/c67528eb-fbf1-46fc-905f-db9105fd36c9)

- Vidurkis pagal miestą/rajoną ir būto buklę:
```sql
SELECT CityName, DistrictName, `Condition`, ROUND(AVG(price/area),4) 
AS Vidutinė_m2_kaina 
FROM listings l 
LEFT JOIN locations l2 ON l.LocationID = l2.LocationID
LEFT JOIN cities c ON l2.CityID = c.CityID 
LEFT JOIN districts d ON l2.DistrictID = d.DistrictID 
LEFT JOIN streets s ON l2.StreetID  = s.StreetID 
WHERE Status = "For Sale"
GROUP BY CityName, DistrictName, `Condition`
ORDER BY Vidutinė_m2_kaina DESC 
```
Rezultatas:

![image](https://github.com/gabwowce/Real-Estate-Data-Collection-and-Analysis-Project/assets/134537965/d4313a7a-f0ee-494c-a827-afed0c03b581)

...

![image](https://github.com/gabwowce/Real-Estate-Data-Collection-and-Analysis-Project/assets/134537965/ce4452a2-9052-43ea-8542-067fe91a5353)

#### Vidutinė butų Lietuvoje kvadratinio metro kaina pagal šildymo tipą: 
- Bendras vidurkis
```sql
SELECT Heating, ROUND(AVG(price/area), 4) 
AS Vidutinė_m2_kaina_Lietuvoje
FROM listings
WHERE Status = "For Sale"
GROUP BY Heating
ORDER BY Vidutinė_m2_kaina_Lietuvoje DESC 
```
Rezultatas:

![image](https://github.com/gabwowce/Real-Estate-Data-Collection-and-Analysis-Project/assets/134537965/51cc9ad1-73c3-4901-bc46-65242756b7ac)

- Vidurkis pagal miestą/rajoną ir šildymo tipą:
```sql
SELECT CityName, DistrictName, Heating, ROUND(AVG(price/area),4) 
AS Vidutinė_m2_kaina 
FROM listings l 
LEFT JOIN locations l2 ON l.LocationID = l2.LocationID
LEFT JOIN cities c ON l2.CityID = c.CityID 
LEFT JOIN districts d ON l2.DistrictID = d.DistrictID 
LEFT JOIN streets s ON l2.StreetID  = s.StreetID 
WHERE Status = "For Sale"
GROUP BY CityName, DistrictName, Heating
ORDER BY Vidutinė_m2_kaina DESC 
```
Rezultatas:

![image](https://github.com/gabwowce/Real-Estate-Data-Collection-and-Analysis-Project/assets/134537965/abd51fed-d0cb-4fd2-8b9a-983ed5d23e10)

...

![image](https://github.com/gabwowce/Real-Estate-Data-Collection-and-Analysis-Project/assets/134537965/72f6eb0f-30aa-4d89-a4be-e652dc7c9a0b)

## Išvados
- #### Kvadratinio metro kainos analizė: 

Analizė parodė, kad vidutinė kvadratinio metro kaina Lietuvoje priklauso nuo daugelio veiksnių, įskaitant miestą/rajoną, būsto būklę ir šildymo tipą. Tai rodo, kad nekilnojamojo turto rinka yra labai įvairi ir dinamiška.

- #### Lokacijos įtaka kainai:

Miesto, rajono ir net gatvės pasirinkimas labai įtakoja vidutinę kvadratinio metro kainą, parodant, kad lokacija yra vienas iš pagrindinių veiksnių, lemiančių nekilnojamojo turto vertę.

- #### Būsto būklės svarba: 

Būsto būklė taip pat yra svarbus veiksnys, nustatant nekilnojamojo turto kainą. Projekto duomenys rodo, kad skirtingų būsto būklių objektų kvadratinio metro kainos labai skiriasi.

- #### Šildymo tipo įtaka: 

Šildymo tipo analizė atskleidė, kad skirtingi šildymo būdai gali turėti įtakos nekilnojamojo turto kainai, rodant, kad energetinio efektyvumo savybės yra svarbios tiek pirkėjams, tiek pardavėjams.



<sub>Norint išsamesnės analizės, reikėtų atlikti multivariacinę analizę, pavyzdžiui, naudojant regresijos modelius, kurie gali atskleisti kiekvieno veiksnio indėlį, kontroliuojant kitų veiksnių įtaką.</sub>
