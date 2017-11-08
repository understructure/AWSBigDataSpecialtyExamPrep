

## Moving Data to AWS

* You can adjust TCP settings such as window scaling and selective acknowledgement to enhance data throughput further

### Scenario 1: Moving Large Amounts of Data from HDFS (Data Center) to Amazon S3

#### S3DistCp

* copies data using distributed map–reduce jobs, which is similar to DistCp
* mappers compile a list of files to copyt to the destination
* reducers do the actual data copy
* The main optimization that S3DistCp provides over DistCp is by having a reducer run multiple HTTP upload threads to upload the files in parallel

* http://aws.amazon.com/documentation/elasticmapreduce/  
* http://www.amazon.com/Hadoop-Definitive-Guide-Tom-White/dp/1449311520/  
* http://docs.aws.amazon.com/AmazonS3/latest/dev/TCPWindowScaling.html  
* http://docs.aws.amazon.com/AmazonS3/latest/dev/TCPSelectiveAcknowledgement.html  

#### DistCp

* For large inter- or intra-cluster copying of data
* Uses EMR to effect distribution, error handling, recovery and reporting
* Not as fast as S3DistCp
* Algorithm used: `min (total_bytes / bytes.per.map, 20 * num_task_trackers)`

### Scenario 2: Moving Large Amounts of Data from Local Disk (non-HDFS) to Amazon S3

#### Jets3t Java Library

* provides low-level APIs, provides tools to work w/ S3 or CloudFront w/out writing Java apps
* One tool, "Synchronize," can be configured to use as many threads as possible for max throughput

#### GNU Parallel

* parallelize the process of uploading multiple files by opening multiple threads simultaneously.
* e.g., copy contents of current directory to S3 with 2 (N2) threads using s3cmd put command:

`ls | parallel -j0 -N2 s3cmd put {1} s3://somes3bucket/dir1/`

#### Aspera Direct-to-S3

* TCP is suboptimal with high latency paths; UDP provides the potential for higher speeds and better performance
* Aspera uses UDP

#### AWS Import/Export (Snowball)

1.  Prepare a storage device
2.  Submit Create Job request to AWS with your bucket, EBS/Glacier region, AWS access key ID and return shipping address
3.  Identify and authenticate your device (securely) - place signature file on root dir of your device or tape signature barcode to exterior of device
4.  Ship device w/ interface connectors and power supply to AWS

#### AWS Direct Connect

* can reduce your network costs, increase bandwidth throughput, and provide a more consistent network experience
* 1 Gbps or 10 Gbps
* Two most common architecture patterns


1.  One-time bulk data transfer to AWS
2.  Use AWS Direct Connect to connect your data center with AWS resources

### Scenario 3: Moving Large Amounts of Data from Amazon S3 to HDFS

#### S3DistCp

* Doc is outdated - use Amazon EMR commands in the AWS CLI

#### DistCp (example)

`hadoop s3n://awsaccesskey:awssecrectkey@somebucket/mydata/ distcp hdfs:///data/`

## Data Collection

* Apache Flume - collector agents
* Fluentd - input, buffer, output


## Data Aggregation

* Flume - set `flume.collector.roll.millis` property in `/etc/flume/conf/flume-site.xml` 
* Fluentd also supports this
* Also S3DistCp has an aggregation feature

### Data Aggregation Best Practices

* Difference between HDFS and S3 as far as how splits are handled
* Before processing your data, Hadoop splits your data (files) into multiple chunks. After splitting the file(s), a single map task processes each part.
* Since the data on Amazon S3 is not separated into multiple parts the same way data files on HDFS are, Hadoop splits the data on Amazon S3 by reading your files in multiple HTTP range requests
* The split size that Hadoop uses to read data file from Amazon S3 varies depending on the Amazon EMR Amazon Machine Image (AMI) version you’re using
* More recent EMR versions have larger split size than older ones
* If your compression algorithm does not allow for splitting, Hadoop will not split your data file and instead uses a single map task to process your compressed file

#### Best Practice 1:  Aggregated Data Size

* GZIP - keep files 1-2 GB, because GZIP can't be split
* If using splittable compression, keep files 2-4 GB
* Since a single thread (mapper) is limited to how much data it can pull from Amazon S3 at any given time (throughput), the process of reading the entire file from Amazon S3 into the mapper becomes the bottleneck in your data processing workflow

#### Best Practice 2:  Controlling Data Aggregation Size

* At the time of writing this paper, none of the log collection frameworks can aggregate by file size, and because of that, figuring out the right time-based aggregation is mostly a process of trial and error
* Since most distributed log collector frameworks are open source, you might be able to write special plugins for your chosen log collector to introduce the ability to aggregate based on file size.

#### Best Practice 3:  Data Compression Algorithms

* GZIP (non-splittable) is fine if files will be in the 1/2-1 GB range, if bigger, choose a splittable compression algorithm

##### Data Compression

1.  Lower storage costs
2.  Lower bandwidth costs
3.  Better data processing performance by moving less data b/t storage, mappers and reducers
4.  Better data processing performance by compressing data EMR writes to disk - write to disk less frequently = better performance

##### Which Algorithm?

* GZIP - not splittable, best encoding/decoding speed, worst compression speed
* Snappy - not splittable, worst encoding/decoding speed, best compression speed
* LZO and BZip2 are in the middle, both are splittable (LZO if indexed), are second and third in encoding/decoding and compression

##### Compressing mapper and reducer outputs

* Compressing mapper output / reducer input can help, but the performance boost by compressing the intermediate data completely depends on how much data must be copied to reducers
* Check Hadoop's REDUCE_SHUFFLE to see how much data Hadoop is copying over the network
* set `mapreduce.map.output.compress` to true and `mapreduce.map.output.compress.codec` to GZIP, LZO or Snappy
* LZO is one of the good compression candidates for compressing the mapper's output data
* Ensure `mapred.compress.map.output=true` is set in your Hadoop job

##### Summary

Compression algorithm you choose depends on

* How fast you need to compress/decompress your data files
* How much data storage space you want to save
* Whether your files are small enough that you don't need splittable compression
* If possible, choose native compression libraries like GZip - can perform better than Java implementations

#### Best Practice 4:  Data Partitioning

Considerations

* Data type (time series)
* Data processing frequency / grain (hour/day)
* Data access and query pattern (on time vs. on geo location)

## Processing Data with EMR

### Picking the Right Instance Size

* Memory-intensive jobs - m1.xlarge or m2 instances
* CPU-intensive jobs - c1.xlarge, cc1.4xlarge, cc2.8xlarge
* If both intensive - cc1.4xlarge or cc2.8xlarge
* Hadoop tries to use as much memory as possible, spilling to disk when necessary
* EMR configures the following for you:
    * Number of mappers per instance
    * Number of reducers per instance
    * Java memory (heap) size per daemon
* The optimal Amazon EMR cluster size is the one that has enough nodes and can process many mappers and reducers in parallel
* Keep in mind time and cost (remember the hour boundary)
* [Task Comnfiguration / JVM Settings by Instance Type](http://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-hadoop-task-config.html)

#### Estimating the Number of Mappers Your Job Requires

1.  The number of mappers depends on the number of Hadoop splits - if files are <= your block size, number of files = number of mappers.  Otherwise, divide file size by block size, that's your number of mappers.
2.  Run your job on EMR and note the number of mappers calculated by Hadoop for your job - JobTracker GUI or log output "Launched map tasks=N"

### EMR Cluster Type - Transient vs. Persistent

* Do what makes financial sense
* If you're not using HDFS, possible to do transient



### Common EMR Architectures

#### Pattern 1:  Amazon S3 instead of HDFS

* EMR doesn't copy data to local disk
* Mappers open multithreaded HTTP connections to S3, pull the data, and process in streams
* Potential drawback - Not effective for iterative data processing jobs where data needs processing multiple times with multiple passes

#### Pattern 2:  Amazon S3 AND HDFS

* Data stored on S3 according to data partitioning, data size, and compression best practices
* EMR copies data to HDFS w/ DistCp or S3DistCp
* Potential drawback - delay to data processing workflow due to having to copy the data over to HDFS first

#### Pattern 3: HDFS and Amazon S3 as Backup Storage

* Stored on HDFS, use DistCp or S3DistCp to copy to S3 periodically
* Advantage - speed
* Disadvantage - data durability
* Backup data partitions rather than entire data set to avoid putting too much load on EMR cluster

#### Pattern 4: Elastic Amazon EMR Cluster (Manual)

* Monitor with CloudWatch, resize as necessary
* Number of mappers running / outstanding
* Number of reducers running / outstanding

#### Pattern 5: Elastic Amazon EMR Cluster (Dynamic)

* Master - runs JobTracker and NameNode
* Core - run TaskTracker and DataNodes
* Task - run TaskTracker only - data processing only (running mappers and reducers)
* Can automate adding more task nodes to clluster with CloudWatch metrics
    * Number of mappers running / outstanding
    * Number of reducers running / outstanding
    * Cluster idle
    * Live data nodes or task nodes

## Optimizing for Cost with Amazon EMR and Amazon EC2

1.  On-demand instances
2.  Reserved instances - use if EMR hourly usage is more than 17%
3.  Spot instances

* Reserved instances - Heavy (steady, predictable workload), Medium (predictable, but not constant workload), and Light
* On-demand or spot - Unpredictable workload
* Spot - task nodes are safest to run on spot


## Performance Optimizations (Advanced)

* Best performance optimization is to structure your data better (e.g., partitioning) - this limits amount of data Hadoop processes, leading to better performance (exception:  triple-digit cluster sizes)
* Use Spark or something else instead of Hadoop
* Improving by a few minutes won't help if it doesn't keep you on one side of the hour barrier
* Adding more nodes might be better than trying to optimize


1.  Run a (representative) benchmark test (several times) before and after optimizations
2.  Monitor benchmark tests using Ganglia
3.  Identify constraints by monitoring Ganglia's metrics, e.g., memory, CPU, Disk I/O, Network I/O
4.  Once you've identified the potential constraint, optimize to remove the constraint and start a new benchmark test

### Suggestions for Performance Improvement

#### Map Task Improvements

* Map Task Lifetime - if map tasks have a short lifespan on average, may want to reduce the number of mappers
    * Aggregate files by size or time
    * Aggregate smaller files into larger Hadoop archive files (HAR)
* Compress mapper outputs - monitor `FILE_BYTES_WRITTEN` metric - compression can benefit shuffle phase and HDFS data replication
* Avoid map task disk spill - increase `io.sort.*` parameters, e.g., `io.sort.mb` - determines size of mapper task buffer (common to increase mapper heap size prior to increasing `io.sort.mb`

#### Reduce Task Improvements

* Job should use fewer reducers than cluster's total reducer capacity - all reducers should finish at the same time if this is happening and there's no skew
* CloudWatch **Average Reduce Task Remaining** and **Average Reduce Tasks Running**
* If reducer requires small memory footprint, increase reducer memory thusly:
    * `mapred.inmem.merge.threshold` set to 0
    * `mapred.job.reduce.input.buffer.percent` set to 1.0

#### Use Ganglia for Performance Optimizations

* CPU - if not at maximum, may be able to use fewer nodes or increase the number of mapper or reducer capacity per node
* Memory - if not at maximum, may benefit by increasing the amount of memory available to mappers or reducers and/or decrease number of mappers or reducers per node
* Network I/O - if using S3 - e.g., if you have 100 files, you should have 100 mappers available, if not, either add more nodes (easiest) or increase mapper capacity per node
    * If you have enough mappers available but are running fewer, you may have more nodes than required for your job, or you're using large, non-splittable files
    * May want to reduce data file sizes or use compression that supports splitting
* Monitoring JVM - watch JVM metrics and garbage collector pauses - if you see long GC pauses, increase JVM memory or add more instances to remove pressure
* Disk I/O - check reducer spills `SPILLED_RECORDS` - to reduce, set `mapred.compress.map.output` to true, or monitor Disk I/O and increase task memory if needed (`io.file.buffer.size` parameter)

#### Locating Hadoop Metrics

* JobTracker UI interface on masternode:9100
* click a job (running or not) to get aggregate metrics
* click a mapper/reducer to get metrics for that map-reduce job





