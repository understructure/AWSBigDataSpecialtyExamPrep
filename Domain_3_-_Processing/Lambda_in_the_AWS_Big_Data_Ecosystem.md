### Lambda in the AWS Big Data Ecosystem

* What is Lambda (skipped)

* Invoked via API Gateway - allows you to map a URL and HTTP method to trigger Lambda code

* Event-driven service

* Lambda may or may not generate anything, if it does, it can write the result or generate its own event (e.g., invoke another Lambda function)

* Lambda can be invoked:

    * **S3** - when file is added/updated/deleted in bucket

    * **DynamoDB** - when data is changed in a table - see 

        * [Using AWS Lambda with Amazon DynamoDB](http://docs.aws.amazon.com/lambda/latest/dg/with-ddb.html) 

        * [Implementing a Serverless AWS IoT Backend with AWS Lambda and Amazon DynamoDB](https://aws.amazon.com/blogs/compute/implementing-a-serverless-aws-iot-backend-with-aws-lambda-and-amazon-dynamodb/)

    * **Kinesis Streams** - can automatically read records off a Kinesis Stream and process them if records are detected in a stream

    * **AWS Redshift Loader** - Lambda-based - files can be pushed to S3 and automatically loaded into Redshift

    * **IoT** - When thing sends message, IoT service triggers a rule action to invoke Lambda

    * **Kinesis Firehose** - can invoke Lambda function to transform incoming source data, then push data to S3, Redshift, or Elasticsearch

        * Can enable Firehose Data Transformation when you create your Delivery Stream.  See [Amazon Kinesis Firehose Data Transformation with AWS Lambda](https://aws.amazon.com/blogs/compute/amazon-kinesis-firehose-data-transformation-with-aws-lambda/)

    * **Elasticsearch** - Integrate with S3 and Lambda to load any new data into Elasticsearch

    * **Data Pipeline** - Can create a Lambda to activate Data Pipeline anytime object lands in S3 bucket - see [Using AWS Lambda for Event-driven Data Processing Pipelines](https://aws.amazon.com/blogs/big-data/using-aws-lambda-for-event-driven-data-processing-pipelines/)

* You can [create a serverless architecture to run MapReduce jobs using Lambda and S3](https://aws.amazon.com/blogs/compute/ad-hoc-big-data-processing-made-simple-with-serverless-mapreduce/)

* When Lambda is invoked, it receives two main inputs:

    * **CONTEXT object** - contains methods and attributes, used to allow the function to obtain certain information about its invocation (e.g., remaining time in ms)

        * Can also query attributes of CONTEXT object to get name and version of the function, assess memory limit in MB, or log group and stream name for the function

    * **EVENT object** - defers based on what the event is

        * Sometimes single record, e.g., when launched from a service like cron, or may contain multiple records, e.g., if it’s from DynamoDB with several transactions

#### Lambda Limitations

<table>
  <tr>
    <td>Ephemeral disk capacity ("/tmp" space)</td>
    <td>512 MB</td>
  </tr>
  <tr>
    <td>Total number of threads + processes combined </td>
    <td>1,024</td>
  </tr>
  <tr>
    <td>Maxiumum duration seconds per invocation</td>
    <td>300 seconds</td>
  </tr>
</table>


#### Lambda + Kinesis Streams

* Lambda functions automatically read records off of a Kinesis Stream and processes them if records are detected in the stream

* Lambda polls a stream every second for new records

* When function is executed, an execution role is assumed by Lambda - needs to assume this role in order to access other AWS services (Lambda also needs permissions to poll Kinesis Stream)

* See image here: [Using AWS Lambda with Kinesis](http://docs.aws.amazon.com/lambda/latest/dg/with-kinesis.html)

#### Lambda + Redshift - How Does It Work?

* Once files are sent to S3, Lambda function maintains a list of all the files to be loaded from S3 into Redshift cluster - keeps this in DynamoDB table

* This DynamoDB table ensures files are loaded only once, and holds information about what was loaded, where (table name), and when (datetime)

* Files found in S3 are buffered up to a specified batch size that you can control, or you can specify a time-based threshold that triggers a data load

* You can specify many of the COPY command options available with Redshift

* Function also supports loading of CSV and JSON files

* Also comes with some tools to monitor the status of your load processing, monitor batch status, and troubleshoot issues

* Can setup SNS integration - notify on success or failure of data load

* DEMO @ 12:35 - basically follow the instructions from [A Zero-Administration Amazon Redshift Database Loader](https://aws.amazon.com/blogs/big-data/a-zero-administration-amazon-redshift-database-loader/), using code in this repo: [https://github.com/awslabs/aws-lambda-redshift-loader](https://github.com/awslabs/aws-lambda-redshift-loader) 

For the Exam:

* Have an understanding of Lambda

* Integration w/ big data services

* References (AWS big data blog and documentation)

    * [Using AWS Lambda for Event-driven Data Processing Pipelines](https://aws.amazon.com/blogs/big-data/using-aws-lambda-for-event-driven-data-processing-pipelines/)

