DROP TABLE IF EXISTS "meteorites_temp";
DROP TABLE IF EXISTS "meteorites";

--create tables schema
CREATE TABLE "meteorites_temp" (
    "name" TEXT,
    "id" INTEGER,
    "nametype" TEXT,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT,
    "year" REAL,
    "lat" REAL,
    "long" REAL
);

CREATE TABLE "meteorites" (
    "id" INTEGER NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "class" TEXT NOT NULL,
    "mass" REAL,
    "discovery" TEXT CHECK("discovery" IN ('Fell', 'Found')),
    "year" INTEGER,
    "lat" REAL,
    "long" REAL
);
--import csv into temp table:
.import --csv --skip 1 meteorites.csv meteorites_temp

--clean the data:
UPDATE "meteorites_temp" SET
    "mass" = NULLIF("mass", ''),
    "year" = NULLIF("year", ''),
    "lat" = NULLIF("lat", ''),
    "long" = NULLIF("long", '');
UPDATE "meteorites_temp" SET "mass" = ROUND("mass",2), "lat"= ROUND("lat", 2), "long" = ROUND("long", 2);
DELETE FROM "meteorites_temp" WHERE "nametype" = 'Relict';


--INSERT temp table rows into final table (apply order and new IDs).
INSERT INTO "meteorites" ("id", "name", "class", "mass", "discovery", "year", "lat", "long")
SELECT  ROW_NUMBER() OVER (ORDER BY "year" ASC, "name" ASC) AS "id",
"name", "class", "mass", "discovery", "year", "lat", "long"
FROM "meteorites_temp";

--Delete ttthe temp table
DROP TABLE "meteorites_temp";
