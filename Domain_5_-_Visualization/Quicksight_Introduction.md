### QuickSight Introduction

* Cloud-based visualizations, ad-hoc analysis

* Use cases

    * Marketing data

    * Sales data

    * Financials data

    * Operations data

* CSV, databases, etc.

* Redshift

* Aurora

* Athena

* RDS

    * MariaDB 10.0+

    * SQL Server 2012+

    * MySQL 5.1+

    * PostgreSQL 9.3.1+

* EC2 / on-prem databases

    * SQL Server

    * MySQL

    * PostgreSQL

* Files - S3 or on-prem

    * Excel

    * CSV, TSV

    * Common log format (.clf)

    * Extended log format (.elf)

* Salesforce

    * Unlimited

    * Enterprise

    * Developer

* Standard Edition

    * Invite any IAM user

    * Invite any user with an email address

        * Can be invited as USER or ADMIN

    * Have to "sign up" for an account even if you have an AWS account - think of this more as an account **name** than a billing entity

* Enterprise edition - extra features

    * Enterprise includes AD integration, encryption at rest

        * Can select one or more Microsoft AD groups in AWS Directory Service for **administrative** access

        * Can select one or more Microsoft AD groups in AWS Directory Service for **user** access

    * May have more differences when future features come out

    * Data at rest in Spice is encrypted using block-level encryption using AWS-managed keys

    * No automatic notification of QuickSight access - you have to manually email users to let them know they have access, where to go to login, how to login, etc.

    * See this link for more info: [Managing User Accounts in Amazon QuickSight Enterprise Edition](http://docs.aws.amazon.com/quicksight/latest/user/managing-users-enterprise.html)

* Can delete users - two options:

    * Transfer ownership of all orphaned resources to a different user in this account, or

    * Delete all orphaned resources

* All data xfer is encrypted using TLS

* Databases are secured using SSL

* You have to import Data Sets into QuickSight for use as a data source - essentially import them into SPICE

* SPICE - Superfast Parallel In-memory Calculation Engine

* SPICE - measured in GB - initially get 10 GB per user, but you can add more if needed

    * Highly available and durable

* Data Preparation - clean or transform raw data from data source

    * Change field names

    * Add calculated fields

    * SQL query

    * Join tables (from same data source)

    * Change data types (except for calculated fields)

    * Data set checks - previews data, can skip rows that it can’t interpret - you get a message about number of rows it couldn’t import

* Dashboards - can share with users, users can filter them, but can’t save the filters they create
