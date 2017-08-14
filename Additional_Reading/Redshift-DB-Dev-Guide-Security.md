
# Redshift Database Developer Guide

A recent comment on the ACG forums indicated that the lectures did not cover the topic of limiting access to certain Redshift objects.  This document is a summary of the Managing Database Security section of the Redshift Database Developer Guide, and was written to try to help fill that need.


## Managing Database Security

### Redshift Security Overview


| Feature                    | Description                       | Controlled by                      |
|----------------------------|-----------------------------------|------------------------------------|
| Sign-in credentials        | Redshift Management Console       | AWS account privileges             |
| Access management          | Specific Redshift resources       | IAM account                        |
| Cluster security groups    | Inbound access to cluster         | Redshift Cluster Security Group    |
| VPC                        | Networking security               | VPC, Route tables, etc.            |
| Cluster encryption         | Enable when creating cluster      | HSM, KMS                           |
| SSL encryption             | Connection b/t client and cluster | Aginity Workbench, SQL Workbench/J | 
| Load data encryption       | Server- or client-side encryption | S3 / COPY command.                 |
| Data in transit            | From S3 DynamoDB, COPY, UNLOAD, backup and restore ops                 | Redshift hardware accelerated SSL  | 



### Users

* Superusers and named user accounts
* Superusers can do pretty much anything - have same permissions as database owners
* Only Superusers can:
    * create Superusers (use the `CREATEUSER` privilege when creating a user to create a superuser)
    * create, alter, drop users
    * create, alter, drop groups
* masteruser - created when you launch a cluster - is a superuser
* Named user accounts are granted privileges explicitly
* When you create an object, you're the owner
* Object owners by default have all permissons on an object, no one else does
* Modify or destroy permissions are object owner only
* Query the `PG_USER` catalog table for information on all users


### Groups

* Collections of users
* Dropping a group only drops the group, not the users in it
* Query the `PG_GROUP` catalog table for information on all groups


### Schemas

* Think of directories but they can't be nested
* Single schema named PUBLIC exists at first
* Table names can be duplicated across schemas
* When creating an object without explicitly supplying its schema, the object is created in the first schema in the search_path parameter
* Query the `PG_NAMESPACE` catalog table for information on all schemas
* Query the `PG_TABLE_DEF` catalog `where schemaname = 'whatever'` to get a list of tables in the `whatever` schema
* Grant `USAGE` on a schema to give a user access to it
    * Still must specify object permissions explicitly, e.g., `SELECT, INSERT, UPDATE, DELETE`
    
    
### Other

* Can grant `USAGE ON LANGUAGE` - this allows a user to create UDFs.  `language_name` in Redshift must be `plpythonu`


## Loading Data >> Using a COPY Command to Load Data >> Credentials and Access Permissions

| Service                                           | Operation |  Permissions                                                |
|---------------------------------------------------|-----------|-----------------------------------------------------------|
| S3                                                |   COPY    | Bucket: LIST, Objects (and manifest file, if exists): GET  |
| S3, EMR, Remote Hosts (SSH) w JSON-formatted data |   COPY    | JSONPaths file on S3: LIST, GET (if used)                  |
| DynamoDB                                          |   COPY    | Table: SCAN and DESCRIBE (on the table)                    |
| EMR                                               |   COPY    | Cluster: ListInstances   (on the cluster)                  |
| S3                                                |  UNLOAD   | Bucket: READ, WRITE |
| S3                                                | CREATE LIBRARY | Bucket: LIST, Objects: GET |
