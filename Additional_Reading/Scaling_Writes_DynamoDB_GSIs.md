
# Scaling Writes on Amazon DynamoDB Tables with Global Secondary Indexes

https://aws.amazon.com/blogs/big-data/scaling-writes-on-amazon-dynamodb-tables-with-global-secondary-indexes/

* LSIs use the table’s existing hash key plus another attribute for access (as a range key)
* GSIs give us the ability to select a totally different hash key and range key
* For both LSIs and GSIs, we can choose which table attributes to project into an index
* Events per number of seconds downsampled calculation:

`((EventsReceived / EventsPerSecond) * UniqueReferrerCount) / NumberOfSecondsDownsampled`

Though I like this better:

`((EventsReceived * UniqueReferrerCount / EventsPerSecondPerReferrer) ) / NumberOfSecondsDownsampled`

* We don’t just require this write IOPS for the table, but also for the global secondary index on the hash key
* At most, DynamoDB offers approximately 1000 writes/second to a single hash key value on a partition
* Hash keys on GSIs have the same limitation that the table's main hash key does - if you've only got a single hash key value being written to on a GSI, we're only writing to a single partition, which can cause bottlenecks
* If this throttling occurs, because global secondary indexes are written asynchronously, we also observe an increased latency between the write to the table and the update of the secondary index
* **Scattering** - Use a scattered value column as the hash key for the GSI, gets a random number between, say, 0-99, and use the other value as the range key for the GSI
    * This scenario allows DynamoDB to scale up to 100 partitions if necessary
    * This prevents the previously-observed throttling and latency between table and GSI
* To query, we have to query on the scattered value as well as the meaningful one (range key now), but you can have your app do, e.g., 10 threads to scan ranges of 10 scattered values each





