# Big Data Analytics Options on AWS

https://d0.awsstatic.com/whitepapers/Big_Data_Analytics_Options_on_AWS.pdf

## Amazon Kinesis Streams

* capture and store terabytes of data per hour from hundreds of thousands of sources in realtime
* blocks in 1 MB / sec

### Ideal Usage Patterns

* Real-time data analytics
* Log and data feed intake and processing
* Real-time metrics and reporting


* Two pricing components, an hourly charge per shard and a charge for each 1 million PUT transactions
* Synchronously replicates data across three Availability Zones in an AWS Region

### Anti-Patterns

* Small scale consistent throughput (< 200 KB / sec)
* Long-term data storage and analytics (1-7 days storage)


## AWS Lambda

### Ideal Usage Patterns

* Real-time file processing 
* Real-time stream processing
* ETL
* Replace cron
* Process AWS events


* $0.20 per million requests
* $0.00001667 per GB-second used
* Ready within seconds of provisioning
* No downtime or maintenance windows
* No limit on number of functions you can run
* Soft limit of 100 concurrent

### Anti-Patterns

* Long-running applications - if you need more than 5 minutes, create a chain where one calls another
* Dynamic websites
* Stateful applications

## Amazon Elastic MapReduce

### Ideal Usage Patterns

* Log processing and analytics
* Large extract, transform, and load (ETL) data movement
* Risk modeling and threat analytics
* Ad targeting and click stream analytics
* Genomics
* Predictive analytics
* Ad hoc data mining and analytics

* EMR with MapR Hadoop distribution provides a no-NameNode architecture that can tolerate multiple simultaneous failures with automatic failover and fallback
* Hive QL goes beyond standard SQL, adding first-class support for map/reduce functions and complex extensible userdefined data types like JSON and Thrift
* HBase - modeled after Google's BigTable
    * Optimized for sequential writes
    * Doesn't use EMRFS - have to backup to S3 and restore

### Anti-Patterns

* Small datasets
* ACID transactions

## Amazon Machine Learning

### Ideal Usage Patterns

* Enable applications to flag suspicious transactions 
* Forecast product demand
* Personalize application content
* Predict user activity
* Listen to social media

*  Each ML model that is enabled for real-time predictions can be used to request up to 200 transactions per second by default
*  process data sets that are up to 100 GB in size

### Anti-Patterns

* Very large datasets (> 100 GB)
* Unsupported learning tasks (clustering, unsupervised learning, sequence prediction)
* Predicting more than 100 classes for multiclass (see [limits](http://docs.aws.amazon.com/machine-learning/latest/dg/system-limits.html))


## Amazon DynamoDB

*  primary key can either be a singleattribute hash key or a composite hash-range key

### Ideal Usage Patterns

* Mobile apps
* Gaming
* Digital ad serving
* Live voting
* Audience interaction for live events
* Sensor networks
* Log ingestion
* Access control for web-based content
* Metadata storage for Amazon S3 objects
* E-commerce shopping carts
* Web session management


### Anti-Patterns

* Prewritten application tied to a traditional relational database
* Joins or complex transactions
* Binary large objects (BLOB) data
* Large data with low I/O rate

## Amazon Redshift

### Ideal Usage Patterns

* Analyze global sales data for multiple products
* Store historical stock trade data
* Analyze ad impressions and clicks
* Aggregate gaming data
* Analyze social trends
* Measure clinical quality, operation efficiency, and financial performance in health care 

### Anti-Patterns

* Small datasets (< 100 GB)
* OLTP
* Unstructured data
* BLOB data


## Amazon Elasticsearch Service

### Ideal Usage Patterns

* full-text search, structured search, analytics, and all three in combination
* With Logstash, an opensource data pipeline that helps you process logs and other event data
* With Kibana, an open-source analytics and visualization platform
* Analyze activity logs, such as logs for customer-facing applications or websites
* Analyze CloudWatch logs with Elasticsearch
* Analyze product usage data coming from various services and systems
* Analyze social media sentiments and CRM data, and find trends for brands and products
* Analyze data stream updates from other AWS services, such as Amazon Kinesis Streams and DynamoDB
* Provide customers with a rich search and navigation experience
* Monitor usage for mobile applications

### Anti-Patterns

* OLTP
* Petabyte size data stores

## EC2

### Ideal Usage Patterns

* A NoSQL offering, such as MongoDB
* A data warehouse or columnar store like Vertica
* A Hadoop cluster
* An Apache Storm cluster
* An Apache Kafka environment
* Specialized environments (as above)
* Compliance requirements

### Anti-Patterns

* If a managed service is available and that's what you need
* Lack of expertise or resources






