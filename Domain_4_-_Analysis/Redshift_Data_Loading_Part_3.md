### Redshift Data Loading Part 3

#### Data Formats

* CSV

* Delimited (e.g., pipe)

* Fixed width

* JSON

* Avro

#### Error Checking - System Tables	

* STL_LOAD_ERRORS

* STL_LOADERROR_DETAIL

* ^ can join these two as well to get even more information when COPY command fails

* SELECT * = BAD (duh)

* Upsert statements not supported - use staging table if:

1. you need to replace existing rows

    * Want to replace all data in target table

    * Use all rows in staging table to merge into target table

    * Target and staging columns match

* **Example**: Run delete and insert in single transaction

* Here’s a link: [http://docs.aws.amazon.com/redshift/latest/dg/t_updating-inserting-using-staging-tables-.html](http://docs.aws.amazon.com/redshift/latest/dg/t_updating-inserting-using-staging-tables-.html)

2.    Specify a column list (mimic UPSERT) - us this if:

* Update specific columns in target table

* Most rows in staging table will not be used to update target table

**For the exam, know:**

* UPSERT not supported

* Understand when staging tables re used

* Know the two methods to merge data (illustrated above)
