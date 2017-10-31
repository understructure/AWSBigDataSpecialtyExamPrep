### EMR Operations Part 2

* [EMR Best Practices Document](https://d0.awsstatic.com/whitepapers/aws-amazon-emr-best-practices.pdf)
* [EMR Release Guide](http://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-release-components.html)

* Components - open source, AWS-modified, and EMR-specific components
* communityVersion-amzn-emrReleaseVersion

#### Quick Options Limitations

* Can only pick from four options, each option is a set of packages
* Can only run most recent versions (not extremely old ones) of EMR
* Can only run a single instance type, no mix 'n match
* Can only select default security groups (but can change them after cluster has been launched)
* Can't choose to create Task nodes?

#### Advanced Options

* Can tag, but if you tag instances in EC2 console, those won't synch back to EMR

#### Long Running Clusters

* Keep HDFS on Core nodes

* Auto-termination is disabled (by default)

* Termination protection is enabled

#### Transient Clusters

* Batch jobs, only when needed

* Input and output data and code stored in S3

* A one-node cluster considers the Master node to also be the Core node
