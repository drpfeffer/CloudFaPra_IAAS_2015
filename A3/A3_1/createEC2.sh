#!/usr/bin/env sh

# Script for automatic deployment of our Wordpress/MySQL EC2 instances. 

aws cloudformation create-stack \
	--stack-name Group2-WordPress-MySQL-DEMO \
	--template-body file://wordpress_mysql.json \
	--parameters \
	ParameterKey=DBName,ParameterValue=wordpressdb,UsePreviousValue=false \
	ParameterKey=DBUser,ParameterValue=wordpress,UsePreviousValue=false \
	ParameterKey=DBPassword,ParameterValue=123456789,UsePreviousValue=false \
	ParameterKey=DBRootPassword,ParameterValue=123456789abc,UsePreviousValue=false \
	ParameterKey=KeyName,ParameterValue=Cloud_FaPra,UsePreviousValue=false \
	--timeout-in-minutes 10 \
