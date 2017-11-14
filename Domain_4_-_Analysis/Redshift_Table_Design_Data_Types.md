### Table Design - Data Types

* 12 data types (see table below)

* VARCHAR and CHAR stored in BYTES, not length of characters

* [http://docs.aws.amazon.com/redshift/latest/dg/c_Supported_data_types.html](http://docs.aws.amazon.com/redshift/latest/dg/c_Supported_data_types.html)

* Use data types carefully - duh - dates for dates, etc.

* When designing tables - if columns are wider than necessary, there can be a performance impact

    * Redshift data written to temporary table and are not compressed

For the exam

* Very important to know range / width for VARCHAR and CHAR columns - see this link: [http://docs.aws.amazon.com/redshift/latest/dg/r_Character_types.html](http://docs.aws.amazon.com/redshift/latest/dg/r_Character_types.html)

*  Columns that are too wide have a performance impact - queries written to temp tables

The following table lists the data types that you can use in Amazon Redshift tables. 

<table>
  <tr>
    <td>Data Type </td>
    <td>Aliases </td>
    <td>Description </td>
  </tr>
  <tr>
    <td>SMALLINT </td>
    <td>INT2 </td>
    <td>Signed two-byte integer </td>
  </tr>
  <tr>
    <td>INTEGER </td>
    <td>INT, INT4 </td>
    <td>Signed four-byte integer </td>
  </tr>
  <tr>
    <td>BIGINT </td>
    <td>INT8 </td>
    <td>Signed eight-byte integer </td>
  </tr>
  <tr>
    <td>DECIMAL </td>
    <td>NUMERIC </td>
    <td>Exact numeric of selectable precision </td>
  </tr>
  <tr>
    <td>REAL </td>
    <td>FLOAT4 </td>
    <td>Single precision floating-point number </td>
  </tr>
  <tr>
    <td>DOUBLE PRECISION </td>
    <td>FLOAT8, FLOAT</td>
    <td>Double precision floating-point number </td>
  </tr>
  <tr>
    <td>BOOLEAN </td>
    <td>BOOL </td>
    <td>Logical Boolean (true/false) </td>
  </tr>
  <tr>
    <td>CHAR </td>
    <td>CHARACTER, NCHAR, BPCHAR</td>
    <td>Fixed-length character string </td>
  </tr>
  <tr>
    <td>VARCHAR </td>
    <td>CHARACTER VARYING, NVARCHAR, TEXT </td>
    <td>Variable-length character string with a user-defined limit </td>
  </tr>
  <tr>
    <td>DATE </td>
    <td></td>
    <td>Calendar date (year, month, day) </td>
  </tr>
  <tr>
    <td>TIMESTAMP </td>
    <td>TIMESTAMP WITHOUT TIME ZONE</td>
    <td>Date and time (without time zone) </td>
  </tr>
  <tr>
    <td>TIMESTAMPTZ</td>
    <td>TIMESTAMP WITH TIME ZONE</td>
    <td>Date and time (with time zone) </td>
  </tr>
</table>


---

* [Back: Redshift Table Design - Sort Keys (14:57)](Redshift_Table_Design_Sort_Keys.md)
* [Next: Redshift Table Design - Compression (9:31)](Redshift_Table_Design_Compression.md)
