## Intro to Redshift

* Petabyte-scale data warehouse
* One of AWS’s fastest-growing services
* OLAP
* ANSI-SQL compatible
* Columnar Database


## Redshift Architecture

+ Redshift cluster is a cluster of tightly-coupled EC2 instances in a single AZ
  - Because leader node & compute nodes need to be in close proximity network-wise for performance reasons (run on 10GB ethernet mesh network)
+ Leader Node
  - Has a SQL endpoint, looks like this: redshift.<unique_id>.<region>.redshift.amazonaws.com:5439
  - Coordinates parallel query execution
  - Stores metadata (think system tables)
+ Compute nodes
  - Execute queries in parallel
  - Has dedicated CPU, memory & local storage
  - Scale out/in, up/down
  - Backups done in parallel
  - Consist of slices

### Node Slices 

+ Consist of a portion of memory & disk, data loaded in parallel
+ Number of slices depend on type of node
+ Come into the picture during table design

### Types of nodes:

+ Dense Compute - density - high performacne databases - great if you need lots of CPU, RAM and solid state drives
+ Dense Storage - Large data warehouses, less expensive, very large hard drives
+ Can have Reserved Instance Pricing for Redshift as well
+ https://aws.amazon.com/redshift/pricing/


+ Massively Parallel Processing Database, Shared-Nothing Architecture
+ Data stored on multiple nodes
+ Nodes have dedicated CPU, memory & local storage
+ Nodes are independent, self-sufficient, no disk sharing, no contention b/t nodes
+ All communication happens on a high-speed network


## Redshift in the AWS Ecosystem

* S3 will probably be the main source for loading and unloading data, all done in parallel
* Can use **copy** command to load data into Redshift tables from S3 and DynamoDB

```
copy thermostat_logs from ‘s3://mybucket/my_key/blah/myfile.csv’ credentials ‘aws_iam_role=arn:aws:iam::account_id:role/’
```

Read: 

```
copy table_name from s3_location credentials role_name
```

* **NOTE** - using an IAM role here instead of a username/password or secret keys

+ Can use SSH to copy data into Redshift from EMR or EC2 instance
+ Can use AWS Data Pipeline to schedule & execute data flows to Redshift, or just use it to copy data in without scheduling.  Can also load to RDS or unload from Redhsift.
+ **Lambda** - drop files in S3 and automatically have them pulled into Redshift, or manage snapshots via Lambda
+ **QuickSight** - BI tool for Redshift
+ **AWS Database Migration Service** - migrate data from on-prem or AWS databases to Redshift
+ **Kinesis Streams, Firehose & Analytics**
  - **Streams** - streaming data to Redshift
  - **Firehose** - if you don’t need a custom application
  - **Analytics** - use SQL to analyze data from Firehose → Redhsift
+ **Amazon Machine Learning** - Can dump data from Redshift into S3 and use Amazon ML to do predictive analytics on it



## Columnar Databases

+ DBMS that stores tables as columns rather than rows
+ Efficiently write + read data to/from disk in order to speed up the time it takes to return query results
  - Reduces amount of data that needs to be written to / read from disk
  - When we need to read the data, the I/O needed is much less
  - Avoid scanning and discarding unwanted rows
  - More precise = increased query performance 

### Benefits

* Queries on few columns
* Data aggregation
* Compression
* Lower total cost of ownership

### Do Not Use for

* Needle in a haystack
* < 100 GB
* Large binary objects
* OLTP
* Avoid single line inserts

* Each column maps to a file in the backend
* Always use COPY command over inserting data row-by-row - much faster
* [Aginity Workbench for Amazon Redshift](https://www.aginity.com/redshift/) - tool for Redshift

