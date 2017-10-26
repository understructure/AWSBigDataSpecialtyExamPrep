### Kinesis Streams Core Concepts

#### Shards - uniquely identified group of data records in a stream

**Single shard capacity**

<table>
  <tr>
    <td>Read</td>
    <td>2 MB / sec</td>
    <td>5 transactions / sec</td>
  </tr>
  <tr>
    <td>Write</td>
    <td>1 MB / sec</td>
    <td>1000 transactions / sec</td>
  </tr>
</table>


* Can create multiple shards per stream, for instance, with 2 shards:

<table>
  <tr>
    <td>Shards</td>
    <td>Total Read Rate</td>
    <td>Total Write Rate</td>
  </tr>
  <tr>
    <td>2</td>
    <td>2 MB * 2 = 4 MB / second
5 trans * 2 = 10 trans / second</td>
    <td>1 MB * 2 = 2 MB / second
1000 trans * 2 = 2000 trans / second</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td></td>
  </tr>
</table>


* **Resharding** - dynamically add or remove shards as data throughput changes

    * Shard split - divide 1 shard into 2

    * Shard merge - combine 2 shards into 1

#### Records - unit of data stored in a stream



Record consists of:

* **Partition key** - group data by shard

    * Tells you which shard data belongs to
    * Specified by applications putting data into a stream
    
* **Sequence number** - unique ID for records inserted into a shard

    * Think of it as a unique key that identifies a data blob
    * Assigned when a producer calls PutRecord or PutRecords operations to add data to a stream
    * You can’t use sequence numbers to logically separate data in terms of what shards they have come from, you can only do this using partition keys

* **Data (BLOB)** - Actual data producer adds to stream, max size (data payload after Base64-decoding) is 1 MB

#### Retention Period for data in Stream

* Default: 24 hours

* Maximum: 7 days

* Retention period can be changed through CLI

* If you change your retention period, there will be a charge for keeping your data longer in a Kinesis stream


#### **Data producers** 

3 ways producers put data to Kinesis Streams:

1. **Amazon Kinesis Streams API**

    * AWS SDK for Java
        * PutRecord - puts single data record - separate HTTP request for each record
        * PutRecords - puts multiple data records - recommended by AWS, will give you higher throughput

2. **Kinesis Producer Library (KPL)**

    * Configurable library to create producer apps that allow devs to achieve high write throughput to a Kinesis Stream
    * Write to one or more Kinesis Streams with auto-retry configurable mechanism
    * Collects records to write multiple records to multiple shards per request
    * Aggregate user records
    * Integrates Kinesis Client Library (de-aggregates records)
    * Monitoring - emits throughput, error, and other metrics to CloudWatch at Stream, Shard, or Producer level
    * **TAKEAWAY** - use KPL if you need to write thousands of events per second to Kinesis Streams
    
    * High performance - makes it easier to create Streams apps
    * High write throughput, can do complicated stuff like matching

    * Do **NOT** use KPL if:
        * Your producer app / use case cannot incur an additional processing delay - this delay is created by RecordMaxBufferedTime
        * **RecordMaxBufferedTime** - maximum amount of time a record spends being buffered
            * Larger values can result in better performance, but can delay records
            * Setting this too low can negatively impact throughput

    * **User Records** - A KPL user record is a blob of data that has particular meaning to the user. Examples include a JSON blob representing a UI event on a web site, or a log entry from a web server.
    * **Streams Records** - A Kinesis Streams record is an instance of the `Record` data structure defined by the Kinesis Streams service API. It contains a partition key, sequence number, and a blob of data.

    * Aggregation and Collection (Batching)

        * Help you to efficiently use shards, helps with better throughput
        * **Aggregation** - allows you to combine multiple **User** records into a single **Streams** record, helping improve per-shard throughput
              * Example: Single shard capability is 1MB/sec, 1000 transactions/sec.
              * With 1000 records at 500 bytes each, you're writing 0.5 MB/sec, so not as efficient as it could be.  Using aggregation can help
    * **Collection (Batching)** - Multiple **Streams** records are batched and sent in a single HTTP request with a call to PutRecords API operation - reduces number of HTTP requests
      * Helps increase throughput due to reduced overhead of not making separate HTTP requests

    * PutRecords operation sends multiple records to your stream per HTTP request (recommended approach for apps that require high throughput)
    * NOTE:  A single record failure does not stop the processing of subsequent records
    * Despite the failure of a single record, you'll still get a 200 OK response back if the other records in the PutRecords API call are successful
    * For partial failures, the PutRecordsResult method in the KPL can be used to detect individual record failures and retry the PUT based on the HTTP status code
    * [Implementing Efficient and Reliable Producers with the Amazon Kinesis Producer Library](https://aws.amazon.com/blogs/big-data/implementing-efficient-and-reliable-producers-with-the-amazon-kinesis-producer-library/)

* [Kinesis Producer Library Github repository](https://github.com/awslabs/amazon-kinesis-producer)

3. **Kinesis Agent**

    6. Standalone Java software application

    7. Install on Web, Log, or Database servers

    8. [Download & install from Github](https://github.com/awslabs/amazon-kinesis-agent) OR do yum install

    9. Can monitor multiple directories for files

    10. Can write to multiple streams

    11. Pre-process data before sent to stream

        3. Multi-line records to single-line format

        4. Convert from delimiter to JSON

        5. Convert from log format to JSON
        


* Kinesis Consumers a.k.a. Kinesis Applications

    * Kinesis Streams Applications using Kinesis Client Library (KCL)

    * KCL - consumes and processes data

    * KCL handles complex tasks
    
        * Load balancing across multiple instances
        * Responding to instance failures
        * Checkpointing processed records
        * Reacting on any re-sharding

* KCL supported languages:

    * Java
    * Node.js
    * .NET
    * Python
    * Ruby
    
 #### KCL Components
 
* Worker - on EC2 instance - a processing unit that maps to each application instance - has a record processor that processes data from a shard
* KCL automatically starts a worker for each shard
* If a node fails, the shard is then assigned to another node
* KCL - uses DynamoDB for checkpointing
* if a worker fails, KCL will restart processing of the shard at last known processed record
* Can run consumer app on an EC2 instance under an autoscaling group to replace failed instances or handle additional load
* KCL automatically load balances record processing across many instances
* Supports de-aggregation that were aggregated with the KPL


* Each Kinesis Streams app uses unique DynamoDB table to track app state - [really good info here](http://docs.aws.amazon.com/streams/latest/dev/kinesis-record-processor-ddb.html)
* Includes most recent checkpoint sequence value - a unique value across all shards in the stream 
* KCL uses the name of the Streams app to create the DynamoDB table, so table names have to be unique
* Each row in the DynamoDB table represents a shard that is being processed by your application, hash key is the ShardID


#### DynamoDB throughput

* KCL creates table w/ throughput of 10 reads / sec and 10 writes / sec, so increase provisioning throughput if you need to, common causes:

    * If your app does frequent checkpointing 
    * Stream has many shards
    * If this happens, you may need to add more provisioned throughput to the DynamoDB table

* Each row consists of:

    * **Shard ID** - hash key for the table
    * **checkpoint**: The most recent checkpoint sequence number for the shard. This value is unique across all shards in the stream.
    * **checkpointSubSequenceNumber**: When using the Kinesis Producer Library's aggregation feature, this is an extension to checkpoint that tracks individual user records within the Amazon Kinesis record.
    * **leaseCounter**: Used for lease versioning so that workers can detect that their lease has been taken by another worker.
    * **leaseKey**: A unique identifier for a lease. Each lease is particular to a shard in the stream and is held by one worker at a time.
    * **leaseOwner**: The worker that is holding this lease.
    * **ownerSwitchesSinceCheckpoint**: How many times this lease has changed workers since the last time a checkpoint was written.
    * **parentShardId**: Used to ensure that the parent shard is fully processed before processing starts on the child shards. This ensures that records are processed in the same order they were put into the stream.


#### For the exam:

* Know Kinesis Streams is used for streaming large amounts of data that needs to be processed quickly, and you need to build a custom application to process and analyze streaming data

* Know what shards are, know what the capacity is for a shard

* Know what a record is, know its components

* Retention period = 1 - 7 days

* Remember Kinesis Streams is NOT PERSISTENT STORAGE (duh)

* Know what a Data Producer is, know capabilities of the KPL

* Know what a Data Consumer is, and how KCL helps you develop consumer apps

* Additional throughput is needed for your DynamoDB application state table if you get provisioned throughput exception errors, and remember the two scenarios where this would happen:

    * If your app does frequent checkpointing 
    * Stream has many shards




#### These notes were from a previous iteration of this lecture, when it was split into two parts.  This content was not covered on the most recent iteration of this lecture


##### For the Exam

* Understand where you’d use SQS vs. Kinesis Streams

* Any scenario where you’re streaming large amounts of data that need to be processed quickly, think Streams

    * Firehose is also an option, covered here later

* Understand data producers and options on how data can produce data to a stream

    * KPL
    * Agent
    * API


##### **Kinesis Streams vs. SQS**

* Streams can process same data records at the same time (or different times) within 24 hours to 7 days by different consumers
* Data can be replayed within this window if required
* SQS retention period is 14 days

