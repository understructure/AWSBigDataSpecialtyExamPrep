#!/bin/bash

usage() {
    # echo "Usage: $0 region master-password [dev|test|stage|prod]"
    echo "Usage: $0 region master-password vpc-security-group-id"
    exit 1
}

REGION_NAME=$1
MASTER_PASSWORD=$2
SECURITY_GROUP_ID=$3

if [ "$#" -ne 3 ]; then

  usage
  exit 1  

fi

# Here, we'd want to do a few things based on the environment,
# Like setting license model, multi-az, allocated-storage, 
# vpc-security-groups, and *most* of all, publicly-accessible.

# NB:  These should never really be publicly accessible, but
# as this is a demo and I don't want to have a bastion host
# running 24/7, we're going this route.

aws rds create-db-instance \
--engine mysql \
--license-model general-public-license \
--engine-version 5.7.17 \
--db-instance-class db.t2.micro \
--no-multi-az \
--storage-type standard \
--allocated-storage 10 \
--db-instance-identifier hivemetastore \
--master-username metastoreadmin \
--master-user-password ${MASTER_PASSWORD} \
--vpc-security-group-ids ${SECURITY_GROUP_ID} \
--publicly-accessible \
--availability-zone ${REGION_NAME} \
--port 3306 

