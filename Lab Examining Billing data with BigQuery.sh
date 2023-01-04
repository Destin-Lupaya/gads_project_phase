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

# Click Run.

# Task 4. Analyze a large billing dataset with SQL
# In the next activity, you use BigQuery to analyze a sample dataset with 22,537 lines of billing data.

# Note: The cloud-training-prod-bucket.arch_infra.billing_data dataset used in this task is shared with the public. For more information on public datasets and how to share datasets with the public, refer to the BigQuery public datasets Guide.
# For New Query, paste the following in Query Editor:

SELECT
  product,
  resource_type,
  start_time,
  end_time,
  cost,
  project_id,
  project_name,
  project_labels_key,
  currency,
  currency_conversion_rate,
  usage_amount,
  usage_unit
FROM
  `cloud-training-prod-bucket.arch_infra.billing_data`

# Click Run. Verify that the resulting table has 22,537 lines of billing data.

# To find the latest 100 records where there were charges (cost > 0), for New Query, paste the following in Query Editor:

SELECT
  product,
  resource_type,
  start_time,
  end_time,
  cost,
  project_id,
  project_name,
  project_labels_key,
  currency,
  currency_conversion_rate,
  usage_amount,
  usage_unit
FROM
  `cloud-training-prod-bucket.arch_infra.billing_data`
WHERE
  Cost > 0
ORDER BY end_time DESC
LIMIT
  100

# Click Run.

# To find all charges that were more than 3 dollars, for Compose New Query, paste the following in Query Editor:

SELECT
  product,
  resource_type,
  start_time,
  end_time,
  cost,
  project_id,
  project_name,
  project_labels_key,
  currency,
  currency_conversion_rate,
  usage_amount,
  usage_unit
FROM
  `cloud-training-prod-bucket.arch_infra.billing_data`
WHERE
  cost > 3

# Click Run.

# To find the product with the most records in the billing data, for New Query, paste the following in Query Editor:

SELECT
  product,
  COUNT(*) AS billing_records
FROM
  `cloud-training-prod-bucket.arch_infra.billing_data`
GROUP BY
  product
ORDER BY billing_records DESC

# Click Run.

# To find the most frequently used product costing more than 1 dollar, for New Query, paste the following in Query Editor:

SELECT
  product,
  COUNT(*) AS billing_records
FROM
  `cloud-training-prod-bucket.arch_infra.billing_data`
WHERE
  cost > 1
GROUP BY
  product
ORDER BY
  billing_records DESC

# Click Run.

# Which product had the most billing records of over $1

# Compute Engine has 17 charges costing more than 1 dollar.

# Kubernetes Engine has 7 charges costing more than 1 dollar.

# Cloud SQL has 15 charges costing more than 1 dollar.

# To find the most commonly charged unit of measure, for Compose New Query, paste the following in Query Editor:

SELECT
  usage_unit,
  COUNT(*) AS billing_records
FROM
  `cloud-training-prod-bucket.arch_infra.billing_data`
WHERE cost > 0
GROUP BY
  usage_unit
ORDER BY
  billing_records DESC

# Click Run.

# What was the most commonly charged unit of measure?

# Requests were the most commonly charged unit of measure with 6,539 requests.

# Requests were the most commonly charged unit of measure with 504 requests.

# Byte-seconds were the most commonly charged unit of measure with 2,937 requests.

# To find the product with the highest aggregate cost, for New Query, paste the following in Query Editor:

SELECT
  product,
  ROUND(SUM(cost),2) AS total_cost
FROM
  `cloud-training-prod-bucket.arch_infra.billing_data`
GROUP BY
  product
ORDER BY
  total_cost DESC

# Click Run.

# Which product has the highest total cost?

# Compute Engine has an aggregate cost of $112.02.

# Cloud SQL has an aggregate cost of $47.37

# BigQuery has an aggregate cost of $114.02

# Task 5. Review
# In this lab, you imported billing data into BigQuery that had been generated as a CSV file. You ran a simple query on the file. Then you accessed a shared dataset containing more than 22,000 records of billing information. You ran a variety of queries on that data to explore how you can use BigQuery to ask and answer questions by running queries.

# End your lab