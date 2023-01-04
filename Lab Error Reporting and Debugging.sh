#!/bin/bash

#rachelkabuyre@gmail.com
# Task 1. Create an application
# Get and test the application
# In the Cloud Console, launch Cloud Shell by clicking Activate Cloud Shell ( Activate Cloud Shell icon). If prompted, click Continue.

# To create a local folder and get the App Engine Hello world application, run the following commands:

mkdir appengine-hello
cd appengine-hello
gsutil cp gs://cloud-training/archinfra/gae-hello/* .

# To run the application using the local development server in Cloud Shell, run the following command:

dev_appserver.py $(pwd)

# In Cloud Shell, click Web Preview > Preview on port 8080 to view the application. You may have to collapse the Navigation menu pane to access the Web Preview icon.
# Note: A new browser window opens to the localhost and displays the message Hello, World!
# In Cloud Shell, press Ctrl+C to exit the development server.

# Deploy the application to App Engine
# To deploy the application to App Engine, run the following command:

gcloud app deploy app.yaml

# If prompted for a region, enter the number corresponding to a region.

# When prompted, type Y to continue.

# When the process is done, verify that the application is working by running the following command:

gcloud app browse

# Note: If Cloud Shell does not detect your browser, click the link in the Cloud Shell output to view your app. You might have to refresh the page for the application to load.
# If needed, press Ctrl+C to exit the development mode.

# Introduce an error to break the application
# To examine the main.py file, run the following command:

cat main.py

# Note: Notice that the application imports webapp2.

# You will break the configuration by replacing the import library with one that doesn't exist.
# To use the sed stream editor to change the import library to the nonexistent webapp22, run the following command:

sed -i -e 's/webapp2/webapp22/' main.py

# To verify the change you made in the main.py file, run the following command:

cat main.py

# Note: Notice that the application now tries to import webapp22.
# Re-deploy the application to App Engine
# To re-deploy the application to App Engine, run the following command:

gcloud app deploy app.yaml --quiet

# Note: The --quiet flag disables all interactive prompts when running gcloud commands. If input is required, defaults will be used. In this case, it avoids the need for you to type Y when prompted to continue the deployment.
# When the process is done, verify that the application is broken by running the following command:

gcloud app browse

# Note: If Cloud Shell does not detect your browser, click the link in the Cloud Shell output to view your app.
# If needed, press Ctrl+C to exit development mode.
# Leave Cloud Shell open.