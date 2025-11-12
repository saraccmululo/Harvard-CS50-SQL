-- *** The Lost Letter ***
--1. Find the id of address_from and address_to on the addresses table
SELECT "id" FROM "addresses" WHERE "address" = '900 Somerville Avenue';
--address_from: id 432
SELECT * FROM "addresses" WHERE "address" LIKE '2 Fin%';
--address_to: id 854, 2 Finnigan Street, Residential.

--3. Find the package content and id on the packages table:
SELECT "id", "contents" FROM "packages" WHERE "from_address_id"=432 AND "to_address_id"=854;
--package id: 384, contents "congrulatory letter"

--4.Find the address_id and timestamp of the last time the package was scanned on scans table:
SELECT "address_id", "timestamp" FROM "scans" WHERE "package_id" = 384;
--timestamp: 2023-07-11 19:33:55.241794 -address_id: 432
--timestamp: 2023-07-11 23:07:04.432178 -address_id: 854

--5.Find the final address and type on address table.
SELECT "address", "type" FROM "addresses" WHERE "id" = 854;
--2 Finnigan Street | Residential


-- *** The Devious Delivery ***
--1.Find the package on the packages table where from address is null:
SELECT * FROM "packages" WHERE "from_address_id" IS NULL;
--package id 5098, contents "Duck Debugger", to address id 50.

--2. Find the address_to on addresses table in which id = 50.
SELECT * FROM "addresses" WHERE "id"=50;
--address id 50, 123 Sesame Street, type Residential.

--3. Find the address location the package was last scanned on scans table:
SELECT * FROM "scans" WHERE "package_id" = 5098;
--address_id:50, action: Pick, timestamp:2023-10-24 08:40:16.246648
--address_id:348, action: Drop, timestamp: 2023-10-24 10:08:55.610754

--4. Find the address with id 348 where the package was delivered on addresses table:
SELECT * FROM "addresses" WHERE "id" = 348;
--address: 7 Humboldt Place, type: Police Station.

-- *** The Forgotten Gift ***
--1. Find out the address_to and address_from ids on addresses table:
SELECT "id", "address" FROM "addresses" WHERE "address" IN ('728 Maple Place', '109 Tileston Street');
--address_to: id 4983
--address_from: id 9873

--2.Find out the package content and id in packages table:
SELECT "id", "contents" FROM "packages" WHERE "from_address_id" = 9873 AND "to_address_id"=4983;
--package_id=9523, contents: Flowers

--3. Find the driver_id on the scans table in which package_id=9523:
SELECT * FROM "scans" WHERE "package_id" = 9523;
--driver_id 11 pick package at grandparent address 109 Tileston Street (address_id 9873)
--on timestamp 2023-08-16 21:41:43.
--driver_id 11 drop it on address_id 7432, 950 Brannon Harris Way, type Warehouse
--on timestamp 2023-08-17 03:31:36
--driver_id 17 pick the package on address_id 7432, 950 Brannon Harris Way, warehouse,
--on timestamp 2023-08-23 19:41:47

SELECT * FROM "addresses" WHERE "id" = 7432;
--adress 950 Brannon Harris Way, type Warehouse.


--4. Find the drivers name on drivers table:
SELECT "id", "name" FROM "drivers" WHERE "id" IN (11, 17);
--driver_id 11: Maegan
--driver_id: 17 Mikel.
