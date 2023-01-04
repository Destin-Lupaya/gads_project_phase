#!/bin/bash

#rachelkabuyre@gmail.com

# Overview
# In this lab, you configure a Cloud SQL server and learn how to connect an application to it via a proxy over an external connection. You also configure a connection over a Private IP link that offers performance and security benefits. The app we chose to demonstrate in this lab is Wordpress, but the information and best practices are applicable to any application that needs SQL Server.

# By the end of this lab, you will have 2 working instances of the Wordpress frontend connected over 2 different connection types to their SQL instance backend, as shown in this diagram:

# SQL Lab Diagram

# Objectives
# In this lab, you learn how to perform the following tasks:

# Create a Cloud SQL database

# Configure a virtual machine to run a proxy

# Create a connection between an application and Cloud SQL

# Connect an application to Cloud SQL using Private IP address

# Setup
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

# Task 1. Create a Cloud SQL database
# In this task, you configure a SQL server according to Google Cloud best practices and create a Private IP connection.

# On the Navigation menu (Navigation menu icon), click SQL.
# Click Create instance.
# Click Choose MySQL.
# Specify the following, and leave the remaining settings as their defaults:
# Property	Value
# Instance ID	wordpress-db
# Root password	type a password
# Region	Lab Region
# Zone	Any
# Database Version	MySQL 5.7
# Note: Note the root password; it will be used in a later step and referred to as [ROOT_PASSWORD].
# Expand Show configuration options.

# Expand the Machine type section.

# Provision the right amount of vCPU and memory. To choose a Machine Type, click the dropdown menu, and then explore your options.

# Note: A few points to consider:

# Shared-core machines are good for prototyping, and are not covered by Cloud SLA.
# Each vCPU is subject to a 250 MB/s network throughput cap for peak performance. Each additional core increases the network cap, up to a theoretical maximum of 2000 MB/s.
# For performance-sensitive workloads such as online transaction processing (OLTP), a general guideline is to ensure that your instance has enough memory to contain the entire working set and accommodate the number of active connections.
# For this lab, select standard from the dropdown menu, and then select 1 vCPU, 3.75 GB.

# Next, expand the Storage section and then choose Storage type and Storage capacity.

# Note: A few points to consider:

# SSD (solid-state drive) is the best choice for most use cases. HDD (hard-disk drive) offers lower performance, but storage costs are significantly reduced, so HDD may be preferable for storing data that is infrequently accessed and does not require very low latency.
# There is a direct relationship between the storage capacity and its throughput.
# Click each of the capacity options to see how it affects the throughput. Reset the option to 10GB.
# Note: Setting your storage capacity too low without enabling an automatic storage increase can cause your instance to lose its SLA.
# Expand the Connections section.

# Select Private IP.

# In the Network dropdown, select default.

# Click the Set up Connection button that appears.

# In the panel to the right, click Enable API, click Use an automatically allocated IP range, click Continue, and then click Create Connection.

# Click Create Instance at the bottom of the page to create the database instance.

# Note: You might have to wait for the Private IP changes to propagate before the Create button becomes clickable.