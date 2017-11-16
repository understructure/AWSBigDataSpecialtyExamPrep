# DynamoDB Best Practices

http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/BestPractices.html

## Table Best Practices

### Design For Uniform Data Access Across Items In Your Tables

* "Simple primary key" = just partition key
* "Composite primary key" = partition + sort key
* Good partition key choices include:
    * User ID, where the application has many users
    * Device ID, where even if there are a lot of devices being tracked, one is by far more popular than all the others
* You may want to add a random value to a partition key to get it to write to more partitions, or use a "calculated value"
* Calculated value example:  Add something to a key of date (YYYY-MM-DD) based on order ID, product ID, etc.  so you can more easily select the correct values later

### Understand Partition Behavior

* Initial allocation of partitions doesn't work the same as subsequent allocation of partitions!
* When calculating partitons based on WCU and RCU, add the calculations for each together BEFORE rounding up
* If you manually increase RCUs or WCUs such that it requries another partition, the number of partitions won't increase by one, but will **double**
* If a partitions fills up to 10 GB and needs to split, the RCUs and WCUs allocated to the original partition will be **split** between the two new partitions
    * This results in the non-split partitions keeping their original allocations, which means you'll have different RCUs and WCUs assigned to different partitions
* Use Burst Capacity Sparingly
* Distribute Write Activity During Data Upload - If UserID is your partition key, don't write all messages for user 1, then user 2, etc.  Write a message per user across a bunch of users, if possible
* Understand Access Patterns for Time Series Data - If data will be archived or deleted, store with one table per week or month, then archive or drop that table when no longer needed
    * Deleting an entire table is significantly more efficient than removing items one-by-one, which essentially doubles the write throughput as you do as many delete operations as put operations
* Cache Popular Items - avoid table hotspots due to, e.g., popular products
* Consider Workload Uniformity When Adjusting Provisioned Throughput
    * remember, reducing throughput doesn't reduce number of partitions
    * You can update your throughput only 4 times a day, technically, but it works out to 9, because you can do it four times in the first 4 hours of a day, and then once every 4 hours after that if you haven't updated it in the last 4 hours.  See [limits](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html) for more information
* Test Your Application At Scale

## Item Best Practices

* Use One-to-Many Tables Instead Of Large Set Attributes
    * If your table has items that store a large set type attribute, such as number set or string set, consider removing the attribute and breaking the table into two tables. 
    * To form one-to-many relationships between these tables, use the primary keys
* Compress Large Attribute Values
* Store Large Attribute Values in Amazon S3
* Break Up Large Attributes Across Multiple Items
* Query and Scan Best Practices


## Performance Considerations for Scans

* Avoid Sudden Spikes in Read Activity - The Scan operation provides a Limit parameter that you can use to set the page size for your request
* Take Advantage of Parallel Scans (if the following criteria are met):
    * The table size is 20 GB or larger.
    * The table's provisioned read throughput is not being fully utilized.
    * Sequential Scan operations are too slow.
* TotalSegments - recommend 1 segment per 2 GB of data

## Local Secondary Index Best Practices

* Use Indexes Sparingly - avoid indexing heavy write tables - better to make a copy of the table and query the offline version
* Choose Projections Carefully
    * Specify ALL only if you want your queries to return the entire table item but you want to sort the table by a different sort key
* Optimize Frequent Queries To Avoid Fetches
* Take Advantage of Sparse Indexes
* Watch For Expanding Item Collections

## Global Secondary Index Best Practices

* Choose a Key That Will Provide Uniform Workloads
* Take Advantage of Sparse Indexes
* Use a Global Secondary Index For Quick Lookups
* Create an Eventually Consistent Read Replica
