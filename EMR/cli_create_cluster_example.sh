#!/bin/bash

usage() {
    echo "Usage: $0 cluster-name key-name region [dev|test|stage|prod]"
    exit 1
}




if [ "$#" -ne 4 ]; then
  usage 

else

CLUSTER_NAME=$1
KEY_NAME=$2
REGION_NAME=$3
THE_ENVIRONMENT=$4

fi


aws emr create-cluster \
--auto-scaling-role EMR_AutoScaling_DefaultRole \
--applications Name=Hadoop Name=Hive Name=Zeppelin Name=Spark \
--ec2-attributes '{"KeyName":"${KEY_NAME}","InstanceProfile":"EMR_EC2_DefaultRole","SubnetId":"subnet-8a2da3a7","EmrManagedSlaveSecurityGroup":"sg-41f36c30","EmrManagedMasterSecurityGroup":"sg-39fa6548","AdditionalMasterSecurityGroups":["sg-fc35a48d"]}' \
--service-role EMR_DefaultRole \
--enable-debugging \
--release-label emr-5.5.0 \
--log-uri 's3n://muhbutt/emr-logs/' \
--name '${CLUSTER_NAME}' \
--instance-groups '[{"InstanceCount":1,"BidPrice":"0.05","InstanceGroupType":"MASTER","InstanceType":"m3.xlarge","Name":"Master - 1"}]' \
--configuration file://cluster-config-${THE_ENVIRONMENT}.json \
--scale-down-behavior TERMINATE_AT_INSTANCE_HOUR \
--region ${REGION_NAME}
