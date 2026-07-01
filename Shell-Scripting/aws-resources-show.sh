#!/bin/bash 


##Author : Dishant
#Date : 2 july 2026
#Version : V1

#This script is Created for Showing all the working Aws Resources with the help of Crontab

#For showing the aws ec2 instances
echo
echo "EC2 INSTANCES"
aws ec2 describe-instances

#For showing the list of S3
echo
echo "LIST OF S3"
aws s3 ls

#For showing the lambda functions 
echo
echo "LAMBDA FUNCTIONS"
aws lambda list-functions 

#For showing how many IAM user
echo 
echo "IAM USERS"
aws iam list-users


