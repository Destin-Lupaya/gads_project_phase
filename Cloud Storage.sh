#!/bin/bash

#rachelkabuyre@gmail.com
# Overview
# Cloud Storage is a fundamental resource in Google Cloud, with many advanced features. In this lab, you exercise many Cloud Storage features that could be useful in your designs. You explore Cloud Storage using both the console and the gsutil tool.

# Objectives
# In this lab, you learn how to perform the following tasks:

# Create and use buckets

# Set access control lists to restrict access

# Use your own encryption keys

# Implement version controls

# Use directory synchronization

# Share a bucket across projects using IAM

# Task 1. Preparation
# Create a Cloud Storage bucket
# On the Navigation menu (Navigation menu icon), click Cloud Storage > Buckets.
# Note: a bucket must have a globally unique name. You could use part of your PROJECT_ID_1 in the name to help make it unique. For example, if the PROJECT_ID_1 is myproj-154920 your bucket name might be storecore154920
# Click Create bucket.
# Specify the following, and leave the remaining settings as their defaults:
# Property	Value (type value or select option as specified)
# Name	Enter a globally unique name
# Location type	Multi-region
# Enforce public access prevention on this bucket	unchecked
# Access control	Fine-grained (object-level permission in addition to your bucket-level permissions)
# Make a note of the bucket name. It will be used later in this lab and referred to as [BUCKET_NAME_1].
# Click Create.

# Download a sample file using CURL and make two copies
# In the Cloud Console, click Activate Cloud Shell (Cloud Shell).

# If prompted, click Continue.

# Store [BUCKET_NAME_1] in an environment variable:
export BUCKET_NAME_1=<enter bucket name 1 here>
# Verify it with echo:
echo $BUCKET_NAME_1
# Run the following command to download a sample file (this sample file is a publicly available Hadoop documentation HTML file):
curl \
https://hadoop.apache.org/docs/current/\
hadoop-project-dist/hadoop-common/\
ClusterSetup.html > setup.html
# To make copies of the file, run the following commands:
cp setup.html setup2.html
cp setup.html setup3.html