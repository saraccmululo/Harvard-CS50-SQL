DROP TABLE IF EXISTS "codes";
DROP VIEW IF EXISTS "message";

--1) Create code table to store the code numbers
    CREATE TABLE "codes" (
        "sentence_id" INTEGER,
        "first_char" INTEGER,
        "length" INTEGER
    );

--2) Populate code table with the numbers
    INSERT INTO "codes" ("sentence_id", "first_char", "length")
     VALUES ('14','98','4'),
            ('114','3','5'),
            ('618','72','9'),
            ('630','7','3'),
            ('932','12','5'),
            ('2230','50','7'),
            ('2346','44','10'),
            ('3041','14','5');

--3)create the substr query
    SELECT substr("sentence", "first_char", "length") FROM "sentences"
    JOIN "codes" ON "codes"."sentence_id"="sentences"."id";

--4)create a view table for the substr query

CREATE VIEW "message" AS
    SELECT substr("sentence", "first_char", "length") AS "phrase" FROM "sentences"
    JOIN "codes" ON "codes"."sentence_id"="sentences"."id";
