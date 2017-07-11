### Table Design - Distribution Styles

#### One of three distribution styles

* **Even** (default distribution style)

    * rows distributed across slices in round-robin fashion regardless of values in column

    * Good for no joins, ok w/ reduced parallelism, where KEY and ALL are not a clear choice

    * Distribution style defined at end of DDL statement

* **Key** - Particularly used when joining tables

    * distribute data evenly among slices

    * Colocate data w/ same key on same slice

    * When distribution keys on large tables haven’t been defined, it can lead to significantly poor performance

    * **Good for** tables used in joins, large fact tables in star schema

    * Distribution style defined **inline** with table creation

* **All** - Copy of entire tables on all nodes of cluster

    * Good for data that does not change, e.g., not more than a few million rows

    * Reasonably sized tables (a few million rows),

    * ...and no common distribution key

    * Distribution style defined at end of DDL statement

* Extra Tips

    * Use guidelines, but also experiment and test

    * Five-part (extra) Resource - [AWS Big Data Blog - Redshift Engineering’s Advanced Table Design Playbook](https://aws.amazon.com/blogs/big-data/amazon-redshift-engineerings-advanced-table-design-playbook-preamble-prerequisites-and-prioritization/)

* Exam Tips

    * Know all three distribution styles

    * Know when you would use each

    * Know their benefits and drawbacks
