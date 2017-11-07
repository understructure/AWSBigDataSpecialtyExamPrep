# Implementing Efficient and Reliable Producers with the Amazon Kinesis Producer Library

https://aws.amazon.com/blogs/big-data/implementing-efficient-and-reliable-producers-with-the-amazon-kinesis-producer-library/

## Scaling Considerations

To reduce overhead and increase throughput, the application must:

* batch records 
* implement parallel HTTP requests
* deal with transient failures
* perform retries as needed.
* provide monitoring 
* diagnose and troubleshoot issues

## Why Multithreading PutRecord Isn't A Good Approach

* incurs a large amount of CPU overhead from context switching between threads
* Sending records one by one also incurs large overheads from signature version 4 and HTTP, further consuming CPU cycles and network bandwidth
* Partially due to base64-encoding of payload
* also, if payload is ~350 bytes, HTTP header makes up over half the request
* Use PutRecords instead

## Potential issues with PutRecords

* PutRecords is **not atomic**
* PutRecords always returns a 200 result, even if some records within the batch have failed
* You must write code to check PutRecordsResult and take action as appropriate

**Three Considerations**

1.  **Different Types of Errors** - Can't recover from 4XX errors, for 5XX errors, perform an exponential backoff followed by a retry (only if max attempts hasn't been reached)
1.  **Partial Failures** - Check each record in **PutRecordsRequestEntry**
1.  **Backoff Strategies** - Add monitoring to determine if certain shards are having problems, handle issues accordingly


## Monitoring

* Metrics (CloudWatch)
* Realtime log analysis (RTLA) (CloudWatch Logs)
* Use KPL to make your ClickEvents class (or whatever) emit a metric

## Aggregation

* If your records are 350 bytes and Kinesis Streams can handle 1 MB or 1,000 records / second, we're still only at .35 megs per second.
* Use **aggregation** to combine, e.g., three records into one, so record size is now 1,050 bytes - can do 950 of these
* 950 * 1050 = .9975 MB
* 950 * 3 records per aggregated record = 2,850 records / second

### Aggregation - Considerations (KPL solves these for you?)

* Be careful about how you group records - ensure that the consumer application can still access all the records with the same partition key without having to perform distributed sorting or resorting to an application level map
* Add timestamps and timers to your components to support buffering scheme that will limit how long records can wait in buffers - this will prevent excessive delays
* Choose a binary format that's unambiguous for both the producer and the client to support aggregation and de-aggregation



## Architecture

[!architecture](../images/Image_1_Kinesis_KPL.png)
