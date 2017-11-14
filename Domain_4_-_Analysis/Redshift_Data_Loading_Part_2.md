### Redshift Data Loading Part 2

* Manifest - JSON file

    * Load required files only

    * Load files from different buckets

    * Load files with different prefixes

    * Can set mandatory = true if you want the job to fail if the file is not there

    * Put manifest file in FROM part of COPY command, use "manifest" as last word in the copy command

    * This helps if you’ve got a bunch of files in a bucket and you only want to load a few
    
    * Example:
    
`copy tablename from 's3://manifest_file_location.manifest' credentials '<aws-credentials>' manifest;`

**For the exam:**

* Know 3 scenarios where manifest may be used:

    * Load required files only

    * Load files from different buckets

    * Load files with different prefixes

---

* [Back: Redshift Data Loading Part 1 (17:41)](Redshift_Data_Loading_Part_1.md)
* [Next: Redshift Loading Data Part 3 (11:09)](Redshift_Data_Loading_Part_3.md)

