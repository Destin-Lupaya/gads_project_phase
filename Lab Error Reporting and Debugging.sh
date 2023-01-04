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

# Task 2. Explore Cloud Error Reporting
# View Error Reporting and trigger additional errors
# In the Cloud Console, on the Navigation menu ( Navigation menu icon), click Error Reporting.
# Note: You should see an error regarding the failed import of webapp22.
# Click Auto reload.

# In Cloud Shell, run the following command:

gcloud app browse

# Note: If Cloud Shell does not detect your browser, click the link in the Cloud Shell output to view your app.
# Click the resulting link several times to generate more errors.
# Note: The number of errors is displayed in the Occurrences column. The graph shows the frequency of errors over time, and the number represents the sum of errors. This is a very handy visual indicator of the state of the error.

# The First seen and Last seen columns show when the error was first seen and when it was last seen, respectively. This can help identify changes that might have triggered the error. In this case, it was the upload of the new version of app engine code.

# Which service(s) are currently supported by Cloud Error Reporting?

# Kubernetes

# App Engine Standard

# App Engine Flexible

# Compute Engine

# View details and identify the cause
# Click the Error name: ImportError: No module named webapp22.
# Note: Now you can see a detailed graph of the errors. The Response Code field shows the explicit error: a 500 Internal Server Error.
# For Stack trace sample, click Parsed. This opens the Cloud Debugger, showing the error in the code!

# View the logs and fix the error
# At the bottom of the Debug page, just below the code, find and open View logs in a new window or tab. Here you can find more detailed historical information about the error.

# Introduce more errors by refreshing the page of your application. If you closed your application, use gcloud app browse and click the link to view the broken app.

# On the Cloud Error Reporting page, ensure that Auto Reload is enabled to watch the addition of new errors.

# In Cloud Shell, fix the error by running the following command:

sed -i -e 's/webapp22/webapp2/' main.py

# To re-deploy the application to App Engine, run the following command:

gcloud app deploy app.yaml --quiet

# When the process is done, to verify that the application is working again, run the following command:

gcloud app brow

# Note: If Cloud Shell does not detect your browser, click the link in the Cloud Shell output to view your app.
# On the Cloud Error Reporting page, ensure that Auto Reload is enabled to and see that no new errors are added.
# What would not be considered a benefit of Cloud Operations?

# Multi-cloud monitoring

# Reduces monitoring overhead

# Faster problem resolution

# Boosts all network performance

# Task 3. Review
# In this lab you deployed an application to App Engine. Then you introduced a code bug and broke the application. You used Cloud Error Reporting to identify the issue, and then analyzed the problem, finding the root cause using Cloud Debugger. You modified the code to fix the problem, and then saw the results in Cloud Operations.

# End your lab