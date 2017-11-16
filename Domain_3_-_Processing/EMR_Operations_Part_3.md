### EMR Operations Part 3

#### Guidelines - What instance types to use

* MapReduce - batch oriented, consider 

    * M3 or M4 - general purpose, allows for cheap horizontal scaling

* Machine Learning

    * P2, C3, C4

* Spark

    * R3 or R4

* Large instance store-based HDFS / MapReduce that require high I/O performance and high IOPS / Large HBase clusters

    * I2, I3 (I3 instance type releases now supported in EMR 5.9.0+)

    * D2

#### How many nodes do you need?

* Guidelines provided by AWS, but you should always experiment with your own data

* **Master node sizing** - Master nodes have low compute requirements

    * with clusters < 50 nodes, use m3.xlarge or m4.xlarge for master

    * with clusters > 50 nodes, use m3.2xlarge or m4.2xlarge for master

* **Core node sizing** - core nodes run tasks, have HDFS, so ask if you’ll be using HDFS or EMRFS, and if HDFS, do you want EBS, instance store, or both?  

* Replication factor also matters.  Default replication factors are:

    * Clusters of 10+ nodes - 3

    * Clusters for 4-9 nodes - 2

    * Clusters of 1-3 nodes - 1

* Can override this in hdfs-site.xml

* Use HDFS (instance store of EBS) if you have high I/O requirements
 
    
* Calculate HDFS capacity of a cluster:
    * 10 nodes * 800 GB space = 8 TB
    * Replication factor is 3
    * To calculate HDFS capacity:
    
    `8 TB (total storage) / 3 (replication factor) = 2.6 TB `
    
* Can add more nodes or add size to existing nodes if 2.6 TB isn't enough for your data size - three options:

1.  Add more core nodes of same type
2.  Use fewer, larger-capacity core nodes
3.  Add EBS volumes (of same size as what the nodes come with?)


* Should you use large cluster of smaller nodes, or small cluster of larger nodes?

    * AWS says small cluster of larger nodes
    * Less nodes, less nodes failure, reduces amount of maintenance

---

* [Back: EMR Operations Part 2 (9:47)](EMR_Operations_Part_2.md)
* [Next: EMR Operations Part 4 (16:30)](EMR_Operations_Part_4.md)
