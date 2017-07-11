## AWS Certification - Big Data - Domain 1 - Collection

### Kinesis Firehose

* Can load streaming data in near-realtime into:

    * S3

    * Redshift

    * Elasticsearch

* Can use existing BI tools and dashboards

* Highly available and durable - data replicated across 3 facilities in an AWS region

* Fully managed

    * Sharding, scaling and monitoring w/ zero administration

    * Firehose can batch and compress - minimizing storage in S3

    * Can encrypt data before it’s loaded

    * Can create with management console or by using API

* Each record can be up to 1000 KB

* Set buffer size (1 MB - 128 MB) and buffer interval (60-900 seconds) - whichever condition is satisfied first triggers moving the data to S3 or Elasticsearch

* Can use COPY command in Redshift to then get data into Redshift

**Loading data to Kinesis Firehose**

**Amazon Kinesis Agent**

* standalone Java-based app that allows you to collect & send data to Firehose

* Can install on (Linux-based) log servers, db servers, web servers

* After install, can configure to monitor a set of files and send new data to Firehose delivery stream

    * Can even configure so some data sent to Firehose delivery stream, and some sent to Kinesis stream

* Agent handles file rotation, checkpointing, retry on failure

* Agent also helps w/ Cloudwatch metrics

* Can pre-process data before sending to delivery stream, e.g., 

    * Multi-line records to single line

    * Convert from delimiter to JSON format

    * Convert record from log format to JSON format

**AWS Kinesis Firehose SDK**

* Can use Python, Java, Node.js, .NET or Ruby

* PutRecord (single record)

* PutRecordBatch (multiple records)

DEMO 4:28 - 8:25 - watch this again / do it

* Firehose can invoke a Lambda function to transform data, and then deliver that data to S3, Redshift, or Elasticsearch

* Can enable transformation when you create your delivery stream	

**Data Transformation Flow**

* Firehose buffers data (up to buffering size specified in delivery stream)

* Firehose invokes Lambda function w/ each buffered batch asynchronously

* Transformed data is sent from Lambda to Firehose for buffering

* Transformed data then sent to destination when specified buffering size or interval is reached, whichever happens first

**Parameters for Transformation** - Lambda must contain these parameters or Firehose will reject them

* **recordId** - Transformed record must have the same recordId prior to transformation

* **result** - Transformed record status: "Ok", “Dropped”, and “ProcessingFailed”

* **data** - transformed data payload after base64 encoding

* Blueprint functions are available - [see this blog](https://aws.amazon.com/blogs/compute/amazon-kinesis-firehose-data-transformation-with-aws-lambda/) for more information

* **Failure handling** - Firehose retries 3 times by default, and then skips that batch of records if it still doesn’t succeed.  Skipped records treated as unsuccessfully processed records

* Invocation errors can be logged to CloudWatch Logs

* Unsuccessfully processed records are sent to S3 bucket in "processing_failed" folder

* **Source Record Backup** - can save off source records to S3 or wherever

**Data Delivery Frequency**

* **S3 and Elasticsearch**

    * depends on Buffer Size (1 MB - 128 MB) and Buffer Interval (60 - 900 seconds)

    * Firehose can raise the buffer size dynamically to catch up if it’s falling behind

* **Redshift**

    * Depends how fast Redshift cluster can finish the COPY command

    * Firehose issues new COPY command automatically when previous COPY command has finished running

**Data Delivery Failures**

* **S3**

    * Firehose retries deliveries for up to 24 hours (data lost if beyond this!)

* **Redshift**

    * Can specify retry duration of 0-7200 seconds from S3 - can do this when creating delivery stream

    * If Redshift is under maintenance or there’s a cluster failure - it Skips S3 objects and lists them in a manifest file

* Elasticsearch

    * Retries for 0-7200 seconds

    * Skips index request after that

    * Skipped documents are delivered to S3 bucket (in folder named "elasticsearch_failed" - docs are in JSON format)

        * Can then use documents in this folder for backfill

**For the exam, remember:**

* Firehose can load streaming data to S3, Redshift, and Elasticsearch

* How Lambda is used with Firehose (e.g., for data transformation)

* Key concepts in this lecture

