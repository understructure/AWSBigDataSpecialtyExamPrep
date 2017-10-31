### EMR Operations Part 2

* [EMR Best Practices Document](https://d0.awsstatic.com/whitepapers/aws-amazon-emr-best-practices.pdf)
* [EMR Release Guide](http://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-release-components.html)

* Components - open source, AWS-modified, and EMR-specific components
* communityVersion-amzn-emrReleaseVersion

#### Long Running Clusters

* Keep HDFS on Core nodes

* Auto-termination is disabled (by default)

* Termination protection is enabled

#### Transient Clusters

* Batch jobs, only when needed

* Input and output data and code stored in S3

* A one-node cluster considers the Master node to also be the Core node
