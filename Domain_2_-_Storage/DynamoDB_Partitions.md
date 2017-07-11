### DynamoDB Partitions

#### Partitions

* Underlying storage and processing nodes of DynamoDB

* Initially one table equates to one partition

* Initially all thte data in the table is stored on that partition

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

* Direct relationship between number of partitions, amount of data stored in table, and performance requirements

* Design tables and apps to avoid I/O hotspots / "hot keys"

* Data is distributed based on partition / hash key

* Think of a table of tests that hold records, where test ID is the partition key.  Each record has information about a test and a student, both with their own unique ID - given enough data (over 10 GB) you’ll need to have an additional partition added

* All data for a given test ID (partition key) is bound to a single partition, so you’ll only find student / test records for test ID 12345 on a single partition.  Therefore, each partition key is limited to:

    * 10 GB of data

    * 3000 RCU

    * 1000 WCU

* Be careful when (manually) decreasing WCU and RCU - number of partitions will NOT be reduced, so they’ll be spread among all the partitions

* Number of partitions will automatically increase to handle storage or capacity requirements

* While there’s an automatic split across partitions to handle upscaling, there’s nothing equivalent for downscaling when performance needs decrease

* Allocated WCU and RCU are split between partitions

#### Key Concepts / For the Exam

* Questions asked vary by student, some are on RCU/WCU, others on DynamoDB Streams

* How do partition key choices affect performance?

* Understand sort key selection

* Be aware:

    * Underlying storage infrastructure - partitions

    * What influences number of partitions

        * Capacity - every 10 GB

        * Performance - every 3000 RCU or 1000 RCU

    * Partitions can increase but not decrease

    * Table performance is split across the partitions - what you apply at a table level isn’t what you often get

    * True performance is based on:

        * Performance allocated

        * Key structure

        * Time and key distribution of reads and writes
