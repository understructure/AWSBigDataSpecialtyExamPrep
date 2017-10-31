### EMR Architecture Part 1

* Master, Core and Task nodes

* Master schedules jobs on Core and Task nodes, Core and Task = Slave nodes

* Nodes categorized into Instance Groups - Master, Core and Task

* Can create up to 48 task instance groups, total of 50 instance groups in EMR cluster including master and core instance groups

    * Comes in handy if there’s not enough spot instances of a certain type

* Single master node **is** a single point of failure

#### Master node

* Manages resources of cluster

* Coodinates distribution and parallel execution of MapReduce executables

* Tracking and directing against HDFS

* ResourceManager (i.e., YARN)

* Monitors health of core and task nodes

#### Core node (optional if you're running EMRFS)

* Run tasks as directed by master

* Store data as HDFS or EMRFS (can use instance store or EBS)

* **EMRFS** - extends Hadoop to access data from S3

* **DataNode** - daemon that manages data blocks and read/write requests on the core node whether HDFS or EMRFS is used

* **NodeManager** - demon that takes direction from the Resource Manager on master in terms of how to manage resources on Core node

* **ApplicationMaster** - negotiates resources from ResourceManager and works with NodeManager to execute and monitor containers

* Shrink operation - reduce number of Core nodes - do this while no jobs are running to prevent data loss

#### Task node (optional)

* Slave node without HDFS

* Can be added and removed from running clusters

* No DataNode daemon running on Task nodes!

* Ideal to handle extra capacity (CPU and RAM)
