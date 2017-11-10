# Improving Data Access with Secondary Indexes

* **Secondary Index** - data structure that contains a subset of attributes from a table, along with an alternate key to support Query operations
* A GSI is considered "global" because queries on the index can span all of the data in the base table, across all partitions
* An LSI is "local" in the sense that every partition of a local secondary index is scoped to a base table partition that has the same partition key value


## LSIs

* The primary key of a local secondary index must be composite (partition key and sort key). 
* For each partition key value, the total size of all indexed items must be 10 GB or less
* Queries and scans requesting non-LSI attributes will be returned from the base table automatically


## GSIs

* No size restrictions
* Can add or delete whenever
* Have their own provisioned throughput, not shared with base table, holds true for GSI updates due to table writes
* Queries or scans only fetch attributes in the GSI (including any projected attributes)



* For each secondary index, you have to specify the following:
    * Type of index (GSI / LSI)
    * Name of index (must be unique only in the scope of the table it's on, can have same named index in different tables)
    * Key schema - must be String, Number, or Binary type (remember "SNoBi" - get it, 'snobby'?)
        * For GSI, you can do whatever you want as long as datatypes are Snobby, range key optional
        * For LSI, partition key must be the same as the base table's partition key, sort key must be a non-key base table attribute
    * Projected attributes - optional, can project **any** attribute type, including scalars, documents, or sets
    * For GSIs, you have to specify the provisioned throughput of the index (LSIs share with base table)


* Can have max 5 LSIs and 5 GSIs on a table
* Use `DescribeTable` to get info on indexes, returns the following for every secondary index (refreshed every ~6 hours, so not realtime):
    * Name
    * Storage size
    * Item counts
* When using Query or Scan, you must specify:
    * Name of the base table
    * Name of the index that you want to use
    * Attributes to be returned in the results
    * Any condition expressions or filters that you want to apply
    
    
    
## Best Practices - LSIs

http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GuidelinesForLSI.html

* Use Indexes Sparingly
    * Unused indexes contribute to increased storage and I/O costs, and they do nothing for application performance
    * Avoid indexing tables, such as those used in data capture applications, that experience heavy write activity (copy data to another table, index that, and query it there if you need to)
* Choose Projections Carefully
    * As long as the projected index items are small, you can project more attributes at no extra cost (DynamoDB rounds writes up to 1KB anyway)
    * If you know that some attributes will rarely be queried, don't project them
* Optimize Frequent Queries To Avoid Fetches
    * DO project all of the attributes that you expect those queries to return
* Take Advantage of Sparse Indexes
* Watch For Expanding Item Collections


## Best Practices - GSIs

http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GuidelinesForGSI.html


* Choose a Key That Will Provide Uniform Workloads
* Take Advantage of Sparse Indexes
* Use a Global Secondary Index For Quick Lookups
* Create an Eventually Consistent Read Replica


