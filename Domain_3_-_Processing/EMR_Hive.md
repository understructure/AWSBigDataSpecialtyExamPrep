### Hive On EMR

* HiveQL

* Provides SQL abstraction to Hadoop

* High-level programming language - needs an interpreter

* If you’re building an app with Ruby, PHP, Python, C++, to programmatically access Hive remotely, the Thrift Server service makes that possible

* Driver - Compiler, Optimizer, Executor

* Metastore - helps driver keep track of data

* hive-site.xml

* Hive query converted to MapReduce

* YARN allocates resources across the cluster

* Tez is default engine in EMR 5+ (not MapReduce)

* EMR can read from / write to S3
* EMRFS - extends hadoop to use S3 as a file system instead of HDFS
* Partitioning - supported w/ S3 - usually partitioned by date, source, etc.

* Hive and DynamoDB are tightly integrated

    * Can join Hive and DynamoDB tables with HiveQL

    * Query data in DynamoDB tables

    * Copy data to/from DynamoDB ← → HDFS

    * Copy data from DynamoDB ← → S3

    * EMR DynamoDB Connector, which is already installed on EMR when you launch a cluster

* DEMO - xfer data between S3 and HDFS

* SerDe - serializer / deserializer

    * Read and write data to/from EMRFS or HDFS in any format

* There’s a JSON SerDe at s3://elasticmapreduce/samples/hive-ads/libs/jsonserde.jar

* To read log files, a RegEx SerDe is used [see this page for an example](http://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-gs-prepare-data-and-script.html)

* SerDe not necessarily on the exam
