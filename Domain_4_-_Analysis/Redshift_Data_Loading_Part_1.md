### Redshift Data Loading Part 1

#### Source Services for copying data into Redshift 

##### Direct Integration

* S3 - one of the most common ways (fastest way) to move data into Redshift

* EC2 instance

* EMR / HDFS

* DynamoDB - can copy straight from table

##### Indirect (Must stage to S3 first)

* Kinesis-enabled app

* Kinesis Firehose

* DMS (Database Migration Service)

* Can also do files land in S3, which triggers a Lambda function (COPY command)

* See this blog post on [Using AWS Lambda with Amazon Redshift](https://aws.amazon.com/blogs/big-data/a-zero-administration-amazon-redshift-database-loader/), see also [this Github repo](http://github.com/awslabs/aws-lambda-redshift-loader)

#### Moving Data to AWS

* CLI + multipart upload option

* Direct Connect 

* AWS Import / Export

* AWS Import / Export Snowball

* Loading data from S3 is most common and fastest method

* Efficient in loading data in parallel from S3

`copy tablename from 's3://mybucket/myfile.whatever' credentials 'aws_iam_role=arn:aws:iam::accountnumber:role/redshift'`

* Much more secure to use roles than to use access keys and secret keys

* Access keys and secret keys **are** needed when copying encrypted data into Redshift

* Slices can be used for parallelism in loading data to speed up load times

* Compare loading TPC-H dataset in one chunk vs. splitting it into 8 chunks (50 GB) - much faster with the 8 chunks (~9 minutes vs. ~4.5 minutes)

    * You can use the same script from before if you just append **.nnn** (where nnn is number of the chunk) to the end of the split files) if you remove the original file from the directory



Remember this slide from Architecture?

![image alt text](../images/domain4_2.png)

* Each compute node has node slices

* Each node slice allocated a portion of node’s memory and disk space

* [See Node Type Details on this page](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html) to get info on slices, memory, node range and total capacity for Dense Storage Node Types and Dense Compute Node Types

* Slices are generally either 2, 16, or 32

* Also can query the stv_slices system table to get this information

* Compress large files can help load times - gzip, lzip or bzip

* Try to keep file sizes even as possible so nothing’s skewed like in Spark / Hadoop

* After compression, try to keep file sizes from 1 MB - 1 GB each

* **DynamoDB** - when ingesting production and you think you’re going to go over your reads, best practices is to have a copy of the table and ingest from that.

* Below, "readratio" means that percent of the RCUs assigned to the table will be assigned to this copy

`copy redshift_table_name from 'dynamodb://dynamodb_table_name' credentials '<aws-auth-args>' readratio 50;`

* **EC2** - can use an "SSH manifest" file - contains endpoint IPs of Redshift cluster nodes

**For the exam**

* Know number of slices and data files for each node type

* Know loading - best to have number of files equal to number of slices or multiples of the number of slices, e.g., 4 slices = 4 or 8 files

---


* [Back: Redshift Workload Management (14:57)](Redshift_Workload_Management.md)

* [Next: Redshift Data Loading Part 2 (6:32)](Redshift_Data_Loading_Part_2.md)
