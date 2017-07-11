### DynamoDB Streams and Replication

#### Streams

* Ordered record of updates to a DynamoDB table

* Values stored for 24 hours

* Stream can be enabled from AWS console or API

* Can only be read or processed by Streams endpoint and API requests

* Stream endpoint is different than table endpoint, looks like this:

    * streams.dynamodb-<region_name>.amazonaws.com

* AWS guarantee each change to a DynamoDB table occurs in stream only once

* These changes occur in near-realtime

* Changes recorded in streams have a "limitation" - you initially don’t know the nature of the operation on the partition key (don’t know specific details of what attributes changed, pre/post states of attribute values, etc.)

* To overcome this, streams can be configured with one of four "views"

    * **KEYS_ONLY** - only key attributes are written to the stream (doesn’t do much good)

    * **NEW_IMAGE** - entire item POST update written to the stream (after)

    * **OLD_IMAGE** - entire item PRE update written to the stream (before)

    * **NEW_AND_OLD_IMAGES** - pre and post operation state of the item is written to the stream, allowing more complex comparison operations to be performed

#### Streams and Replication

##### Use Cases

* Replication

* Triggers

* DR - database table in one AW region, replicating to another region for DR failure

* Lambda function triggered when new record added to stream, do analytics on data

* Lambda function triggered when new user signup on web app, data entered into users table, email sent to users, etc.

* Large distributed applications with users worldwide - using a multi-master database model.  A synched set of tables operating worldwide.

##### Example w/ CloudFormation and Elastic Beanstalk

* Create or select table to be replicated

* Apply cloud formation stack and wait

* Login to the console and create a replication group **identify** (?)

* Wait for process to be completed, in the background additional checkpoint tables will be created

* See this link from AWS for more info: [http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Streams.CrossRegionRepl.html](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Streams.CrossRegionRepl.html)

* With DynamoDB Streams and Lambda, you can create an event-driven architecture where streams are captured and invoked by Lambda functions so that the Lambda function you write can copy the data to a different region (no need for EC2 instance w/ Kinesis Client Library)

For the Exam

* Understand capability of DynamoDB Streams

* Understand use cases of DynamoDB Streams

* Know that Streams + Lambda allow traditional DB style triggers (lots of questions)

* Know the four "views" of streams:

    * **KEYS_ONLY** - only key attributes are written to the stream (doesn’t do much good)

    * **NEW_IMAGE** - entire item POST update written to the stream (after)

    * **OLD_IMAGE** - entire item PRE update written to the stream (before)

    * **NEW_AND_OLD_IMAGES** - pre and post operation state of the item is written to the stream, allowing more complex comparison operations to be performed

* Understand cross-region replication as a feature of DynamoDB Streams
