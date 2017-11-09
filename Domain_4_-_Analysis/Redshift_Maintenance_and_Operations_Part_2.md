### Redshift Maintenance and Operations Part 2

#### Vacuum

* Redshift blocks are immutable

* Updates result in a new block

* Deleted rows are not removed from disk

* Old rows consume disk space and get scanned when a query is executed

* Wasted storage space and performance degradation

* VACUUM helps recover space and sorts the table

* VACUUM FULL - applies to every table in database - sorts & reclaims space

* VACUUM FULL <TABLENAME> -  sorts & reclaims space on specific table

* VACUUM SORT ONLY - applies to every table in database - sorts only (no reclaiming disk space)

* VACUUM DELETE ONLY - applies to every table in database - reclaims disk space only from rows marked for delete by previous update and delete operations (no sorting)

* VACUUM REINDEX <TABLENAME> - analyzes distribution of index in interleaved sort key columns, then performs full VACUUM operation

    * use for tables with interleaved sort keys

* Use VACUUM after bulk deletes, data loading, or after updates 

* VACUUM is I/O intensive - so only use this during lower periods of activity or during maintenance windows

* Don’t put off using VACUUM!

* **Analyze & Vacuum Schema Utility** - Redshift utilities on Github - can tell us when tables need to be vacuumed - two scripts:

1. Queries Redshift log tables to get list of tables that need to be vacuumed based on alerts raised by optimizer

    * Vacuum command then run on those tables

    * Recommended to use this to update statistics metadata so RS query optimizer can generate more accurate query plans

1. Runs analyze command on tables based on alerts raised in RS log tables

* Ideally, avoid VACUUM operation by	

    * Loading data in sort key order, and

    * Using time series tables

* With very large tables - recommendation is to perform a **deep copy**

    * Recreates and repopulates the table with a bulk insert

    * Bulk insert automatically sorts the table

    * Deep copy much faster than running vacuum

    * VACUUM utiling not recommended for tables > 700 GB

#### Deep Copy - Three Ways

1. Create new table using original DDL, do INSERT INTO new table

2. CREATE TABLE <TABLENAME> (LIKE <OLDTABLENAME>);

3. Create temp table as SELECT * FROM from <OLDTABLENAME>, then truncate old table and insert from temp table

* For 1 & 2, drop old table, rename new table.  For 3, just drop temp table

* For exam - method #1 is preferred for deep copy (fastest)

#### Backup and Restore

* Snapshots can be automatic or manual

##### Automated snapshots

* Automated and continuous

* 8-hour intervals or every 5 GB of data changes

* Default retention period = 1 day, can go up to 35 days for retention

    * If you need more frequent snapshots, check Redshift Snapshot Manager on GitHub

##### Manual Snapshots

* Can be taken anytime, just click Backup >> Take Snapshot, give it an "identifier"

* Can copy automated snapshot, keep as manual snapshot

* In CREATE TABLE DDL, can specify **BACKUP NO**

#### Cross-Region Snapshots

* Select Configure Cross-Region Snapshots - automatically copies automated and manual snapshots to specific region

* Any new snapshots get copied to new region

* If you’re using cross-region KMS-Encrypted Snapshots for KMS Encrypted clusters - snapshots are encrypted

    * KMS keys are region-specific!

* FOR EXAM - know how x-region snapshots are handled when they’re encrypted

* Configure Snapshot Copy Grant - select KMS Key

#### Restore from Snapshot

* New cluster Redshift creates from snapshot will have same configuration, including number and type of nodes from cluster snapshot was taken

* Can restore a single table from snapshot - specify source snapshot, database, schema, table, and target database, schema and table name

#### Monitoring

* Can use CloudWatch metrics - use Performance tab in RS console gives access to same metrics, just a different view

* Also have Queries tab where you can monitor query performance

* Loads tab - monitor data loading performance

* AWS Labs has Redshift monitoring utility - based on Lambda and CloudWatch

    * Gives insight into some of the top performance tuning techniques for RS

    * When implemented, you see custom graphs in CloudWatch

#### For the exam 

* Understand VACUUM and why it helps to run it

* Deep copy - what is it?

* Deep copy - know best method is to create new table from existing DDL

* Cross-Region KMS-Encrypted Snapshots

    * Create a snapshot copy grant in the destination region
