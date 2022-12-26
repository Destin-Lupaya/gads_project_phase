#!/bin/bash

#rachelkabuyre@gmail.com

#Task 1. Use the Cloud Console to create a bucket

# In this task, you create a bucket. However, the text also helps you become familiar with how actions are presented in the lab instructions in this class and teaches you about the Cloud Console interface.

# Navigate to the Storage service and create the bucket
# In the Cloud Console, on the Navigation menu (Navigation menu), click Cloud Storage > Browser.

# Click Create bucket.

# For Name, type a globally unique bucket name; leave all other values as their defaults.

# Click Create.
# Task 2. Access Cloud Shell
# In this section, you explore Cloud Shell and some of its features.

# You can use the Cloud Shell to manage projects and resources via command line without having to install the Cloud SDK and other tools on your computer.

# Cloud shell provides the following:

# Temporary Compute Engine VM
# Command-line access to the instance via a browser
# 5 GB of persistent disk storage ($HOME dir)
# Pre-installed Cloud SDK and other tools
# gcloud: for working with Compute Engine and many Google Cloud services
# gsutil: for working with Cloud Storage
# kubectl: for working with Google Kubernetes Engine and Kubernetes
# bq: for working with BigQuery
# Language support for Java, Go, Python, Node.js, PHP, and Ruby
# Web preview functionality
# Built-in authorization for access to resources and instances


# Task 3. Use Cloud Shell to create a Cloud Storage bucket

# Create a second bucket and verify in the Cloud Console
# Open Cloud Shell again.

# Use the gsutil command to create another bucket. Replace <BUCKET_NAME> with a globally unique name (you can append a 2 to the globally unique bucket name you used previously):

gsutil mb gs://<BUCKET_NAME>

# If prompted, click Authorize.
# In the Cloud Console, on the Navigation menu (Navigation menu icon), click Cloud Storage > Browser, or click Refresh if you are already in the Storage browser. The second bucket should be displayed in the Buckets list.

# Task 4. Explore more Cloud Shell features

# Upload a file
# Open Cloud Shell.

# Click the More button (More button) in the Cloud Shell toolbar to display further options.

# Click Upload. Upload any file from your local machine to the Cloud Shell VM. This file will be referred to as [MY_FILE].

# In Cloud Shell, type ls to confirm that the file was uploaded.

# Copy the file into one of the buckets you created earlier in the lab. Replace [MY_FILE] with the file you uploaded and [BUCKET_NAME] with one of your bucket names:
gsutil cp [MY_FILE] gs://[BUCKET_NAME]

# If your filename has whitespaces, be sure to place single quotes around the filename. For example, gsutil cp ‘my file.txt' gs://[BUCKET_NAME]

# Note: You have uploaded a file to the Cloud Shell VM and copied it to a bucket.
# Explore the options available in Cloud Shell by clicking on different icons in the Cloud Shell toolbar.
# Close all the Cloud Shell sessions.

#Task 5. Create a persistent state in Cloud Shell
# In this section you will learn a best practice for using Cloud Shell. The gcloud command often requires you to specify values such as a Region, Zone, or Project ID. Entering them repeatedly increases the chance of making typing errors. If you use Cloud Shell frequently, you may want to set common values in environment variables and use them instead of typing the actual values.

# Identify available regions
# Open Cloud Shell from the Cloud Console. Note that this allocates a new VM for you.

# To list available regions, execute the following command:

gcloud compute regions list

# Select a region from the list and note the value in any text editor. This region will now be referred to as [YOUR_REGION] in the remainder of the lab.

INFRACLASS_REGION=[YOUR_REGION]
# Verify it with echo:
echo $INFRACLASS_REGION

# You can use environment variables like this in gcloud commands to reduce the opportunities for typos and so that you won't have to remember a lot of detailed information.

# Note: Every time you close Cloud Shell and reopen it, a new VM is allocated, and the environment variable you just set disappears. In the next steps, you create a file to set the value so that you won't have to enter the command each time Cloud Shell is reset.
# Append the environment variable to a file
# Create a subdirectory for materials used in this lab:

mkdir infraclass
# Create a file called config in the infraclass directory:

touch infraclass/config
# Append the value of your Region environment variable to the config file:
echo INFRACLASS_REGION=$INFRACLASS_REGION >> ~/infraclass/config

# Create a second environment variable for your Project ID, replacing [YOUR_PROJECT_ID] with your Project ID. You can find the project ID on the Cloud Console Home page.
INFRACLASS_PROJECT_ID=[YOUR_PROJECT_ID]

# Append the value of your Project ID environment variable to the config file:

echo INFRACLASS_PROJECT_ID=$INFRACLASS_PROJECT_ID >> ~/infraclass/config

# Use the source command to set the environment variables, and use the echo command to verify that the project variable was set:

source infraclass/config
echo $INFRACLASS_PROJECT_ID

# Note: This gives you a method to create environment variables and to easily recreate them if the Cloud Shell is recycled or reset. However, you will still need to remember to issue the source command each time Cloud Shell is opened. In the next step, you modify the .profile file so that the source command is issued automatically every time a terminal to Cloud Shell is opened.
# Close and re-open Cloud Shell. Then issue the echo command again:
echo $INFRACLASS_PROJECT_ID

# There will be no output because the environment variable no longer exists.

# Modify the bash profile and create persistence
# Edit the shell profile with the following command:

nano .profile
# Add the following line to the end of the file:
# Press Ctrl+O, ENTER to save the file, and then press Ctrl+X to exit nano.

# Close and then re-open Cloud Shell to reset the VM.

# Use the echo command to verify that the variable is still set:
echo $INFRACLASS_PROJECT_ID

# Task 6. Review the Google Cloud interface
# Cloud Shell is an excellent interactive environment for exploring Google Cloud by using Google Cloud SDK commands like gcloud and gsutil.

# You can install the Google Cloud SDK on a computer or on a VM instance in Google Cloud. The gcloud and gsutil commands can be automated by using a scripting language like bash (Linux) or Powershell (Windows). You can also explore using the command-line tools in Cloud Shell, and then use the parameters as an implementation guide in the SDK using one of the supported languages.

# The Google Cloud interface consists of two parts: the Cloud Console and Cloud Shell.

# The Console:

# Provides a fast way to perform tasks.
# Presents options to you, instead of requiring you to know them.
# Performs behind-the-scenes validation before submitting the commands.
# Cloud Shell provides:

# Detailed control
# A complete range of options and features
# A path to automation through scripting