

# Optimize Spark-Streaming to Efficiently Process Amazon Kinesis Streams

https://aws.amazon.com/blogs/big-data/optimize-spark-streaming-to-efficiently-process-amazon-kinesis-streams/

* Spark Streaming uses the Amazon Kinesis Client Library (KCL) to consume data from an Amazon Kinesis stream.
* [Spark Streaming + Kinesis Integration Guide](http://spark.apache.org/docs/latest/streaming-kinesis-integration.html)
* A DStream represents a continuous sequence of RDDs
* Every input DStream is associated with a receiver, and in this case also with a KCL worker

## Spark Streaming receivers and KCL workers

Two main components:

* Fetch data from streaming sources --> DStreams
* Processing DStream data as batches

* See `createStream` method defined in the [KinesisUtils](https://github.com/apache/spark/blob/master/extras/kinesis-asl/src/main/scala/org/apache/spark/streaming/kinesis/KinesisUtils.scala) class

## Executors, cores and tasks

* Default Spark configuration file has spark.executor.instances = 2, spark.executor.cores = 4, which means each Spark app can run 2*4=8 tasks concurrently

## Throughput

* If you configure your app to run 10 receiver tasks, only 8 can run concurrently, so the other 2 will be blocked (scheduled but never run)
* UI will show processing time as "undefined" at this point
* Need to stop and rerun the job with fewer executors (2) than max concurrent tasks (8)
* While job is running, look at Spark Streaming interface (or look for "Total delay" in Spark driver log4j logs) to verify whether system can keep up with data rate
    * System could be considered optimized if total delay i scomparable to batch interval for streaming context
    * If total delay is greater than batch interval, app won't be able to keep up with incoming velocity
* May also want to examine parameter "block interval" (`spark.streaming.blockinterval`) - for 1 second, will create 5 tasks for 5-second batch interval

## Dynamic resource allocation

* Variable number of executors to be allocated to an app over time
* Good for variable throughput
* Works only with processing and not receivers
* If you need to create more receivers, you'll need to shut down and restart your app

## Failure recovery

### Checkpointing with the KCL

* **Initial Position** - where app starts reading stream
    * oldest record available (TRIM_HORIZON)
    * latest record (LATEST)
* **Application Name** - Name of DynamoDB table where info about checkpoints is stored
* **Checkpoint interval** - Interval at which KCL workers save their position in the stream

### Checkpoints using Spark Streaming

* **Metadata checkpoints** - Stores state of Spark driver and metadata about unallocated blocks
* **Processing checkpoints** - Stores state of DStream as it's processed through chain, includes beginning, intermediate and end states

## Summary / Guidelines


* Ensure that the number of Amazon Kinesis receivers created are a multiple of executors so that they are load balanced evenly across all the executors.
* Ensure that the total processing time is less than the batch interval.
* Use the number of executors and number of cores per executor parameters to optimize parallelism and use the available resources efficiently.
* Be aware that Spark Streaming uses the default of 1 sec with KCL to read data from Amazon Kinesis.
* For reliable at-least-once semantics, enable the Spark-based checkpoints and ensure that your processing is idempotent (recommended) or you have transactional semantics around your processing.
* Ensure that you’re using Spark version 1.6 or later with the EMRFS consistent view option, when using Amazon S3 as the storage for Spark checkpoints.
* Ensure that there is only one instance of the application running with Spark Streaming, and that multiple applications are not using the same DynamoDB table (via the KCL).
