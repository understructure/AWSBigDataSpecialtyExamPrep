### Using Hue With EMR

* Couple questions on Hue on the exam

* S3 browser, HDFS browser included, but you have to configure it to show it

* Can access metastore manager - information about tables too

* HBase browser included

* Zookeeper browser

* Job browser - see status of jobs

* Server logs (searchable), can download logs

* Oozie editor - can schedule Sqoop jobs

* Can use many authentication providers

    * [LDAP](http://docs.aws.amazon.com/emr/latest/ReleaseGuide/hue-ldap.html)
    * PAM
    * SPNEGO
    * OpenID
    * OAuth
    * SAML2

* /etc/hue/conf/hue.ini

* For security, recommended you store LDAP settings on S3 rather than on master node in hue.ini

#### For the Exam

* Have an overall understanding of the benefits and advantages of Hue

---


* [Back: EMR Operations Part 4 (16:30)](EMR_Operations_Part_4.md)
* [Next: Hive on EMR (16:40)](EMR_Hive.md)
