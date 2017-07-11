### EMR Operations Part 1

* EMR releases - [http://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-release-components.html](http://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-release-components.html) 

    * Amazon EMR or MapR hadoop distribution

* 3 categories of components

    * Available from open source community

    * Open source AWS modifies to work with EMR (amzn)

    * Components provided just for use with EMR (e.g., EMRFS)

* Pre-built scripts and applications

    * Java, Scala, Python, Pig, Hive, .NET, etc.

    * Can automatically launch from S3

    * Interactive mode

Quick vs. Advanced Options - EMR console

* Quick

    * No debugging in quick

    * No selection of VPC (launched in default)

    * Can only pick from limited list of configs

    * Can only use one instance type, task nodes not available

    * Only latest EMR versions available

    * Can’t create custom security groups on launch

* Advanced

    * Can "Edit Software Settings" to e.g., change hadoop settings like data node heap size of core node

    * If you launch cluster in private subnet, have to create a VPC endpoint for S3 or create NAT instance for cluster to interact with other services that don’t support VPC endpoints - [http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-endpoints.html](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-endpoints.html)

    * Can resize cluster using autoscaling

    * Can do spot instances

    * You can create tags, but always tag using EMR Console, EMR CLI or EMR API - if you tag w/ EC2 console, EMR won’t know about it

    * Can select EMRFS consistent view

    * Bootstrap actions - [https://github.com/awslabs/emr-bootstrap-actions](https://github.com/awslabs/emr-bootstrap-actions)

    * Can select if cluster is visible to everyone in IAM users in account

    * Creates 2 security groups - one for Master, one for Core & Task

    * Can assign additional security groups to Master and Core & Task instances

    * Can do custom security groups so you don’t have to modify the default ones
