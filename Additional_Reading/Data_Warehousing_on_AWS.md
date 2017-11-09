# Data Warehousing on AWS
March, 2016

https://d0.awsstatic.com/whitepapers/enterprise-data-warehousing-on-aws.pdf

**NOTE:**  This paper doesn't provide much over the videos and good prior knowledge of data warehousing

## Differences b/t OLAP and OLTP

* Data warehouses are optimized for batched write operations and reading high volumes of data
* OLTP databases are optimized for continuous write operations and high volumes of small read operations.
* Data warehouses employ denormalized schemas like the Star schema and Snowflake schema because of high data throughput requirements
* OLTP databases employ highly normalized schemas which are more suited for high transaction throughput requirements

## Analytics Architecture


### Data Collection

* Analytics Pipeline Options - S3, Kinesis, DynamoDB, RDS / Aurora
* Transactional Data
* Log Data
* Streaming Data
* IoT Data

### Event Processing

* Analytics Pipeline Options - Lambda, KCL Apps, Kinesis Firehose

### Data Processing

* Analytics Pipeline Options - EMR, AWS Machine Learning
* Batch vs. realtime
* ETL vs. ELT - Redshift often used in ELT because it's very efficient at doing transformations

### Data Storage

* Data warehouse vs. data mart

### Analysis and Visualization

* Analytics Pipeline Options - Redshift, QuickSight
* QuickSight, Jupyter notebooks, Zeppelin

## DW Technology Options

### Row-Oriented Databases

* Techniques for optimization include:

    * materialized views
    * creating pre-aggregated rollup tables
    * building indexes on every possible predicate combination
    * implementing data partitioning to leverage partition pruning by query optimizer,
    * performing index based joins

* **Problem**: every query has to read through all of the columns for all of the rows in the blocks that satisfy the query predicate, including columns you didn’t choose

### Column-Oriented Databases

* Faster I/O
* Improved compression, therefore less I/O
* Examples:  Redshift, Vertica, Teradata Aster, Druid

### MPP Architectures

* allows you to use all resources available in cluster for processing data
* dramatically increases performance of petabyte-scale DWs
* Examples:  Redshift, Druid, Vertica, GreenPlum, Teradata Aster

## Amazon Redshift Deep Dive

* RS uses columnar storage, data compression, and zone maps
* Interleaved sorting enables fast performance without the overhead of maintaining indexes or projections

### Security

* SSL for communication w/ the master node
* All data is encrypted with AES-256, even intermediate query results
* Backups are encrypted
* RS takes care of key management, but you can also choose HSMs or KMS

### Cost

* Free backup up to the size of your RS cluster (1x)
* No charge for xfer b/t RS and S3

### Anti-Patterns

* Small datasets (< 100 GB)
* OLTP 
* Unstructured data
* BLOB data

### Migration

* Two-step migration:  Initial xfer and then incremental
* Tools:  AWS Database Migration Service, Attunity, Informatica, SnapLogic, Talend, Bryte




