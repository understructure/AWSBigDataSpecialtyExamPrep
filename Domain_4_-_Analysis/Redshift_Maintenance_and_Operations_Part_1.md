### Redshift Maintenance and Operations Part 1

#### Launching Clusters

* Cluster identifier, database name, database port, master username, master password, confirm password

* Select node types

    * DC1, DS1, DS2

    * DC1.large, DC1.8xlarge

    * DS2.xlarge, DS2.8xlarge

    * DS1.xlarge, DS1.8xlarge

    * DS1 vs. DS2 - DS2 are newer, give better performance at no extra cost

* If you have very large amounts of data - use DS2

* If you need very high I/O - use DC1 - DC1 uses SSD storage

* Node selection

    * Cluster should have free space worth 2 - 2.5x times the size of your largest table

    * Know for exam - specs (e.g., node range, slices per node, storage per node) for various node sizes - study Dense Storage Node Types and Dense Compute Node Types tables on this page: [http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html](http://docs.aws.amazon.com/redshift/latest/mgmt/working-with-clusters.html)

* Select parameter group or create new one - can set timeouts, configure cluster to require SSL connection (REQUIRE_SSL param to true)

* Encrypt database - none, KMS, HSM

* Choose VPC, subnet group, publicly accessible, public IP address, enhanced VPC routing, AZ, security groups

* Can select role so you don’t have to have keys on nodes

#### Resizing Clusters

* THINK - how much data do you have, how much is coming in, how much going out, in what timeframe?

* Resize process

    * Notification kicks off creation of target cluster

    * Source cluster is restarted and goes into read-only mode, all running queries and connections are terminated

    * Reconnect to source cluster to run queries in read-only mode

    * Redshift starts to copy data from source cluster to target cluster

    * Once data copying has completed, Redshift updates the DNS endpoint of the target cluster with the DNS endpoint of the source cluster

    * Source cluster is decommissioned

#### For the Exam

* Study Node Type details table - you may be asked about resizing a cluster from a few large nodes to a cluster w/ many small nodes

* What types of workloads DC1 nodes are good for vs DS2

    * DC1 - high I/O (SSD) but less storage

    * DS2 - very large amounts of data, HDD storage
