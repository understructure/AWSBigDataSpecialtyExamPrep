### Hive On EMR

* HiveQL

* Provides SQL abstraction

* High-level programming language - needs an interpreter

* If you’re building an app with Ruby, PHP, Python, C++, to programmatically access Hive remotely, the Thrift Server service makes that possible

* Driver - Compiler, Optimizer, Executor

* Metastore - helps driver keep track of data

* Hive-site.xml

* Hive query converted to MapReduce

* YARN allocates resources across the cluster

* Tez is default engine in EMR 5+ (not MapReduce)

* Hive and DynamoDB are tightly integrated

    * Can join Hive and DynamoDB tables with HiveQL

    * Query data in DynamoDB tables

    * Copy data to/from DynamoDB ← → HDFS

    * Copy data from DynamoDB ← → S3

    * EMR DynamoDB Connector, which is already installed on EMR when you launch a cluster

* DEMO - xfer data between S3 and HDFS

* SerDe - serializer / deserializer

    * Read and write data to/from EMRFS or HDFS in any format

* There’s a JSON SerDe

* To read log files, a RegEx SerDe is used

* SerDe not necessarily on the exam
