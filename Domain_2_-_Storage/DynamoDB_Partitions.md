### DynamoDB Partitions

#### Partitions

* Underlying storage and processing nodes of DynamoDB

* Initially one table equates to one partition

* Initially all the data in the table is stored on that partition

* You don't directly control number of partitions (you don't need to) but they can be influenced

<table>
  <tr>
    <td>Max Storage</td>
    <td>10 GB</td>
  </tr>
  <tr>
    <td>Max RCU</td>
    <td>3000</td>
  </tr>
  <tr>
    <td>Max WCU</td>
    <td>1000</td>
  </tr>
</table>


* When you need more than max storage, max RCU or max WCU, a new partition is allocated and the data is spread between them over time

* **KEY CONCEPT** - There is a direct relationship between number of partitions, amount of data stored in table, and performance requirements

* Design tables and apps to read and write evenly across all items in tables - this helps to avoid I/O hotspots / "hot keys"

* When your size gets > 10 GB or you go beyond 3000 RCU or 1000 WCU (whichever happens first), a new partition is added and the data is spread between the old and new partition over time

* Data is distributed based on partition / hash key

* Think of a table of tests that hold records, where test ID is the partition key.  Each record has information about a test and a student, both with their own unique ID - given enough data (over 10 GB) you’ll need to have an additional partition added

* All data for a given test ID (partition key) is bound to a single partition, so you’ll only find student / test records for test ID 12345 on a single partition.  
    
* By adding partitions and spreading data between them, you can scale almost infinitely

* Number of partitions will automatically increase to handle storage or capacity requirements

* Each partition key is limited to:

    * 10 GB of data

    * 3000 RCU

    * 1000 WCU

* Be careful when (manually) decreasing WCU and RCU - number of partitions will NOT be reduced, so they’ll be spread among all the partitions

* **NOTE** - There's no automatic decreasing in partitions!  While there’s an automatic split across partitions to handle upscaling, there’s nothing equivalent for downscaling when performance needs to decrease

* Allocated WCU and RCU are split between partitions - 100 WCU and 4 partitions means only 25 WCUs max on any partition

#### Key Concepts / For the Exam

* Be aware of the underlying storage infrastructure - partitions

* Remember what influences number of partitions:
    * Capacity - every 10 GB creates a partition
    * Performance - every 3000 RCU or 1000 WCU creates a partition
    
* Partitions can increase but not decrease

* Performance reservations (RCUs/WCUs) are split across the partitions - what you apply at a table level isn’t what you often get

* True performance is based on:

  * Performance allocated

  * Key structure

  * Time and key distribution of reads and writes

* Questions asked vary by student, some are on RCU/WCU, others on DynamoDB Streams

    * Understand key concepts on partitions from this lecture
    
    * Understand RCU and WCU impact performance
    
    * How do partition key choices affect performance?

* Understand sort key selection

---

* [Back: DynamoDB Introduction (11:43)](DynamoDB_Introduction.md)

* [Next: DynamoDB GSI/LSI (20:44)](DynamoDB_GSI_LSI.md)
