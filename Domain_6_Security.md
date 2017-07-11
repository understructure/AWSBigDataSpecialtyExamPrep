
## EMR Security

* Security Groups
* IAM Roles
* Running an EMR cluster in a private subnet
* Encryption at rest
* Encryption in transit

### Security Groups


* EMR managed security groups
  * On cluster launch, you must select two security groups (EMR creates default managed SG’s for you the first time you use it, and will set these up so instances can communicate properly):
    * Master node
    * Core and Task nodes
  * The advantage to using your own instead of EMR managed SG’s is if you have multiple EMR clusters and you want them all separated
  * If you use your own, EMR will also update the rules so the nodes can all communicate
* Additional security groups
  * These give you the flexibility to have your own rules, but not mess with the rules of the EMR managed security groups
  * Use case: if you want ssh access to master

### IAM Roles
* **EMR role** - allows EMR service to access EC2
* **EC2 Instance Profile** - allows EC2 instances in your cluster to access S3, DynamoDB, and other services
* **Auto Scaling role** - allows AutoScaling service to start and terminate nodes when you have AutoScaling setup for your Core and Task nodes
* Usually the default roles that come out of the box are fine, unless you want to do something like encrypt your EC2 nodes, then you’d want a Custom role for the EC2 Instance Profile role

