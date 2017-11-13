### EMR Architecture Part 2

#### HDFS - may not be on exam?

* Distributed filesystems allow simultaneous access to data and files from many clients to a set of distributed machines

* Share files and storage resources

* Use file or database replication

* Typical DFS woudln’t work well for Hadoop, thus the need for HDFS

* HDFS - high throughput, designed to hold terabytes up to petabytes

* HDFS provides single global namespace for entire cluster

    * Namespace is maintained by master node

    * Provides consolidated view into all files in cluster

* Master holds metadata that holds info about files and directories in cluster

* Block-structured file system - files broken into blocks of fixed size

* Blocks stored across slave nodes

* Files can be made up of many blocks, blocks not necessarily stored on same node

* Block by block basis - blocks stored randomly on nodes

* Each block replicated across a number of slave nodes (factor of 3 by default)

* Metadata held on master nodes

#### Blocks/Block Sizes

* Block sizes tend to be large

* 64MB default size

* No real limit on block size, but tend to range from 64-256MB

* To maximize throughput for very large input file, use larger block size

* For smaller input files, smaller (64MB) is better

* Understand your data, access patterns, cluster size

* Why large block size?  Performance

    * Larger blocks help minimize random disk seeks

    * Helps minimize latency

    * Disk seeks - Time taken for a disk drive to locate the area on the disk where the data to be read is stored

    * Data sequentially laid out on disk - random disk seeks are prevented

* Block sizes can be set per file

* Replication factor set in hdfs-site.xml file

* To check replication factor for a file:

`hadoop fs -stat %r <filename>`

* To change a replication factor for a file (replication_factor is an int):

`hadoop fs -setrep -R -w <replication_factor> <filename>`


#### Storage Options

* Instance Store Volumes 

    * Very high I/O performance, high IOPS at low cost

    * D2 and I3

* EBS for HDFS

    * WARNING - EBS volumes for HDFS DO NOT PERSIST AFTER CLUSTER TERMINATION

* EMRFS - HDFS on S3

    * Uses S3 directly without ingesting data into HDFS

    * Reliability, durability, scalability

    * Resize and terminate clusters w/out losing data

    * Multiple clusters can access same data on S3

    * Can use EMRFS and HDFS together by copying data to HDFS using S3DistCp

    * DistCp - open source tool to copy large amounts of data efficiently
    
    * Use EMRFS and HDFS together if:

        * you need high I/O performance and/or need to take advantage of instance storage on D2 and I3 instance families

        * You’re processing same operations iteratively on data

#### EMRFS and Consistent View

* S3 - read after write consistency for new PUTS

* S3 - eventual consistency for overwrite PUTS and DELETES

* Listing after quick write may be incomplete, e.g., ETL pipeline that depends on list as an input to subsequent steps

* Consistent View allows EMR to check for list and read after write consistency for new S3 objects written by or synched with EMRFS

* If Consistent View feature detects S3 is inconsistent during file PUT request operation, it will retry that operation according to rules that you as a user can define

* Consistent View feature does this by storing metadata in DynamoDB to keep track of S3 objects

#### Single AZ Concept

* Block replication - not ideal to replicate across AZs

* Master, core, and task node communication would be inefficient with multiple AZs

* Access to metadata on master wouldn't be efficient if you had core/task nodes in another AZ

* Single master node possible today anyway, so not possible to setup multi-AZ for master

* Launch replacement clusters easily with no data loss if you use EMRFS
