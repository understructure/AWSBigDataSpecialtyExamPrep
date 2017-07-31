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

* [https://www.aginity.com/redshift/](https://www.aginity.com/redshift/)
