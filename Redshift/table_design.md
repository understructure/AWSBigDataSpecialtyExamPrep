

## Table Design - Introduction

* Redshift architecture & its relationship to table design
* How to think about designing tables for Redshift
* Know your data - what are your relationships?
* Instead of indexes - sort keys
* Don’t lift and shift from existing DW solution to Redshift
* Star schema
* Test data set available here - [TPC-H](http://www.tpc.org/tpch/default.asp)


## Table Design - Distribution Styles

###One of three distribution styles

* **Even** (default distribution style)
  * rows distributed across slices in round-robin fashion regardless of values in column
  * Good for no joins, ok w/ reduced parallelism, where KEY and ALL are not a clear choice
  * Distribution style defined at end of DDL statement
* **Key** - Particularly used when joining tables
  * distribute data evenly among slices
  * Colocate data w/ same key on same slice
  * When distribution keys on large tables haven’t been defined, it can lead to significantly poor performance
  * **Good for** tables used in joins, large fact tables in star schema
  * Distribution style defined inline with table creation
* **All** - Copy of entire tables on all nodes of cluster
  * Good for data that does not change, e.g., not more than a few million rows
  * Reasonably sized tables (a few million rows),
  * ...and no common distribution key
  * Distribution style defined at end of DDL statement
* Extra Tips
  * Use guidelines, but also experiment and test
  * Five-part (extra) Resource - [AWS Big Data Blog - Redshift Engineering’s Advanced Table Design Playbook](https://aws.amazon.com/blogs/big-data/amazon-redshift-engineerings-advanced-table-design-playbook-preamble-prerequisites-and-prioritization/)

## **Exam Tips**

* Know all three distribution styles
* Know when you would use each
* Know their benefits and drawbacks


## Table Design - Sort Keys

* Data stored on disk according to sort key - query optimizer uses sort key to do query plans
* Closest thing to index (not a direct replacement)
* Not all tables need a sort key
* Block size is 1MB default - you don’t need to do anything
* Because block size is larger, I/O is reduced - this helps with performance
* **Zone Maps** - track min and max values for each block
* Load data in sort order - if not, sort key doesn’t really perform the way you thought it would - will read all blocks loaded before where your data is
  * have to run VACUUM command

* **Compound Sort Key** - contains all columns in sort key
  * Default sort type - beneficial when used with:
    * Joins
    * Order by, group by
    * Partition by and order by window functions
  * When you add large amounts of data to a table w/ a compound sort key, over time you have an unsorted region - large parts of table unsorted 
    * have to run a VACUUM operation
    * Then an ANALYZE operation
  * Table sorted by columns listed in sort key order
  * Poor performance if query does not include the primary sort column (first column in sortkey definition)

* **Interleaved Sort Key** - give equal weight to all columns in sort key
  * Useful when you’ve got multiple queries w/ different filters
  * Great when you need to have queries filtering on one or more sort key columns in the WHERE clause
  * Data loading and VACUUM will be slower
  * Most useful on very large tables only - 100 M + rows
  * NOT good for loading data in sort order
* Can have tables w/ single sort key

### Guidance on choosing sort keys
* TIMESTAMP column for recent data
* Columns used in BETWEEN conditions or equality operators
* Columns used in a join
* Same column can be used as SORT key and DISTRIBUTION key - can work very well
* Remember to use sort keys and distribution styles! - Very common cause of performance problems
* Tools - AWS scripts on GitHub

### Read These
* [Amazon Redshift Engineering’s Advanced Table Design Playbook: Preamble, Prerequisites, and Prioritization](https://aws.amazon.com/blogs/big-data/amazon-redshift-engineerings-advanced-table-design-playbook-preamble-prerequisites-and-prioritization/)
* [Optimizing for Star Schemas and Interleaved Sorting on Amazon Redshift](https://aws.amazon.com/blogs/big-data/optimizing-for-star-schemas-and-interleaved-sorting-on-amazon-redshift/)

### For The Exam:

* Know different sort key types and when to use them
* Know different sort key benefits and drawbacks


