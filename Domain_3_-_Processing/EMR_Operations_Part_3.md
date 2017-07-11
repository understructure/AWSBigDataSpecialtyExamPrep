### EMR Operations Part 3

#### Guidelines - What instance types to use

* MapReduce - batch oriented, consider 

    * M3 or M4

* Machine Learning

    * P2, C3, C4

* Spark

    * R3 or R4

* Large instance store-based HDFS / MapReduce that require high I/O performance and high IOPS / HBase clusters

    * I2 (I3 instance type releases but not supported in EMR yet)

    * D2

#### How many nodes do you need?

* Guidelines provided by AWS, but you should always experiment with your own data

* Master node sizing

    * with clusters < 50 nodes, use m3.xlarge or m4.xlarge for master

    * with clusters > 50 nodes, use m3.2xlarge or m4.2xlarge for master

* Core node sizing - core nodes run tasks, have HDFS, so ask if you’ll be using HDFS or EMRFS, and if HDFS, do you want EBS, instance store, or both?  

* Replication factor also matters.  Default replication factors are:

    * Clusters of 10+ nodes - 3

    * Clusters for 4-9 nodes - 2

    * Clusters of 1-3 nodes - 1

* Can override this in hdfs-site.xml

* Use HDFS if you have high I/O requirements

* Should you use large cluster of smaller nodes, or small cluster of larger nodes?

    * AWS says small cluster of larger nodes

        * Less nodes, less nodes failure, reduces amount of maintenance
