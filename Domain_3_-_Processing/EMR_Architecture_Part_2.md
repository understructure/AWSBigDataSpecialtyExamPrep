### EMR Architecture Part 2

#### HDFS - may not be on exam?

* Distributed filesystems allow simultaneous access to data and files from many clients to a set of distributed machines

* Share files and storage resources

* Use file or db replication

* Typical DFS woudln’t work well for Hadoop

* HDFS - high throughput, designed to hold terabytes up to petabytes

* HDFS provides single global namespace for entire cluster

    * Maintained by master node

    * Provides consolidated view into all files in cluster

* Master holds metadata that holds info about files and directories in cluster

* Block-based file system - files broken into blocks of fixed size

* Blocks stored across slave nodes

* Files can be made up of many blocks, blcoks not necessarily stored on same node

* Block by block basis - blocks stored randomly on nodes

* Each block replicated across a number of slave nodes (factor of 3 by default)

* Metadata held on master nodes

#### Blocks/Block Sizes

* Block sizes tend to be large

* 64MB default size

* No real limit on block size, but tend to range from 64-256MB

* To maximize throughput, use larger block size

* For smaller input files, smaller (64MB) is better

* Understand your data, access patterns, cluster size

* Why large block size?  Performance

    * Larger blocks can help minimize random disk seeks

    * Helps minimize latency

    * Disk seeks - Time taken for a disk drive to locate the area on the disk where the data is read and stored

    * Data sequentially laid out on disk

* Block sizes can be set per file

* Replication factor set in hdfs-site.xml file

#### Storage Options

* Instance Store Volumes 

    * Very high I/O performance, high IOPS at low cost

    * D2 and I3

* EBS for HDFS

    * WARNING - EBS volumes for HDFS DO NOT PERSIST AFTER CLUSTER TERMINATION

* EMRFS

    * HDFS on S3 - use if 

        * you need high I/O performance and/or need to take advantage of instance storage on D2 and I3 instance families

        * You’re processing same operations iteratively on data

    * Uses S3 directly without ingesting data into HDFS

    * Reliability, durability, scalability

    * Resize and terminate clusters w/out losing data

    * Multiple clusters can access same data on S3

    * Can use EMRFS and HDFS together by copying data to HDFS using S3DistCp

    * DistCp - open source tool to copy large amounts of data efficiently

#### EMRFS and Consistent View

* S3 - read after write consistency for new PUTS

* S3 - eventual consistency for overwrite PUTS and DELETES

* Listing after quick write may be incomplete, e.g., ETL pipeline that depends on list as an input to subsequent steps

* Consistent View allows EMR to check for list and read after write consistency for new S3 objects written by or synched with EMRFS

* If Consistent View feature detects S3 is inconsistent during file PUT request operation, it will retry that operation according to rules that you as a user can define

* Stores metadata in DynamoDB to keep track of S3 objects

#### Single AZ Concept

* Block replication

* Master, core, and task node communication

* Access to metadata

* Single master node

* Launch replacement clusters easily if you use EMRFS

