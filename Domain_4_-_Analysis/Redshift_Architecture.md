### Redshift Architecture

* Redshift cluster is a cluster of tightly-coupled EC2 instances in a single AZ

    * Because leader node & compute nodes need to be in close proximity network-wise for performance reasons (run on 10GB ethernet mesh network)

* **Leader Node**

    * Has a SQL endpoint, looks like this: 
    
    `<cluster_name>.<unique_id>.<region_name>.redshift.amazonaws.com:5439`

    * Coordinates parallel query execution (compiles to C++)

    * Stores metadata (think system tables)

* **Compute nodes**

    * Execute queries in parallel

    * Has dedicated CPU, memory & local storage

    * Scale out/in, up/down

    * Backups done in parallel

    * Consist of slices

**Node Slices** 

* Consist of a portion of memory & disk, data loaded in parallel

* Number of slices depend on type of node

* Come into the picture during table design

**Types of nodes:**

**Dense Compute** - density - high performacne databases - great if you need lots of CPU, RAM and solid state drives

**Dense Storage** - Large data warehouses, less expensive, very large hard drives

* Can have Reserved Instance Pricing for Redshift as well

* [https://aws.amazon.com/redshift/pricing/](https://aws.amazon.com/redshift/pricing/)

* Massively Parallel Processing Database, Shared-Nothing Architecture

* Data stored on multiple nodes

* Nodes have dedicated CPU, memory & local storage

* Nodes are independent, self-sufficient, no disk sharing, no contention b/t nodes

* All communication happens on a high-speed network

**Resources**

[Data Warehousing on AWS](https://d0.awsstatic.com/whitepapers/enterprise-data-warehousing-on-aws.pdf)
