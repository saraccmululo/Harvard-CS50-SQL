--1.sql
--Your colleague is preparing a map of all public schools in Massachusetts. In 1.sql, write a SQL query to find the names and cities of all public schools in Massachusetts.

SELECT "name", "city" FROM "schools" WHERE "type" = 'Public School';

--2.sql
--Your team is working on archiving old data. In 2.sql, write a SQL query to find the names of districts that are no longer operational. Districts that are no longer operational have “(non-op)” at the end of their name.

SELECT "name" FROM "districts" WHERE "name" LIKE '%(non-op)';

--3.sql
--The Massachusetts Legislature would like to learn how much money, on average, districts spent per-pupil last year. In 3.sql, write a SQL query to find the average per-pupil expenditure. Name the column “Average District Per-Pupil Expenditure”. Note the per_pupil_expenditure column in the expenditures table contains the average amount, per pupil, each district spent last year. You’ve been asked to find the average of this set of averages, weighting all districts equally regardless of their size.
SELECT AVG("per_pupil_expenditure") AS "Average District Per-Pupil Expenditure" FROM "expenditures";


--4.sql
--Some cities have more public schools than others. In 4.sql, write a SQL query to find the 10 cities with the most public schools. Your query should return the names of the cities and the number of public schools within them, ordered from greatest number of public schools to least. If two cities have the same number of public schools, order them alphabetically.
SELECT "city", COUNT("city") FROM "schools" WHERE "type" = 'Public School' GROUP BY "city" ORDER BY COUNT("city") DESC, "city" ASC LIMIT 10;

--5.sql
--DESE would like you to determine in what cities additional public schools might be needed. In 5.sql, write a SQL query to find cities with 3 or fewer public schools. Your query should return the names of the cities and the number of public schools within them, ordered from greatest number of public schools to least. If two cities have the same number of public schools, order them alphabetically.
SELECT "city", COUNT("city") FROM "schools" WHERE "type"='Public School' GROUP BY "city" HAVING COUNT("city")<=3 ORDER BY COUNT("city") DESC, "city" ASC;


--6.sql
--DESE wants to assess which schools achieved a 100% graduation rate. In 6.sql, write a SQL query to find the names of schools (public or charter!) that reported a 100% graduation rate.
SELECT "name" FROM "schools" WHERE id IN (
    SELECT "school_id" FROM "graduation_rates" WHERE "graduated" =100);

--7.sql
--DESE is preparing a report on schools in the Cambridge school district. In 7.sql, write a SQL query to find the names of schools (public or charter!) in the Cambridge school district. Keep in mind that Cambridge, the city, contains a few school districts, but DESE is interested in the district whose name is “Cambridge.”
SELECT "name" FROM "schools" WHERE "district_id" = (
    SELECT "id" FROM "districts" WHERE "name" = 'Cambridge');

--8.sql
--A parent wants to send their child to a district with many other students. In 8.sql, write a SQL query to display the names of all school districts and the number of pupils enrolled in each.
SELECT "districts"."name", "expenditures"."pupils" FROM "districts" JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id";


--9.sql
--Another parent wants to send their child to a district with few other students. In 9.sql, write a SQL query to find the name (or names) of the school district(s) with the single least number of pupils. Report only the name(s).
SELECT "districts"."name" FROM "districts" JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id" WHERE "expenditures"."pupils" = (
    SELECT MIN(pupils) FROM expenditures
);

--10.sql
--In Massachusetts, school district expenditures are in part determined by local taxes on property (e.g., home) values. In 10.sql, write a SQL query to find the 10 public school districts with the highest per-pupil expenditures. Your query should return the names of the districts and the per-pupil expenditure for each.
SELECT "districts"."name", "expenditures"."per_pupil_expenditure" FROM "districts"
JOIN "expenditures" ON "districts"."id"="expenditures"."district_id"
WHERE "districts"."type" = 'Public School District'
ORDER BY "expenditures"."per_pupil_expenditure" DESC LIMIT 10;

--11.sql
--Is there a relationship between school expenditures and graduation rates? In 11.sql, write a SQL query to display the names of schools, their per-pupil expenditure, and their graduation rate. Sort the schools from greatest per-pupil expenditure to least. If two schools have the same per-pupil expenditure, sort by school name.You should assume a school spends the same amount per-pupil their district as a whole spends.
SELECT "schools"."name", "expenditures"."per_pupil_expenditure", "graduation_rates"."graduated" FROM "schools"
JOIN "districts" ON "schools"."district_id" = "districts"."id"
JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id"
JOIN "graduation_rates" ON "schools"."id" = "graduation_rates"."school_id"
ORDER BY "expenditures"."per_pupil_expenditure" DESC, "schools"."name" ASC;

--12.sql
--A parent asks you for advice on finding the best public school districts in Massachusetts. In 12.sql, write a SQL query to find public school districts with above-average per-pupil expenditures and an above-average percentage of teachers rated “exemplary”. Your query should return the districts’ names, along with their per-pupil expenditures and percentage of teachers rated exemplary. Sort the results first by the percentage of teachers rated exemplary (high to low), then by the per-pupil expenditure (high to low).
SELECT "districts"."name", "expenditures"."per_pupil_expenditure", "staff_evaluations"."exemplary"
FROM "districts"
JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id"
JOIN "staff_evaluations" ON "staff_evaluations"."district_id" = "districts"."id"
WHERE "districts"."type" = 'Public School District'
AND "expenditures"."per_pupil_expenditure" > (
SELECT AVG("per_pupil_expenditure") FROM "expenditures")
  AND "staff_evaluations"."exemplary" > (
SELECT AVG("exemplary") FROM "staff_evaluations")
ORDER BY "staff_evaluations"."exemplary" DESC, "expenditures"."per_pupil_expenditure" DESC;


--13.sql
--In 13.sql, write a SQL query to answer a question you have about the data! The query should: Involve at least one JOIN or subquery
--Question: List schools that graduate fewer than 70% of students
SELECT "schools"."name", "graduation_rates"."graduated","expenditures"."per_pupil_expenditure"
FROM "schools" JOIN "districts" ON "schools"."district_id" = "districts"."id"
JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id"
JOIN "graduation_rates" ON "schools"."id" = "graduation_rates"."school_id"
WHERE "graduated" < 70
ORDER BY "graduation_rates"."graduated" ASC;