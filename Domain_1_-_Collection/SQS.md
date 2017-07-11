### SQS

* Exam - need to understand where you’d use SQS vs. Kinesis Streams

* Reliable, scalable service for distributing data b/t servers (sending, storing, retrieving)

* Hosted queues

* Queue acts as a buffer b/t producers and consumers of data

* Solves problems where producers are producing data faster than consumers can consume it, or if producers and consumers only available intermittently

* Up to 256KB text

* Any app can store data in "failsafe" queue

* Any app can retrieve from queue

* For messages > 256KB, can use SQS Extended Client for Java, which uses S3

* Ensures at least once delivery

* Single queue can be used by many components

* FIFO queues are supported

    * Messages are available until consumer consumes and then deletes them

    * Duplicates not introduced into queue

* Can create queue in any region

* Messages stored up to 14 days

* Messages can be sent and read simultaneously

* Long polling reduces extraneous polling

    * Wait for up to 20 seconds before returning, even if empty

    * Cost the same as regular requests

![image alt text](image_0.png)

* TL;DR - can use auto scaling groups based on size of queue if needed

* Can also have priority queues to process more important things first - poll high priority queue until empty, then poll lower priority queue

![image alt text](image_1.png)

* SQS Fanout - Use SNS topics to send messages to multiple SQS queues all at the same time

* Each queue may do something different with the same information

* Allows for parallel and asynchronous processing

**For the exam**

* **SQS** is a message queue service allowing you to move data b/t distributed components of applications w/out losing messages or requiring each application component to be always available

* **Kinesis Streams** is used for processing big data

* Be familiar with SQS use cases

    * Order processing

    * Image processing

* Be familiar with Kinesis Streams use cases (Keep in mind, it’s likely that with any of these use cases, data is emitted to something like Redshift, S3, Elasticsearch, EMR, DynamoDB, etc.)

    * Fast log and data feed intake and processing

    * Real-time metrics and reporting

    * Real-time data analytics

    * Complex stream processing

