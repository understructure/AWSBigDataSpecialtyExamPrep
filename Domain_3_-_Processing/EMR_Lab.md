### EMR Lab

* NOTE:  Be sure you’ve created the dataset and uploaded to S3 before you begin

* Most of the commands are here: [https://github.com/sko71/aws-bigdata-specialty/blob/master/Domain%203/emrlab.txt](https://github.com/sko71/aws-bigdata-specialty/blob/master/Domain%203/emrlab.txt)

* EMR - **Software and Steps** screen - he’s using EMR 5.6.0, check only Hadoop, Hive and Spark

* Hardware screen - use spot instances, 1 master, no core (master will serve as core), no task

* General Cluster Settings screen - add tags if you want, change name, make sure logging is going somewhere you want it to go to

* Security screen - select key pair, stick with default roles and instance profiles, add a security group for Master that allows SSH’ing into cluster

* SSH into master, username is **hadoop**

* Start hive, create orders table and lineitem table

* Before starting SparkSQL, run the sed command to set log level to WARN instead of INFO

* spark-sql starts SparkSQL shell, majority of features are supported in SparkSQL as in Hive (some aren’t though)

* SparkSQL shares metastore w/ Hive so tables remain from previous

* By caching tables and running same query, it goes from ~12 minutes to about 1.5 minutes

`cache tables orders;`

`cache table lineitem;`

* NOTE:  See the scripts I created, they’re much better
