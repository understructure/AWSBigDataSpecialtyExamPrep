### Table Design - Compression

#### What is Compression

* Reduces amount of data stored

* Therefore lowers cost

* 3x-10x compression possible

* Queries need to pull less data from disk, leads to performance gains

* Each column can be compressed

* Used like this in column DDL: 

* <COLUMN_NAME> <DATATYPE> [NOT NULL] ENCODE <ENCODING_TYPE>

* From [http://docs.aws.amazon.com/redshift/latest/dg/c_Compression_encodings.html](http://docs.aws.amazon.com/redshift/latest/dg/c_Compression_encodings.html)

<table>
  <tr>
    <th>Encoding type</th>
    <th>Keyword in CREATE TABLE and ALTER TABLE</th>
    <th>Data types</th>
  </tr>
  <tr>
    <td>Raw (no compression)</td>
    <td>RAW</td>
    <td>All</td>
  </tr>
  <tr>
    <td>Byte dictionary</td>
    <td>BYTEDICT</td>
    <td>All except BOOLEAN</td>
  </tr>
  <tr>
    <td>Delta</td>
    <td>DELTA
DELTA32K</td>
    <td>SMALLINT, INT, BIGINT, DATE, TIMESTAMP, DECIMAL
INT, BIGINT, DATE, TIMESTAMP, DECIMAL</td>
  </tr>
  <tr>
    <td>LZO</td>
    <td>LZO</td>
    <td>All except BOOLEAN, REAL, and DOUBLE PRECISION</td>
  </tr>
  <tr>
    <td>Mostlyn</td>
    <td>MOSTLY8
MOSTLY16
MOSTLY32</td>
    <td>SMALLINT, INT, BIGINT, DECIMAL
INT, BIGINT, DECIMAL
BIGINT, DECIMAL</td>
  </tr>
  <tr>
    <td>Run-length</td>
    <td>RUNLENGTH</td>
    <td>All</td>
  </tr>
  <tr>
    <td>Text</td>
    <td>TEXT255
TEXT32K</td>
    <td>VARCHAR only
VARCHAR only</td>
  </tr>
  <tr>
    <td>Zstandard</td>
    <td>ZSTD</td>
    <td>All</td>
  </tr>
</table>


* If you copy data into a table w/ compression setup, data will be compressed

* DEMO - why compression helps - run same queries on two sets of two tables, one compressed, one not. Big difference, 25% in this example

#### How does it work?  One of two ways:

* **Automatically** (AWS recommended) - When data is loaded into brand new table, COPY command 

    * loads 100k rows, 

    * runs behind the scenes ANALYZE COMPRESSION command, 

    * determines types of encodings needed, 

    * drops table, 

    * recreates table with compression encodings, 

    * and then all the data is loaded

* **Manually** (run ANALYZE COMPRESSION command, modify DDL manually)

    * Add this to end of COPY command:

<table>
  <tr>
    <td>compupdate off</td>
  </tr>
</table>


    * Then can run:

<table>
  <tr>
    <td>analyze compression table_name;</td>
  </tr>
</table>


* The above will give you compression recommendations based on the data you’ve loaded into the table with the "compupdate off" statement added to the end of the COPY command.  You’d then need to drop and recreate your table, recreate the DDL based on the recommendations, and reload the data into the new table

For the exam, know:

* Benefits of compression

* How compression works in Redshift
