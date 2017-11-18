
# Optimizing for Star Schemas and Interleaved Sorting on Amazon Redshift

https://aws.amazon.com/blogs/big-data/optimizing-for-star-schemas-and-interleaved-sorting-on-amazon-redshift/

* **Key Distribution** -  If no column provides relatively even data distribution using a KEY distribution style, then choose a style of EVEN



* **Sort Keys** - Amazon Redshift improves query performance when the sort key is used in the where clause (often called a filter predicate) by checking the min and max value in a block and skipping blocks of data that do not fall into the range defined by the predicate


**Compound**

* A compound sort key can include up to 400 columns
* A good rule of thumb is to keep the number of columns to six or fewer when using a compound sort key
* useful when a *prefix* of the sort key columns is used to filter data in the query

**Interleaved**
* Use interleaved sort keys when you do not know exactly which combinations of columns will be used in your queries
* Interleaved sort keys can have up to 8 columns - improves query performance when any subset of the keys (in any order) are used in a filter predicate
* Queries perform faster as more columns in interleaved sort key are used in predicate
* *But* - tables using interleaved sort keys perform better with fewer sort keys defined (columns in a sort key?)

* Example: 

* If you have a COMPOUND key on item, size and color and you query on all three, you'll get a fast query
* If you have a COMPOUND key on item, size and color and you query on only item and size, you'll still get a benefit because it's the first two columns (using a prefix of the key)
* If you have a COMPOUND key on item, size and color and you query on only item and color, it will have little to no effect - still might be faster if first column has high cardinality

* If you have an INTERLEAVED key on item, size and color, any of the above queries will perform well

**Tradeoffs**

* Compound sort keys are easier to maintain, help in joins, aggregations, and order bys
* Interleaved sort keys are harder to maintain, and give none of those benefits
* Interleaved - good use case is a large fact table (> 100M+ rows) where typical data query patterns use different subsets of the columns in filter predicates
* Benefits of Interleaved sort key increase with table size
* Compound - better when frequently appending data in order (e.g., time series table) - preserves ordering, while interleaved keys don't and require a VACUUM command
* May choose to maintain two tables, one with each kind of key




