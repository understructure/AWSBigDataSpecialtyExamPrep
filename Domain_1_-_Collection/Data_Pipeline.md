### Data Pipeline

* EXAM - You'll be asked about backup & restore of data into other regions

* Data Pipeline is a web service that allows you to reliably process and move data b/t AWS compute and storage services and on-premise data sources

* Create an ETL workflow to automate the processing and movement of data at scheduled intervals, then terminate the resources

#### Types of Pipelines

* ShellCommandActivity
* Run AWS CLI Command
* Export DynamoDB table to S3
* Import DynamoDB backup from S3
* Run job on EMR cluster
* Full or incremental copy of RDS MySQL table to S3
* Load S3 data into RDS MySQL table
* Full or incremental copy of RDS MySQL table to Redshift
* Load S3 data into Redhsift

* More than one way to do it - be aware of the combinations you can use

* You can move data across regions

  * E.g., can copy entire DynamoDB table to another region, or an incremental copy of table

* Can schedule time and frequency of copy

* Behind the scenes, Data Pipeline is launching an EMR cluster to extract data from DynamoDB in region A into a file in S3 in region B, then launches another EMR cluster to copy the data from S3 into DynamoDB (both in region B)

* Pipeline is the name of a container that contains things like

    * Data nodes
    * Activities
    * Preconditions
    * Schedules

* TIP:  Remember the acronym PADS

* All of the above components work together to help you move your data from one location to another

* Data Pipeline runs on an EC2 instance or an EMR cluster which are provisioned and terminated automatically

* Can run Data Pipeline on-premises

    * AWS provides you with a Task Runner package you install on your on-premises host(s)

    * The package continuously polls Data Pipeline for work to perform

    * When it’s time to run a particular activity on your on-premises resources, e.g., executing a DB stored procedure or a database dump, AWS Data Pipeline will issue the appropriate command on the Task Runner

* **Data nodes** - end destination for your data

    * DynamoDB
    * MySQL (Deprecated, use SQLDataNode instead)
    * RedshiftDataNode
    * S3DataNode

* **Activities** - an action that Data Pipeline initiates on your behalf as part of a pipeline

    * CopyActivity
    * EMRActivity
    * HiveActivity
    * PipActivity
    * ShellCommandActivity
    * etc.

* **Preconditions** - readiness check, can be optionally associated with a data source or activity

    * If a data source has a precondition check, that check must complete successfully before any activities consuming the data source are launched

    * If an activity has a precondition check, that check must complete successfully before that activity is run

    * Can specify custom preconditions

        * DynamoDBDataExists - does data exist?
        * DynamoDBTableExists - does table exist?
        * S3KeyExists - Does S3 path exist?
        * S3PrefixExists - Does file exist?
        * ShellCommandPrecondition - custom preconditions

* **Schedules** - define when pipeline acctivites run, and frequency with which service expects your data to be available

**For the exam**

* Data Pipeline is a Web service that allows you to reliably process and move data b/t AWS compute and storage services and on-premise data sources

* Can be integrated with on-premeses environments

* Will automatically provision and terminate resources as and when required

* Components: **Datanode**, **Activity**, **Precondition**, **Schedule**

* A LOT of Data Pipeline’s functionality has been replaced by Lambda

* [Previous: IoT (14:31)](IoT.md)
