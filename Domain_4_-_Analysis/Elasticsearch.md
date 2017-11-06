### Elasticsearch

* ES - distributed, multi-tenant-capable full-text search engine

* HTTP web interface

* Schema-free JSON documents

* **Logstash** - data collection & log parsing engine

* **Kibana** - open source data viz and exploration tool

* "ELK stack"

* Use cases:

    * Search

    * Logging analysis (e.g., for near realtime security)

    * Distributed document store

    * Real-time app monitoring (again, using logs)

    * Clickstream weblog ingestion

* AWS ES Service - fully managed

    * Prior, had to install ES on EC2

    * Now, underlying instances provisioned for you, along with patching, failure recovery, backups, monitoring, security (IAM for security, CloudTrail for auditing)

* **Elasticsearch Service Domain** - AWS term - Collection of all the resources you need to run your ES cluster

#### Cluster configuration

* Number and type of instances

* Dedicated master nodes (Yes/No) - 

    * used to increase cluster stability

    * performs cluster management tasks, but doesn’t hold data or respond to data upload requests.

    * Offload cluster management tasks to increase stability of cluster

    * Tracking all nodes in cluster

    * Tracking number of indices in cluster

    * How many shards belong to each index

    * Cluster state changes, etc.

    * AWS recommends 3 dedicated master nodes for each Amazon ES domain in production

    * One active master node that handles all cluster management tasks, rest are passive until master fails

    * See [Managing Amazon Elasticsearch Service Domains](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-managedomains.html) for guidelines on number of data and master nodes 

* Distribute across AZs, setup replica of cluster for HA

* Storage and snapshot settings - instance store or EBS volumes

* Index settings

* IAM policies to allow / block access to a domain

#### ES and Other Services

* Elasticsearch + IoT

    * Can write rule action to write data from MQTT messages to ES service domain

    * Data in ES can then be visualized w/ something like Kibana

* ES + S3, DynamoDB, Kinesis Streams, Kinesis Firehose, Cloudwatch all integrate through Lambda

    * Lambda function reacts to new data by processing it, and streaming it to the ES Service Domain

![image alt text](../images/domain4_3.png)

#### Indices and Shards

* Data nodes handle all data upload requests

* Index ~= table - logical namespace, maps to 1+ primary shards and 0+ replica shards

* (schema-free) JSON docs ~= rows, stored in a shard

* When you add a document to an index, it’s first stored on primary shard, then on replica shard if required

* Replica shards:

    * Help with performance

    * Help if there’s an issue with the primary shard

* Search requests can be handled by either primary or replica shard

* A replica shard is on a separate node from its primary counterpart

* AWS - can setup zone awareness - allocate nodes across two AZs in the same region

    * E.g., primary shards in us-east-1a and replicas in us-east-1b

    * HA, but slight uptick in network latency
    
    * Also requires even number of nodes in each AZ

* DEMO - follows [How to Visualize and Refine Your Network’s Security by Adding Security Group IDs to Your VPC Flow Logs](https://aws.amazon.com/blogs/security/how-to-visualize-and-refine-your-networks-security-by-adding-security-group-ids-to-your-vpc-flow-logs/#more-3559)

#### Logstash

* Data collection & log parsing engine

* AWS ES Service integrates with the Logstash output plugin - AWS - can download from Github

    * Can install this on app instance, which then pushes data to AWS ES Service domain

* Can use this without having to write code, however, you do have to install it on your application server

* Lambda, of course, is serverless, but you do have to write code

**For the exam:**

* Know the basics of AWS ES service

* Have a high-level understanding of how Kibana and Logstash are used with AWS ES Service
