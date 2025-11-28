# From the Deep

In this problem, you'll write freeform responses to the questions provided in the specification.

## Random Partitioning

Random partitioning helps prevent overloading a single server since data is more evenly distributed across all servers. However, the downside of the data being randomly assigned to any boat is that the queries may take longer to run since they need to be executed on every server.

## Partitioning by Hour

Partitioning by hour allows queries to run only on the server that stores data for that particular time frame, which can speed up the query performance. However, there is a risk of overloading a specific server if the activity in that time frame is higher than in others.

## Partitioning by Hash Value

Partitioning data by hash value helps distribute data more evenly distributed across servers, avoiding server overloading. This is because a hash function tends to assign values uniformly, so it's unlikely that one server will receive more data than the others. Another advantage is that you can use the hash number to retrieve the time stamp for an observation, which makes easier to narrow down the servers that contain the data we're looking for. However, if you need to query a range of data, this method can slowing down the query performance since the pieces of data could be spread across multiple servers.
