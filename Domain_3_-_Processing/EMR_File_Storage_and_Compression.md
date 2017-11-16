### EMR File Storage and Compression

* In HDFS, files are split into chunks automatically by Hadoop

* If your data files are stored in S3, Hadoop will split the data on S3 by reading the files in multiple HTTP range requests

* Both of the above points directly correlate to file sizes and compression algorithms

* If the compression algorithm doesn’t allow for splitting, then Hadoop won’t split your data files - a single Map task will be used to process your compressed files (see figure 7, page 14 of [Best Practices for Amazon EMR](https://d0.awsstatic.com/whitepapers/aws-amazon-emr-best-practices.pdf)

* If your compression algorithm allows files to be split, your files get split and processed in parallel

#### Compression

Table originally from [EMR Deep Dive and Best Practices re:Invent Presentation (slide 61)](https://www.slideshare.net/AmazonWebServices/amazon-emr-deep-dive-best-practices-67651043)

**NOTE:** Questions on this can come up on the exam, study this table!

<table>
  <tr>
    <td>Algorithm</td>
    <td>Splittable?</td>
    <td>Compression Ratio</td>
    <td>Compress / Decompress Speed</td>
  </tr>
  <tr>
    <td>GZIP</td>
    <td>No</td>
    <td>High</td>
    <td>Medium</td>
  </tr>
  <tr>
    <td>bzip2</td>
    <td>Yes</td>
    <td>Very High</td>
    <td>Slow</td>
  </tr>
  <tr>
    <td>LZO</td>
    <td>Yes</td>
    <td>Low</td>
    <td>Fast</td>
  </tr>
  <tr>
    <td>Snappy</td>
    <td>No</td>
    <td>Low</td>
    <td>Very Fast</td>
  </tr>
</table>


* Hadoop will check file extension to check for compressed files - you don’t have to do anything special here

* You get better data performance with compression, less data moving b/t mappers and reducers

* Less network traffic b/t S3 and EMR

* Helps reduce storage costs

#### File Formats

* Text (csv, tsv)

* Parquet - Columnar-oriented file format

* ORC - Optimized Row-Columnar format

* Sequence - Flat files consisting of binary key/value pairs

* Avro - Data serialization framework - uses JSON for defining data types and protocols, serializes data in compact binary format

#### File Sizes

* GZIP files not splittable - keep in 1-2GB range

* Avoid smaller files (100M or less), plan for fewer, larger files

* S3DistCp can be used to combine smaller files into larger files

#### S3DistCp

* An extension of DistCp - allows you to copy data b/t or within clusters

* Can be used  to copy data b/t S3 buckets, S3 to HDFS, or HDFS to S3

* Can be added as a step to a cluster if you want to copy files (or combine many small files into larger ones) as part of cluster launch

#### For the Exam

* Study compression algorithms table

---

* [Back: Spark on EMR Part 2 (9:49)](EMR_Spark_Part_2.md)
* [Next: EMR Lab (13:10)](EMR_Lab.md)
