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

# Task 2. Access control lists (ACLs)
# Copy the file to the bucket and configure the access control list
# Run the following command to copy the first file to the bucket:
gsutil cp setup.html gs://$BUCKET_NAME_1/
# To get the default access list that's been assigned to setup.html, run the following command:
gsutil acl get gs://$BUCKET_NAME_1/setup.html  > acl.txt
cat acl.txt

# To set the access list to private and verify the results, run the following commands:
gsutil acl set private gs://$BUCKET_NAME_1/setup.html
gsutil acl get gs://$BUCKET_NAME_1/setup.html  > acl2.txt
cat acl2.txt

# To update the access list to make the file publicly readable, run the following commands:
gsutil acl ch -u AllUsers:R gs://$BUCKET_NAME_1/setup.html
gsutil acl get gs://$BUCKET_NAME_1/setup.html  > acl3.txt
cat acl3.txt

# Examine the file in the Cloud Console
# In the Cloud Console, on the Navigation menu (Navigation menu icon), click Cloud Storage > Buckets.

# Click [BUCKET_NAME_1].

# Verify that for file setup.html, Public access has a Public link available.
# Delete the local file and copy back from Cloud Storage
# Return to Cloud Shell. If necessary, click Activate Cloud Shell (Cloud Shell).

# Run the following command to delete the setup file:
rm setup.html
# To verify that the file has been deleted, run the following command:
ls
# To copy the file from the bucket again, run the following command:
gsutil cp gs://$BUCKET_NAME_1/setup.html setup.html

# Task 3. Customer-supplied encryption keys (CSEK)
# Generate a CSEK key
# For the next step, you need an AES-256 base-64 key.

# Run the following command to create a key:
python3 -c 'import base64; import os; print(base64.encodebytes(os.urandom(32)))'

# Result (this is example output):
# Copy the value of the generated key excluding b' and \n' from the command output. Key should be in form of tmxElCaabWvJqR7uXEWQF39DhWTcDvChzuCmpHe6sb0=.

# Modify the boto file
# The encryption controls are contained in a gsutil configuration file named .boto.

# To view and open the boto file, run the following commands:
ls -al
nano .boto

# Note: if the .boto file is empty, close the nano editor with Ctrl+X and generate a new .boto file using the gsutil config -n command. Then, try opening the file again with the above commands.

# If the .boto file is still empty, you might have to locate it using the gsutil version -l command.

# Locate the line with "#encryption_key="
# Note: the bottom of the nano editor provides you with shortcuts to quickly navigate files. Use the Where Is shortcut to quickly locate the line with the #encryption_key=.
# Uncomment the line by removing the # character, and paste the key you generated earlier at the end.
# Example (this is an example):

Before:
# encryption_key=
After:
encryption_key=tmxElCaabWvJqR7uXEWQF39DhWTcDvChzuCmpHe6sb0=


# Press Ctrl+O, ENTER to save the boto file, and then press Ctrl+X to exit nano.

# Upload the remaining setup files (encrypted) and verify in the Cloud Console
# To upload the remaining setup.html files, run the following commands:
gsutil cp setup2.html gs://$BUCKET_NAME_1/
gsutil cp setup3.html gs://$BUCKET_NAME_1/

# Return to the Cloud Console.
# Click [BUCKET_NAME_1]. Both setup2.html and setup3.html files show that they are customer-encrypted.

# Delete local files, copy new files, and verify encryption

# To delete your local files, run the following command in Cloud Shell:
rm setup*
# To copy the files from the bucket again, run the following command:

gsutil cp gs://$BUCKET_NAME_1/setup* ./
Copied!
# To cat the encrypted files to see whether they made it back, run the following commands:

cat setup.html
cat setup2.html
cat setup3.html