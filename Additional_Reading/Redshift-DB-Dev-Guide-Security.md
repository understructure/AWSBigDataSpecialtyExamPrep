
# Redshift Database Developer Guide

A recent comment on the ACG forums indicated that the lectures did not cover the topic of limiting access to certain Redshift objects.  This document is a summary of the Managing Database Security section of the Redshift Database Developer Guide, and was written to try to help fill that need.

## Managing Database Security


### Users

* Superusers and named user accounts
* Superusers can do pretty much anything
* Only Superusers can create Superusers
* Named user accounts are granted privileges explicitly
* Object owners by default have all permissons on an object, no one else does


### Groups

* Collections of users

### Schemas

* Think of directories but they can't be nested

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
