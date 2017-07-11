### DynamoDB Performance Deep Dive Part 2 of 2

#### Global Secondary Indexes - Performance Considerations

* GSI’s have their own RCU and WCU values and use alternative keys

* Say you have 12,000 WCUs configured on main table.  If you don’t adjust the WCUs for a GSI, the WCUs can be throttled both at the GSI AND the table level!

* If you set the WCUs on the GSI to 12,000, you’d think you’d be OK.  However, if your partition key on the GSI only has 2 values (True/False, for example), the best case scenario is that DynamoDB will allocate 2 partitions with 6,000 WCUs each.  Two problems:

    * Assumes even distribution b/t True and False for GSI’s partition key

    * Maximum WCU per partition is 1,000, so that’s not good

    * We’ll discuss what to do about hot keys later, just know that the performance on your tables is limited to your modeling and performance reservations on both your TABLE and INDEX

#### Temporally Uneven Writes

* Let’s say you have a table you’ve configured for 15 WCUs, which is fine except at beginning of the hour, where you get a spike of 50.  You’ve got 3 options:

    * Could rely on burst - you get 300 seconds of your RCU/WCU - bad idea, can still get throttled requests, and there are better uses for your capacity

    * Change your app - force it to spread periodic batch writes over time

    * Use SQS as a managed write buffer, maybe using Lambda to help spread the writes over time

#### Uneven Reads

* Scenario - online store with 7 products, normally an even load, but we have a sale on products 1 and 2

* DO NOT increase RCUs much above nominal load - this will increase the number of partitions and decrease per-partition performance that can’t be reversed

* Burst capacity won’t work

* Static HTML - could use this but would decrease user experience

* Caching - good idea, will read from cache rather than from DynamoDB

    * Could avoid out of date caching entries by using the DynamoDB streaming feature to cause a cache update when certain info (e.g. stock levels) is updated

**For the Exam:**

* Solid understanding of partitions, what they are, how they work, how to calculate their number

* Know how partitions influence performance together with partition keys

* Best practice for partition keys, how to structure data based on key-space and load

* GSIs and how to select keys, and how this selection impacts the index and the table (RCUs and WCUs are defined separately from main table, indexes can have alternative partition key and alternative sort key than main table)
