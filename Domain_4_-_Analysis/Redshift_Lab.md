### Redshift Lab

#### What we’ll cover

1. Create and connect to a cluster

2. Create sets of tables

    1. With with compression encodings

    2. Without compression encodings

    3. With distribution keys, sort keys, and compression encodings

3. Load data into tables

4. Run queries against tables

[Factors Affecting Query Performance](http://docs.aws.amazon.com/redshift/latest/dg/c-query-performance.html)

* Create a new security group 

    * Create an inbound rule for Redshift, using either your IP or IP of an EC2 instance running Aginity Workbench

* Create a new role to read data from S3

    * IAM >> Roles >> Create New >> Redshift >> AmazonS3FullAccess

* Create a cluster subnet group - allows you to specify a set of subnets in your VPC where you can deploy your cluster

    * Redshift >> Security >> Subnet Groups >> Create	Subnet Group

    * Can add multiple AZs if you want

* Clusters >> Launch Cluster (use dc1.large node type, only one node)

    * No encryption

    * Select cluster subnet group

    * Publicly available, No "choose public IP address" (will use Elastic IP), No enhanced VPC routing, no CloudWatch alarm, use Role we created

* Wait (and wait) for cluster to be created

* Once you get an endpoint, if you can’t connect, check your inbound rule, make sure you can get in from wherever you’re trying to connect from

* SQL Workbench/J needs JDK 8, 

* [http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

* Make sure you’ve got the Autocommit checkbox checked in SQL Workbench/J

* Also, make sure you’ve got the URL right, it should look like this (note the "/database" after the endpoint:port bit):

jdbc:redshift://*endpoint*:*port*/*database*

* My account number: 358695872585

* [https://github.com/sko71/aws-bigdata-specialty/blob/master/Domain%204/redshiftlab.txt](https://github.com/sko71/aws-bigdata-specialty/blob/master/Domain%204/redshiftlab.txt)

* NOTE:  Be sure that manifest files are copied up to S3 per the video for this to work

* The first time you run a query, Redshift compiles the code and sends the compiled code to the compute nodes - here we’ll compare the query times based on the second run of the query

* Redshift creates snapshots by default, you can’t delete them, only Redshift can.  Default retention period is 1 day

* [Working With Snapshots](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-snapshots.html): Only Amazon Redshift can delete an automated snapshot; you cannot delete them manually. Amazon Redshift deletes automated snapshots at the end of a snapshot’s retention period, when you disable automated snapshots, or when you delete the cluster. If you want to keep an automated snapshot for a longer period, you can create a copy of it as a manual snapshot. The automated snapshot is retained until the end of retention period, but the corresponding manual snapshot is retained until you manually delete it.
