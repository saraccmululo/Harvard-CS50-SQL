--1) The app’s user engagement team needs to identify active users.
--Find all usernames of users who have logged in since 2024-01-01.
--Ensure your query uses the search_users_by_last_login index, which is defined as follows:

--CREATE INDEX "search_users_by_last_login"
--ON "users"("last_login_date");

SELECT "username" FROM "users" WHERE "last_login_date" > '2024-01-01';

--2) Users need to be prevented from re-opening a message that has expired.
--Find when the message with ID 151 expires.
--You may use the message’s ID directly in your query.
--Ensure your query uses the index automatically created on the primary key column of the messages table.

SELECT "expires_timestamp" FROM "messages" WHERE "id" = 151;


--3) The app needs to rank a user’s “best friends,” similar to Snapchat’s “Friend Emojis” feature.
--Find the user IDs of the top 3 users to whom creativewisdom377 sends messages most frequently.
--Order the user IDs by the number of messages creativewisdom377 has sent to those users, most to least.

--Ensure your query uses the search_messages_by_from_user_id index, which is defined as follows:
--CREATE INDEX "search_messages_by_from_user_id" ON "messages"("from_user_id");


SELECT "messages"."to_user_id" FROM "users"
JOIN "messages" ON "messages"."to_user_id" = "users"."id"
WHERE "messages"."from_user_id" = (SELECT "id" FROM "users" WHERE "username"='creativewisdom377')
GROUP BY "messages"."to_user_id"
ORDER BY COUNT("to_user_id") DESC LIMIT 3;


--4) The app needs to send users a summary of their engagement.
--Find the username of the most popular user, defined as the user who has had the most messages sent to them.
--Ensure your query uses the search_messages_by_to_user_id index, which is defined as follows:
--CREATE INDEX "search_messages_by_to_user_id" ON "messages"("to_user_id");

SELECT "users"."username" FROM "users"
JOIN "messages" ON "messages"."to_user_id" = "users"."id"
GROUP BY "messages"."to_user_id"
ORDER BY COUNT("messages"."to_user_id")  DESC
LIMIT 1;

--5) For any two users, the app needs to quickly show a list of the friends they have in common.
--Given two usernames, lovelytrust487 and exceptionalinspiration482, find the user IDs of their mutual friends.
--A mutual friend is a user that both lovelytrust487 and exceptionalinspiration482 count among their friends.

--Ensure your query uses the index automatically created on primary key columns of the friends table.
--This index is called sqlite_autoindex_friends_1.

--Need a hint?
--Recall that, in SQL, you can use certain keywords to find the intersection of two groups.
--See Week 1’s notes for a refresher.

SELECT "friends"."friend_id" FROM "friends"
JOIN "users" ON "users"."id" = "friends"."user_id"
WHERE "user_id" =(SELECT "id" FROM "users" WHERE "username"='lovelytrust487')

INTERSECT

SELECT "friends"."friend_id" FROM "friends"
JOIN "users" ON "users"."id" = "friends"."user_id"
WHERE "user_id" =(SELECT "id" FROM "users" WHERE "username"='exceptionalinspiration482');