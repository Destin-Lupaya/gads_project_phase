# /bin/bash

# rachelkabuyre@gmail.com

# Overview
# In this lab, you learn how to use BigQuery to analyze billing data.

# Objectives
# In this lab, you learn how to perform the following tasks:

# Sign in to BigQuery from the Cloud Console

# Create a dataset

# Create a table

# Import data from a billing CSV file stored in a bucket

# Run complex queries on a larger dataset

# Setup and requirements
# For each lab, you get a new Google Cloud project and set of resources for a fixed time at no cost.

# Sign in to Qwiklabs using an incognito window.

# Note the lab's access time (for example, 1:15:00), and make sure you can finish within that time.
# There is no pause feature. You can restart if needed, but you have to start at the beginning.

# When ready, click Start lab.

# Note your lab credentials (Username and Password). You will use them to sign in to the Google Cloud Console.

# Click Open Google Console.

# Click Use another account and copy/paste credentials for this lab into the prompts.
# If you use other credentials, you'll receive errors or incur charges.

# Accept the terms and skip the recovery resource page.

# Note: Do not click End Lab unless you have finished the lab or want to restart it. This clears your work and removes the project.

# Task 1. Use BigQuery to import data
# Sign in to BigQuery and create a dataset
# In the Cloud Console, on the Navigation menu ( Navigation menu icon), click BigQuery.
# If prompted, click Done.
# Click on the View actions icon next to your project ID (starts with qwiklabs-gcp) and click Create dataset.
# Note: You can export billing data directly to BigQuery as outlined in the Export Cloud Billing data to BigQuery Guide. However, for the purposes of this lab, a sample CSV billing file has been prepared for you. It is located in a Cloud Storage bucket where it is accessible to your student account. You will import this billing information into a BigQuery table and examine it.
# Specify the following:
# Property	Value (type value or select option as specified)
# Dataset ID:	imported_billing_data
# Data location:	US
# Default table expiration (check Enable table expiration):	1 days (Default maximum table age)
# Click Create Dataset. You should see imported_billing_data in the left pane.

# Create a table and import
# Click on the View actions icon next to your imported_billing_data dataset, and click Open and then click Create Table to create a new table.
# For Source, specify the following, and leave the remaining settings as their defaults:
# Property	Value (type value or select option as specified)
# Create table from:	Google Cloud Storage
# Select file from GCS bucket	cloud-training/archinfra/export-billing-example.csv
# File format	CSV
# For Destination, specify the following, and leave the remaining settings as their defaults:
# Property	Value (type value or select option as specified)
# Table name	sampleinfotable
# Table type	Native table
# Under Schema check Auto detect.
# Open Advanced options
# Under Header rows to skip specify 1
# # Click Create Table. After the job is completed, the table appears below the dataset in the left pane.

# Task 2. Examine the table
# Click sampleinfotable.
# Note: This displays the schema that BigQuery automatically created based on the data it found in the imported CSV file. Notice that there are strings, integers, timestamps, and floating values.
# Click Details. As you can see in Number of Rows, this is a relatively small table with 44 rows.
# Click Preview.
# Locate the row that has the Description: Network Internet Ingress from EMEA to Americas.

# Task 3. Compose a simple query
# When you reference a table in a query, both the dataset ID and table ID must be specified; the project ID is optional.

# Note: If the project ID is not specified, BigQuery will default to the current project.
# All the information you need is available in the BigQuery interface. In the column on the left, you see the dataset ID (imported_billing_data) and table ID (sampleinfotable).

# Recall that clicking on the table name brings up the Schema with all of the field names.

# Now construct a simple query based on the Cost field.

# Click Compose New Query.

# Paste the following in Query Editor:

SELECT * FROM `imported_billing_data.sampleinfotable`
WHERE Cost > 0
Copied!
Click Run.