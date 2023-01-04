#!/bin/bash

#rachelkabuyre@gmail.com
# Task 1. Create an application
# Get and test the application
# In the Cloud Console, launch Cloud Shell by clicking Activate Cloud Shell ( Activate Cloud Shell icon). If prompted, click Continue.

# To create a local folder and get the App Engine Hello world application, run the following commands:

mkdir appengine-hello
cd appengine-hello
gsutil cp gs://cloud-training/archinfra/gae-hello/* .
