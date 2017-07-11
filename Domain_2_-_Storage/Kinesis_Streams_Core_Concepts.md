### Kinesis Streams Core Concepts Part 1	### Kinesis Streams Core Concepts Part 2
	
#### **Data producers** 	#### Records - unit of data stored in a stream
	
3 ways producers put data to Kinesis Streams:	Record consists of:
	
1. **Amazon Kinesis Streams API**	* **Sequence number** - unique ID for records inserted into a shard
	
    1. AWS SDK for Java	    * Think of it as a unique key that identifies a data blob
	
        1. PutRecord - puts single data record	    * Assigned when a producer calls PutRecord or PutRecords operations to add data to a stream
	
        2. PutRecords - puts multiple data records - recommended by AWS, will give you higher throughput	    * You can’t use sequence numbers to logically separate data in terms of what shards they have come from, you can only do this using partition keys
	
2. **Kinesis Producer Library (KPL) **	* **Partition key** - group data by shard
	
    2. high performance - makes it easier to create Streams apps 	    * Tells you which shard data belongs to
	
    3. high write throughput, can do complicated stuff like matching	    * Specified by applications putting data into a stream
	
    4. Monitoring - at Stream, Shard, or Producer level	* **Data (BLOB)** - Actual data producer adds to stream, max size (data payload after Base64-decoding) is 1 MB
	
    5. [Kinesis Producer Library Github repository](https://github.com/awslabs/amazon-kinesis-producer)	#### Retention Period for data in Stream
	
3. **Kinesis Agent**	* Default: 24 hours
	
    6. Standalone Java software application	* Maximum: 7 days
	
    7. Install on Web, Log, or Database servers	* Retention period can be changed through CLI
	
    8. [Download & install from Github](https://github.com/awslabs/amazon-kinesis-agent) OR do yum install	* If you change your retention period, there will be a charge for keeping your data longer in a Kinesis stream
	
    9. Can monitor multiple directories for files	* Kinesis Consumers a.k.a. Kinesis Applications
	
    10. Can write to multiple streams	* Kinesis Streams Applications using Kinesis Client Library (KCL)
	
    11. Pre-process data before sent to string	* KCL - consumes and processes data
	
        3. Multi-line records to single-line format	* KCL handles complex tasks
	
        4. Convert from delimiter to JSON	    * Load balancing across multiple instances
	
        5. Convert from log format to JSON	    * Responding to instance failures
	
#### Shards - uniquely identified group of data records in a stream	    * Checkpointing processed records
	
**Single shard capacity **	    * Reacting on any re-sharding
	
<table>	* KCL supported languages:
  <tr>	
    <td>Read</td>	    * Java
    <td>2 MB / sec, 5 transactions / sec</td>	
  </tr>	    * Node.js
  <tr>	
    <td>Write</td>	    * .NET
    <td>1 MB / sec, 1000 transactions / sec</td>	
  </tr>	    * Python
</table>	
	    * Ruby
	
* Can create multiple shards per stream, for instance:	* Each app uses unique DynamoDB table to track app state - really good info here: [http://docs.aws.amazon.com/streams/latest/dev/kinesis-record-processor-ddb.html](http://docs.aws.amazon.com/streams/latest/dev/kinesis-record-processor-ddb.html)
	
<table>	* Each row in the DynamoDB table represents a shard that is being processed by your application, each row consists of:
  <tr>	
    <td>Shards</td>	    * **Shard ID** - hash key for the table
    <td>Total Read Rate</td>	
    <td>Total Write Rate</td>	    * **checkpoint**: The most recent checkpoint sequence number for the shard. This value is unique across all shards in the stream.
  </tr>	
  <tr>	    * **checkpointSubSequenceNumber**: When using the Kinesis Producer Library's aggregation feature, this is an extension to checkpoint that tracks individual user records within the Amazon Kinesis record.
    <td>2</td>	
    <td>2 MB * 2 = 4 MB / second	    * **leaseCounter**: Used for lease versioning so that workers can detect that their lease has been taken by another worker.
5 trans * 2 = 10 trans / second</td>	
    <td>1 MB * 2 = 2 MB / second	    * **leaseKey**: A unique identifier for a lease. Each lease is particular to a shard in the stream and is held by one worker at a time.
1000 trans * 2 = 2000 trans / second</td>	
  </tr>	    * **leaseOwner**: The worker that is holding this lease.
  <tr>	
    <td></td>	    * **ownerSwitchesSinceCheckpoint**: How many times this lease has changed workers since the last time a checkpoint was written.
    <td></td>	
    <td></td>	    * **parentShardId**: Used to ensure that the parent shard is fully processed before processing starts on the child shards. This ensures that records are processed in the same order they were put into the stream.
  </tr>	
</table>	* KCL uses the name of the Streams app to create the DynamoDB table, so table names have to be unique
	
	* **DynamoDB throughput **- KCL creates table w/ throughput of 10 reads / sec and 10 writes / sec, so increase provisioning throughput if you need to, common causes:
* **Resharding** - dynamically add or remove shards as data throughput changes	
	    * if your app does frequent checkpointing 
    * Shard split - divide 1 shard into 2	
	    * stream has many shards
    * Shard merge - combine 2 shards into 1	
	* **Kinesis Streams vs. SQS**
For the exam:	
	* Streams can process same data records at the same time (or different times) within 24 hours to 7 days by different consumers
* Any scenario where you’re streaming large amounts of data that need to be processed quickly, think Streams	
	* Data can be replayed within this window if required
    * Firehose is also an option, covered here later	
	* SQS retention period is 14 days
* Understand data producers and options on how data can produce data to a stream	
	**For the exam:**
    * KPL	
	* Know what a record is, know its components
    * Agent	
	* Retention period = 1 - 7 days
    * API	
	* Know what a Data Consumer is, and how KCL helps you develop consumer apps
* Know what shards are, know what the capacity is for a shard	
	* Remember Kinesis Streams is NOT PERSISTENT STORAGE (duh)
	
	* Understand where you’d use SQS vs. Kinesis Streams
