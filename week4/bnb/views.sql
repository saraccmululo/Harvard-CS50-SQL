--In no_descriptions.sql, write a SQL statement to create a view named no_descriptions
--that includes all of the columns in the listings table except for description.
CREATE VIEW "no_descriptions" AS
SELECT "id", "property_type", "host_name", "accomodates", "bedrooms" FROM "listings";

--In one_bedrooms.sql, write a SQL statement to create a view named one_bedrooms.
--This view should contain all listings that have exactly one bedroom.
--Ensure the view contains the following columns:

--id, which is the id of the listing from the listings table.
--property_type, from the listings table.
--host_name, from the listings table.
--accommodates, from the listings table.


CREATE VIEW "one_bedrooms" AS
SELECT "id", "property_type", "host_name", "accommodates" FROM "listings"
WHERE "bedrooms" = 1;

--In available.sql, write a SQL statement to create a view named available.
--This view should contain all dates that are available at all listings. Ensure the view contains the following columns:

--id, which is the id of the listing from the listings table.
--property_type, from the listings table.
--host_name, from the listings table.
--date, from the availabilities table, which is the date of the availability.

CREATE VIEW "available" AS
SELECT "listings"."id", "listings"."property_type", "listings"."host_name", "availabilities"."date" FROM "availabilities"
JOIN "listings" ON "listings"."id"="availabilities"."listing_id"
WHERE "availabilities"."available" = 'TRUE';

--In frequently_reviewed.sql, write a SQL statement to create a view named frequently_reviewed.
--This view should contain the 100 most frequently reviewed listings, sorted from most- to least-frequently reviewed.

--Ensure the view contains the following columns:
--id, which is the id of the listing from the listings table.
--property_type, from the listings table.
--host_name, from the listings table.
--reviews, which is the number of reviews the listing has received.
--If any two listings have the same number of reviews, sort by property_type (in alphabetical order), followed by host_name (in alphabetical order).

CREATE VIEW "frequently_reviewed" AS
SELECT "listings"."id", "listings"."property_type", "listings"."host_name", COUNT("reviews"."listing_id") AS "reviews"
FROM "listings" JOIN "reviews" ON "listings"."id" = "reviews"."listing_id"
GROUP BY "listings"."id", "listings"."property_type", "listings"."host_name" --Rule: Every non-aggregated column in SELECT must appear in GROUP BY.
ORDER BY "reviews" DESC, "listings"."property_type", "listings"."host_name"
LIMIT 100;

--In june_vacancies.sql, write a SQL statement to create a view named june_vacancies.
--This view should contain all listings and the number of days in June of 2023 that they remained vacant.
--Ensure the view contains the following columns:

--id, which is the id of the listing from the listings table.
--property_type, from the listings table.
--host_name, from the listings table.
--days_vacant, which is the number of days in June of 2023, that the given listing was marked as available.

CREATE VIEW "june_vacancies" AS
SELECT "listings"."id", "listings"."property_type", "listings"."host_name", COUNT("availabilities"."available") AS "days_vacant"
FROM "listings"
JOIN "availabilities" ON "availabilities"."listing_id" = "listings"."id"
WHERE ("availabilities"."date" BETWEEN '2023-06-01' AND '2023-06-30')
AND ("availabilities"."available" = 'TRUE')
GROUP BY "listings"."id", "listings"."property_type", "listings"."host_name";
