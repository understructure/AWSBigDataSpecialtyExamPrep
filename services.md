
| Service / Item                        | Domain            | H/M/L  | Notes                                                              |
|---------------------------------------|-------------------|--------|--------------------------------------------------------------------|
| Kinesis Firehose                      | 1 - Collection    | High   |                                                                    |
| Data Pipeline                         | 1 - Collection    | Medium | Much of this functionality has been replaced by Lambda             |
| SQS                                   | 1 - Collection    | Low    | Really only need to know when you'd use this over Kinesis Firehose |
| IoT                                   | 1 - Collection    | High   |                                                                    |
| Kinesis Streams                       | 2 - Storage       | High   |                                                                    |
| DynamoDB                              | 2 - Storage       | High   |                                                                    |
| EMR - Hadoop                          | 3 – Processing    | Medium |                                                                    |
| EMR - Architecture                    | 3 – Processing    | High   |                                                                    |
| EMR - Operations                      | 3 – Processing    | High   |                                                                    |
| EMR - Hue                             | 3 – Processing    | Low    |                                                                    |
| EMR - Presto                          | 3 – Processing    | Low    |                                                                    |
| EMR - Spark                           | 3 – Processing    | High   |                                                                    |
| EMR - File Storage and Compression    | 3 – Processing    |        |                                                                    |
| Lambda                                | 3 – Processing    | High   |                                                                    |
| Redshift - Architecture               | 4 - Analysis      | High   |                                                                    |
| Redshift - Table Design               | 4 - Analysis      | High   |                                                                    |
| Redshift - Workload Management        | 4 - Analysis      | High   |                                                                    |
| Redshift - Loading Data               | 4 - Analysis      | High   |                                                                    |
| Redshift - Maintenance and Operations | 4 - Analysis      | High   |                                                                    |
| Machine Learning                      | 4 - Analysis      | High   |                                                                    |
| Elasticsearch                         | 4 - Analysis      | Medium |                                                                    |
| QuickSight                            | 5 - Visualization | High   | Practically the only thing in this domain                          |
| Big Data Visualization                | 5 - Visualization | High   | Zeppelin and Jupyter Notebook                                      |
| EMR - Security                        | 6 - Security      | High   | Especially Hadoop Encrypted Shuffle                                |
| Redshift - Security                   | 6 - Security      | High   | Especially database encryption                                     |