### Columnar Databases

* DBMS that stores tables as columns rather than rows

* Efficiently write + read data to/from disk in order to speed up the time it takes to return query results

    * Reduces amount of data that needs to be written to / read from disk

    * When we need to read the data, the I/O needed is much less

    * Avoid scanning and discarding unwanted rows

    * More precise = increased query performance 

**Benefits**

* Queries on few columns

* Data aggregation

* Compression

* Lower total cost of ownership

**Do Not Use for**

* Needle in a haystack

* < 100 GB

* Large binary objects

* OLTP

* Avoid single line inserts

* Each column maps to a file in the backend

* Always use COPY command over inserting data row-by-row - much faster

* [SQL Workbench/J](http://www.sql-workbench.net/)

* [Aginity (Windows only)](https://www.aginity.com/redshift/)

---

* [Back: Redshift in the AWS Ecosystem (5:51)](Redshift_in_the_AWS_Ecosystem.md)
* [Next: Redshift Table Design - Introduction (5:20)](Redshift_Table_Design_Introduction.md)
