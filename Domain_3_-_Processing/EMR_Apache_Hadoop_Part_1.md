### Apache Hadoop Part 1 (not on exam?)

* Hadoop is a framework

* Distributed processing of large data sets across clusters of computers using simple programming models

* Can scale up from single to thousands of machines, each offering local computation and storage

* The library itself is designed to detect and handle failures at the application layer

#### Architecture

* **Hadoop Common (Hadoop Core)**

    * Libraries and utilites needed by other Hadoop modules

    * Considered the core of the Hadoop framework

    * Abstraction of the underlying OS and its file system

    * Contains JAR files and scripts required to start Hadoop

* **HDFS**

    * Distributed file system

    * Primary storage used by Hadoop

    * Fault-tolerant

    * Data replication - blocks all stored as same size (except for last block) - blocks replicated

    * High throughput

* **YARN**

    * Cluster resource-management and job scheduling

* **MapReduce**

    * Programming framework for processing very large data sets

    * Parallel, distributed algorithm on a cluster

    * Processing can occur on data stored either in a filesystem (unstructured) or in a database (structured)

    * Data locality

    * MapReduce job tasks

        * Map - splits data into smaller chunks, processed in parallel

        * Reduce - outputs of map task become inputs for reduce task, data is reduced to create an output file

