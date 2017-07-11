
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

### Running an EMR cluster in a private subnet
* You’ll get a warning that you’ll need an S3 endpoint to access S3
* Also need a NAT instance to communicate with DynamoDB, AWS KMS, and Amazon Kinesis
* To connect to EMR cluster in private subnet, you’ll need to have VPC connected via VPN, direct connect, or using Bastion Host

### Encryption at rest
* For cluster nodes (EC2 instance volumes - instance store and EBS), two things work together to provide this:
  * Open-source HDFS encryption
  * LUKS encryption - Linux Unified Key Setup
* For S3 / EMRFS, you can use:
  * Client-side encryption (CSE-KMS, CSE-Custom)
  * Server-side encryption (SSE-S3, SSE-KMS)

### Encryption in transit
* With S3:
  * For EMRFS traffic b/t S3 and cluster nodes (enabled automatically)
  * TLS encryption
* For distributed apps
  * Open source encryption functionality for Hadoop, Tez, and Spark

### Setting Up Encryption - At Rest
* Whether you’re using managed or custom roles, neither of them allows access to KMS store by default, so you’ll need to attach an Inline Role Policy for that to the role you’re using that allows access to the KMS master key
* Create a Security Configuration

* At-rest encryption on S3 - one of four modes
  * **SSE-S3** - Server Side Encryption with S3-managed encryption keys
  * **SSE-KMS** - Server Side Encryption with KMS-managed keys
    * EMR cluster sends data to S3
    * S3 uses customer master key that’s managed in KMS to encrypt and decrypt data before sending it to S3 bucket
  * **CSE-KMS** - Client Side Encryption with KMS-managed keys
    * Uses customer master key to encrypt data before sending to S3
    * Decrypts data after it’s been downloaded
  * **CSE-Custom** - If you need to: 
    * encrypt data before sending it to S3
    * want to manage key yourself, AND 
    * use custom client-side master key
    * Requires a custom key provider JAR file, enter full class name of class that implements the EncryptionMaterialsProvider Java interface

* At-rest encryption on Instance Store volumes of EBS volumes (both are automatically setup for you when you attach a security configuration to a cluster and create the cluster)
  * Open source HDFS encryption
  * LUKS encryption
* When setting up local disk encryption, you can either use CSE-KMS or a Custom option (custom option is like S3 CSE-Custom option)

* Whether you use EBS or Instance Store volumes, once you
  * Select the at-rest encryption checkbox
  * And your encryption mode
  * And attach the security configuration to the cluster you’re launching
* EMR will automatically update
  * **core-site.xml** - updates property **hadoop.rpc.protection** to value=**privacy**
  * **hdfs-site.xml** - updates property **dfs.encrypt.data.transfer** value=**true**

#### Setting Up Encryption - In Transit
* Through Security Configuration section
* Essentially what we’re setting up is in-transit encryption between the nodes within your cluster (e.g., for Hadoop, Tez, and Spark)
* Check In-Transit Encryption checkbox
* Two options:
  * **PEM** - can create a zip file of .pem certificates and store them in S3, where EMR will download these certificates to each node and implement encryption in transit
    * Can create these certs [using open-ssl per AWS documentation](http://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-encryption-certificates.html)
    * In DEV, it’s OK to use self-created certs, but in prod, it’s a risk
  * **Custom option** (custom option is like S3 CSE-Custom option) 

* [Hadoop Encrypted Shuffle](https://hadoop.apache.org/docs/r2.7.1/hadoop-mapreduce-client/hadoop-mapreduce-client-core/EncryptedShuffle.html) - process of transferring data from mappers to reducers - from node to node w/in the cluster
* Allows encryption of mapreduce shuffle using HTTPS
* Two files updated
  * **core-site.xml** - properties related to SSL keystore
    * hadoop.ssl.require.client.cert
    * hadoop.ssl.hostname.verifier
    * hadoop.ssl.keystores.factory.class
    * hadoop.ssl.server.conf
    * hadoop.ssl.client.conf
    * hadoop.ssl.enabled.protocols
  * **mapred-site.xml**
    * mapreduce.shuffle.ssl.enabled (set from false to true)



