## EMR Operations Part 2

### Long Running Clusters

* Keep HDFS on Core nodes
* Auto-termination is disabled (by default)
* Termination protection is enabled

### Transient Clusters

* Batch jobs, only when needed
* Input and output data and code stored in S3
* A one-node cluster considers the Master node to also be the Core node

## Resources
* [EMR Best Practices Whitepaper](https://d0.awsstatic.com/whitepapers/aws-amazon-emr-best-practices.pdf) 
* [My summary of EMR Best Practices Whitepaper](../Additional_Reading/EMR_Best_Practices.md)

---

* [Back: EMR Operations Part 1 (12:23)](EMR_Operations_Part_1.md)
* [Next: EMR Operations Part 3 (7:12)](EMR_Operations_Part_3.md)
