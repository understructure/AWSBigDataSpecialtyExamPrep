### EMR Operations Part 2

* [http://media.amazonwebservices.com/AWS_Amazon_EMR_Best_Practices.pdf](http://media.amazonwebservices.com/AWS_Amazon_EMR_Best_Practices.pdf)

#### Long Running Clusters

* Keep HDFS on Core nodes

* Auto-termination is disabled (by default)

* Termination protection is enabled

#### Transient Clusters

* Batch jobs, only when needed

* Input and output data and code stored in S3

* A one-node cluster considers the Master node to also be the Core node
