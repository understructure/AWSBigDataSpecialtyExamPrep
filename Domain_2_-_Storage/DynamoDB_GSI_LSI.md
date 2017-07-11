### DynamoDB GSI / LSI

DynamoDB - SCAN vs. QUERY

    * SCAN -goes through table and returns all attributes for all items for given table or index

    * QUERY can select single record if you include 1 partition key value, or partition + sort value if table uses sort keys

* Using a single partition key and a range of sort values, multipole items can be returned very efficiently

* Without indexes, your ability to retrieve information is limited to your primary table structure - has to be based on single partition key value or partition + sort key combo

* Indexes allow secondary representation of your data in a table, allowing efficient queries on those representations

* Global and Local Secondary Index types

#### Local Secondary Indexes (LSI)

* Given a weather station table where partition key is station ID and sort value is datetime stamp

    * If you want to query the table for where some attribute = True, you have to scan the whole table unless you configure an LSI

* LSIs can only be created at time of table creation

    * In this case, keep partition key (and original sort key), but use alternate sort key of True/False column

    * LSIs contain:

        * Partition key

        * Original sort key

        * New sort key

        * Optional projected values

* **Projected values** - non-key attributes you decide to also have stored in the table if additional lookups are required

* Information written to LSI is copied asynchronously from the main table

* Anything using LSIs should assume element of eventual consistency, as the data is copied b/t the table and its indexes

* Writing to / reading from index consumes RCU’s and WCU’s of main table (shares WCU’s and RCU’s with main table)

* LSI is a sparse index - index will only have an ITEM if index sort key attribute is contained in the table item (row)

    * Sparse index allows very efficient data lookups in this use case - where you’re actively looking for data based on presence of a certain attribute

#### Storage and Performance Considerations w/ LSIs

##### Reads

* By default, any non-key values aren’t stored in an LSI

* Therefore, if you retrieve a query item that’s NOT projected, you’re charged for the entire ITEM cost from pulling it from the main table

* You can potentially save in retrieval costs by only having important non-key values projected into the index

* If an attribute isn’t stored in the LSI and you query on it, you have two penalties:

    * Additional query latency

    * DynamoDB will have to fetch the items from the main table in addition to the index - but you’re charged the retrieval cost for the entire item from the main table individually rounded up to 4k rather than just attributes being retrieved

* Example:  If you just query the table or the LSI, you’ll get the total of the ENTIRE query rounded up to 4k.  However, if you have to pull from the query’s LSI + Index (subquery) due to a missing projected attribute in the LSI, then EACH subquery gets rounded up to the nearest 4k and added to the rounded up value of the entire query on the index rounded up to 4k.

* **Writes** - If you add an LSI with a new attribute as part of the key and you update a previously non-existent attribute as part of that LSI or you add a new row with that attribute, either of those operations will take one write unit in the LSI

* **Deletes** - If you delete a row in a table that has the attributes that make up the LSI, the LSI item is removed as well (duh), which costs 1 write operation

* **Updates** - if you update an item that’s part of an LSI, that’s two write units - one to remove it and another one to add it (1 update on table = 2 write units on LSI)

    * Updates that don’t impact any defined index attributes, such as adding or deleting rows without any defined index attributes don’t require additional index  operations

#### LSI Storage Concern - Be aware of ItemCollections

* **ItemCollection** - any group of items that have the same partition key value in a table, and all of its LSIs

    * E.g., for the weather station example where partition key is weather station id and original sort key was datetime, it would be all the data in the table and any of its indexes for a single weather station

    * This only applies to tables with one or more LSIs

    * ItemCollections limit the size of data storable to 10GB per partition (e.g. per weather station)

    * In effect, they limit the number of sort key values for a given partition key

#### Global Secondary Indexes (GSI)

* Shares many concepts of LSI, BUT we can create at any time, and can have alternative Partition and sort key

* Options for attribute projection

    * **KEYS_ONLY** - New partition key and sort keys, old partition key, and if applicable, old sort key

    * **INCLUDE** - Specify custom projection values

    * **ALL** - projects all attributes

* Unlike LSIs where the performance is shared with the table, RCU and WCU are defined on the GSI - in the same way as the table

* As with LSI, changes to table are copied to GSI asynchronously - which means eventual consistency

* GSI’s only support eventually consistent reads

* With an LSI on weather station ID and intrusion detected, we could pull all the records for a given weather station, and then filter intrusion detection where True, for instance, but we couldn’t JUST filter for true regardless of weather station ID - GSI’s solve that

    * To do this with a GSI, create one where intrusion detection is the partition key, weather station ID is the sort key, and then project any attributes into it you want to use to do lookups

**For the Exam:**

* Know the fundamentals of LSIs and GSIs

* Read these:

    * [Scaling Writes on Amazon DynamoDB Tables w/ Global Secondary Indexes](https://aws.amazon.com/blogs/big-data/scaling-writes-on-amazon-dynamodb-tables-with-global-secondary-indexes/)

    * [Improving Data Access with Secondary Indexes](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/SecondaryIndexes.html)
