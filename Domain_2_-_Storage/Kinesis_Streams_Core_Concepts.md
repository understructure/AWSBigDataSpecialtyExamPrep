### Kinesis Streams Core Concepts Part 1

#### **Data producers** 

3 ways producers put data to Kinesis Streams:

1. **Amazon Kinesis Streams API**

    1. AWS SDK for Java

        1. PutRecord - puts single data record

        2. PutRecords - puts multiple data records - recommended by AWS, will give you higher throughput

2. **Kinesis Producer Library (KPL) **

    2. high performance - makes it easier to create Streams apps 

    3. high write throughput, can do complicated stuff like matching

    4. Monitoring - at Stream, Shard, or Producer level

    5. [Kinesis Producer Library Github repository](https://github.com/awslabs/amazon-kinesis-producer)

3. **Kinesis Agent**

    6. Standalone Java software application

    7. Install on Web, Log, or Database servers

    8. [Download & install from Github](https://github.com/awslabs/amazon-kinesis-agent) OR do yum install

    9. Can monitor multiple directories for files

    10. Can write to multiple streams

    11. Pre-process data before sent to string

        3. Multi-line records to single-line format

        4. Convert from delimiter to JSON

        5. Convert from log format to JSON

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

For the exam:

* Any scenario where you’re streaming large amounts of data that need to be processed quickly, think Streams

    * Firehose is also an option, covered here later

* Understand data producers and options on how data can produce data to a stream

    * KPL

    * Agent

    * API

* Know what shards are, know what the capacity is for a shard

### Kinesis Streams Core Concepts Part 2

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

* Each app uses unique DynamoDB table to track app state - really good info here: [http://docs.aws.amazon.com/streams/latest/dev/kinesis-record-processor-ddb.html](http://docs.aws.amazon.com/streams/latest/dev/kinesis-record-processor-ddb.html)

* Each row in the DynamoDB table represents a shard that is being processed by your application, each row consists of:

    * **Shard ID** - hash key for the table

    * **checkpoint**: The most recent checkpoint sequence number for the shard. This value is unique across all shards in the stream.

    * **checkpointSubSequenceNumber**: When using the Kinesis Producer Library's aggregation feature, this is an extension to checkpoint that tracks individual user records within the Amazon Kinesis record.

    * **leaseCounter**: Used for lease versioning so that workers can detect that their lease has been taken by another worker.

    * **leaseKey**: A unique identifier for a lease. Each lease is particular to a shard in the stream and is held by one worker at a time.

    * **leaseOwner**: The worker that is holding this lease.

    * **ownerSwitchesSinceCheckpoint**: How many times this lease has changed workers since the last time a checkpoint was written.

    * **parentShardId**: Used to ensure that the parent shard is fully processed before processing starts on the child shards. This ensures that records are processed in the same order they were put into the stream.

* KCL uses the name of the Streams app to create the DynamoDB table, so table names have to be unique

* **DynamoDB throughput **- KCL creates table w/ throughput of 10 reads / sec and 10 writes / sec, so increase provisioning throughput if you need to, common causes:

    * if your app does frequent checkpointing 

    * stream has many shards

* **Kinesis Streams vs. SQS**

* Streams can process same data records at the same time (or different times) within 24 hours to 7 days by different consumers

* Data can be replayed within this window if required

* SQS retention period is 14 days

**For the exam:**

* Know what a record is, know its components

* Retention period = 1 - 7 days

* Know what a Data Consumer is, and how KCL helps you develop consumer apps

* Remember Kinesis Streams is NOT PERSISTENT STORAGE (duh)

* Understand where you’d use SQS vs. Kinesis Streams

