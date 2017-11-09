### Redshift Data Loading Data Part 4

* [http://docs.aws.amazon.com/redshift/latest/dg/c_loading-encrypted-files.html](http://docs.aws.amazon.com/redshift/latest/dg/c_loading-encrypted-files.html)

* [http://docs.aws.amazon.com/redshift/latest/dg/t_unloading_encrypted_files.html](http://docs.aws.amazon.com/redshift/latest/dg/t_unloading_encrypted_files.html)

#### Loading encrypted data

* Using the **COPY** command you can load encrypted files from S3 where the following encryption was applied:

    * SSE with S3-managed keys (SSE-S3)

    * SSE with KMS-Managed keys (SSE-KMS)

        * COPY command automatically recognizes and loads files encrypted using SSE-S3 and SS3-KMS

    * Client-side encryption using client-side symmetric master key

        * Use **master_symmetric_key** parameter in COPY command (also use **encrypted** option)

* The following are NOT supported

    * SSE w/ customer-provided keys (SSE-C)

    * Client-side encryption using KMS-managed **customer** master key

    * Client-side encryption using a customer-provided **asymmetric** master key

* **UNLOAD** command - unloads query results into one or more files from Redshift into S3

    * Automatically creates files using SSE-S3 (AES-256)

    * Can specify SSE-KMS - use **KMS_KEY_ID** parameter in UNLOAD command (also use **encrypted** option) 

    * Can also unload using client-side encryption with customer-managed key (CSE-CMK)

* **UNLOAD** command does NOT support:

    * S3 server-side encryption using a customer-provided key (SSE-C)
