import mysql.connector

class RealEstatePipeline(object):
    def open_spider(self, spider):
        self.connection = mysql.connector.connect(
            host=spider.settings.get('MYSQL_HOST'),
            user=spider.settings.get('MYSQL_USER'),
            passwd=spider.settings.get('MYSQL_PASSWORD'),
            database=spider.settings.get('MYSQL_DB_NAME')
        )
        self.cursor = self.connection.cursor(buffered=True)

    def close_spider(self, spider):
        self.cursor.close()
        self.connection.close()

    def process_item(self, item, spider):
        # Insert or get city
        try:
            self.cursor.execute("INSERT INTO Cities (CityName) VALUES (%s)", (item['city'],))
            city_id = self.cursor.lastrowid
        except mysql.connector.errors.IntegrityError:
            self.cursor.execute("SELECT CityID FROM Cities WHERE CityName = %s", (item['city'],))
            city_id = self.cursor.fetchone()[0]

        # Insert or get district
        try:
            self.cursor.execute("INSERT INTO Districts (DistrictName, CityID) VALUES (%s, %s)", (item['district'], city_id))
            district_id = self.cursor.lastrowid
        except mysql.connector.errors.IntegrityError:
            self.cursor.execute("SELECT DistrictID FROM Districts WHERE DistrictName = %s AND CityID = %s", (item['district'], city_id))
            district_id = self.cursor.fetchone()[0]

        # Insert or get street
        try:
            self.cursor.execute("INSERT INTO Streets (StreetName) VALUES (%s)",(item['street'],))
            street_id = self.cursor.lastrowid
        except mysql.connector.errors.IntegrityError:
            self.cursor.execute("SELECT StreetID FROM Streets WHERE StreetName = %s", (item['street'],))
            street_id = self.cursor.fetchone()[0]

        # Insert location
        try:
            self.cursor.execute("INSERT INTO Locations (CityID, DistrictID, StreetID) VALUES (%s, %s, %s)",(city_id, district_id, street_id))
            location_id = self.cursor.lastrowid
        except mysql.connector.errors.IntegrityError:
            self.cursor.execute("SELECT LocationID FROM Locations WHERE CityID = %s AND DistrictID = %s AND StreetID = %s", (city_id, district_id, street_id))
            location_id = self.cursor.fetchone()[0]

        self.cursor.execute("""SELECT EXISTS(
        SELECT 1 FROM listings l 
        LEFT JOIN locations lc ON l.LocationID = lc.LocationID
        WHERE Price = %s AND Area = %s
        AND Rooms = %s AND Floor = %s AND lc.CityID = %s AND lc.DistrictID = %s AND lc.StreetID = %s)""",
                            (item['price'], item['area'], item['rooms'], item['floor'], city_id, district_id, street_id))

        exists = self.cursor.fetchone()[0]

        if not exists:
            self.cursor.execute("""INSERT INTO Listings (`Price`, `LocationID`, `Area`, `Rooms`, `Floor`, `TotalFloors`, `Year`, `Heating`, `Condition`, `Status`)
                        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)""", (
                item['price'], location_id, item['area'], item['rooms'], item['floor'], item['total floor'],
                item['year'],
                item['heating'], item['condition'], item['status']))

            self.connection.commit()
        else:
            pass





        return item
