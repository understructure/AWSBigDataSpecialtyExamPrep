### EMR Operations Part 4

#### Monitoring

* Cloudwatch Events

    * Repsond to state changes in resources

    * Send event into an event stream

* Cloudwatch >> Create Rule

    * Event Pattern

    * Service name = EMR

    * Event type = State Change

    * Can pick "Any State" or “Specific States”

    * Can pick "Any cluster" or “Specific Cluster ID(s)”

    * Target - can select SNS topic

* Cloudwatch metrics - every 5 minutes, CANNOT configure this to 1-minute intervals!

* Archived for 2 weeks

* Provided as part of EMR - no charge

* Cloudwatch JobFlowID = EMR ClusterID

* Web interfaces - [http://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-web-interfaces.html](http://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-web-interfaces.html)

* Can setup an SSH tunnel to master node using local port forwarding - [http://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-ssh-tunnel-local.html](http://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-ssh-tunnel-local.html)

* SSH tunnel to master node using dynamic port forwarding along with SOCKS proxy

* Ganglia - monitoring system - monitor CPU, memory usage, network traffic, etc. at individual node level if you want

#### Resizing

* Manual

* Autoscaling groups

* Scaling down - scale down at billing hour or task completion - "Graceful shrink"

* Resizing core nodes

    * Keep replication factor in mind, you can’t have less core nodes than the replication factor

    * To get past this limit, lower the replication factor in hdfs-site.xml, restart the NameNode daemon

* Autoscaling of Core nodes added in November 2016 - status goes from PENDING to ATTACHED

* Default Autoscaling role selected for you, if you decide to use custom roles, and you don’t add a role to do autoscaling on EMR, then it can’t be added after cluster has been created - have to recreate cluster
