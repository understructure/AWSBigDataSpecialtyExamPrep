### DynamoDB Introduction

* (see other intro DynamoDB lectures, lots of overlap here)

* No practical limit on table size, no constraints on number of items or bytes

* Performance scales in a linear way

* DynamoDB is a collection of tables in each region

* Service namespace is at region level, AZs unimportant in DynamoDB architecture

* Tables highest-level structure, at this level performance controlled and managed

* Specify reads - read capacity units (RCU) (4kb) and writes (1kb) per second

* Supports eventually consistent reads

* Reads only acknowledged when at least 2 locations have responded with confirmed write

* Reads by default take just from one region

* Eventually consistent (default, use ½ unit per 4kb block) or strongly consistent (use 1 read unit per 4kb block)

* Think of partitions as an underlying server that can cope with a certain level of RCUs, WCUs, and store a certain amount of data

* Unlike SQL databases, the data structure or schema is NOT defined at the table level

* **Row** = **Item** - each item can have different attributes, and different number of attributes

* **Partition key / hash key** - has to be unique w/in a table

* **Sort key / range key** - allows one-to-many relationships for partition keys

* Attribute types

    * String

    * Number

    * Binary

    * Boolean

    * Null

    * Document (List/Map): JSON

    * Set (Array)

* Can copy directly from DynamoDB to Redshift

* EMR / Hive - can read and write data in DynamoDB tables - allows you to query live DynamoDB with SQL-like language

* Can copy DynamoDB table data to Bucket in S3 (and vice versa)

* Can copy DynamoDB table data to HDFS (and vice versa)

* Perform join operations on DynamoDB tables

* **Data Pipeline** - used to import/export DynamoDB table data to/from S3

    * Data Pipeline launches EMR, which reads/writes to/from DynamoDB and writes to S3 bucket or DynamoDB table

* **EC2** - can use libraries to read/write to/from DynamoDB

* **Lambda** - can create triggers that automatically respond to events in DynamoDB streams

* **Kinesis Streams** - using Kinesis Client Library and Kinesis Connector Library, can consume from Kinesis Streams and emit to DynamoDB
