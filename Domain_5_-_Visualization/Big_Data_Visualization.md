### Big Data Visualization

* Zeppelin and Jupyter

* D3.js

#### Zeppelin

* Supported languages

    * Scala

    * Python

    * Spark SQL

    * HiveQL

* Collaborate w/ other users by sharing Zeppelin notebooks

* Publish to dashboards

* Uses your Spark settings on EMR

* Integrates well w/ S3

* Can import / export notebooks to JSON

* Notebooks have easy visualizations for query results through %sql

* Notebooks can be local or file URLs

* Notebook URL can be shared among collaborators - Zeppelin will broadcast changes to all users in realtime, like in collaboration on Google Docs

* On cluster launch, can configure Zeppelin to store notebook on S3 with the following Software Configuration:

<pre>
[
  {
    "Classification": "zeppelin-env",
    "Properties": {
      
    },
    "Configurations": [
      {
        "Classification": "export",
        "Properties": {
          "ZEPPELIN_NOTEBOOK_S3_BUCKET": "bucket-name",
          "ZEPPELIN_NOTEBOOK_STORAGE": "org.apache.zeppelin.notebook.repo.S3NotebookRepo",
          "ZEPPELIN_NOTEBOOK_S3_USER" : "hadoop"
        }
      }
    ]
  }
]
</pre>

##### Zeppelin Use Cases

* Zeppelin, SparkSQL and MLlib on EMR can be used together for exploratory Data Science and for recommendation engines

* Zeppelin, Kinesis Streams, and Spark Streaming can be used together for analyzing realtime data

* [Building a Recommendation Engine with Spark ML on Amazon EMR using Zeppelin](https://aws.amazon.com/blogs/big-data/building-a-recommendation-engine-with-spark-ml-on-amazon-emr-using-zeppelin/)

* [Analyze Realtime Data from Amazon Kinesis Streams Using Zeppelin and Spark Streaming](https://aws.amazon.com/blogs/big-data/analyze-realtime-data-from-amazon-kinesis-streams-using-zeppelin-and-spark-streaming/)

* [Running an External Zeppelin Instance using S3 Backed Notebooks with Spark on Amazon EMR](https://aws.amazon.com/blogs/big-data/running-an-external-zeppelin-instance-using-s3-backed-notebooks-with-spark-on-amazon-emr/)

#### Jupyter

* Can support up to 40 languages, but Julia, Python, R and Scala are the popular ones

* Enables interactive data analysis and collaboration

* Collaborate / share with Dropbox, Github, email, or Jupyter Notebook Viewer

##### Use Cases

* Heavily used for data science

* Requires a custom bootstrap action on EMR

#### D3.js

* JavaScript library for dynamic, interactive data viz in Web browsers

* Read in data from csv, tsv, or JSON files

* Can generate HTML tables, SVG bar charts and other visualizations like real-time dashboards, interactive graphs, and interactive maps that work in a browser

For the Exam:

* Main difference b/t Zeppelin and Jupyter:

    * Zeppelin favored by heavy Spark users

    * Jupyter used heavily for data science

* Know what D3.js is, and what it’s capable of (it comes up as a possible answer in some of the questions on the exam)

