### Presto On EMR

* Open source in-memory distributed fast SQL query engine - uses ANSI SQL

* Runs interactive analytic queries against variety of data sources

    * Sizes in GB to PB

    * Significantly faster than Hive

* Connectors allow you to query

    * Relational DBs

    * Streaming sources (e.g. Kafka)

    * NoSQL databases

    * Frameworks like Hive

    * Available for Blackhole, Cassandra, jmx, localfile, mongodb, MySQL, PostgreSQL, Raptor, Redis, TPCH
    
    * To launch a cluster with a connector, use JSON [(example here)](http://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-presto.html)

* High concurrency, run thousands of queries per day (sub-second to minutes)

* In-memory processing helps avoid unnecessary I/O, leading to low latency

* Doesn’t need an interpreter layer like Hive does (Hive uses Tez now)

* No disk I/O, data queried needs to fit into memory

* Presto is very good for interactive queries

* DON’T use Presto for:

    * OLTP

    * Joining extremely large tables requires tuning (use Hive instead)

    * Batch processing

#### Architecture

* Presto CLI Client queries coordinator

* Coordinator 

    * parses, analyzes & plans query execution

    * Uses connectors to get metadata from data sources and build query plan

    * Scheduler on coordinator performs execution and assigns processing to workers

    * Workers process rows and return results to client

#### For the Exam

* High level understanding of Presto

* Know where Presto should and should NOT be used
