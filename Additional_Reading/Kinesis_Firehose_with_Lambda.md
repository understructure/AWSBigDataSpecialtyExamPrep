# Amazon Kinesis Firehose Data Transformation with AWS Lambda

https://aws.amazon.com/blogs/compute/amazon-kinesis-firehose-data-transformation-with-aws-lambda/

Use cases

* light preprocessing or mutation of the incoming data stream before writing it to the destination
* normalizing data produced by different producers
* adding metadata to the record
* converting incoming data to a format suitable for the destination

* Old Pattern:  Deliver data to S3, then use S3 event notification to trigger Lambda
* New Pattern:  Use Firehose Data Transformations - call Lambda to do transforms directly on the stream

## Introducing Firehose Data Transformations

* When envoked, Firehose buffers incoming data and invokes Lambda function per buffered batch *asynchronously*
* Can choose to do source record backup, copies all untransformed records to S3 concurrently during transform delivery to destination
* Blueprints available for Apache Log or Syslog to CSV or JSON as well as "General Firehose Processing"
* Destination bucket must exist
* Can use same bucket for source record backup (unprocessed records)

## What the function does

* Filtering - Removes records that don't meet certain conditions
* Mutation - adding fields
* Transformation - conversion of record from one format to another (e.g., JSON to CSV)
* Returns processed record back to stream for delivery

## Options

* Buffer size must be between 1-128 MB
* Buffer interval must be between 60-900 seconds
* Compression - can use GZIP, Snappy, or Zip
* Encryption - Must select a KMS master key - either "(Default) aws/s3" or another one you select
