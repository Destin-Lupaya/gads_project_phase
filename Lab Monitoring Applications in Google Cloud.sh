#!/bin/bash

#rachelkabuyre@gmail.com

# Task 1. Download a sample app from Github
# Download a sample application from GitHub and preview it in Cloud Shell.

# In the Cloud Console, click Activate Cloud Shell (Cloud Shell icon).

# If prompted, click Continue. Once connected to Cloud Shell, you should see that you are already authenticated and that the project is already set to your project ID.

# Run the following command in Cloud Shell to confirm that you are authenticated:

gcloud auth list

# Command output:

# Credentialed Accounts
# ACTIVE  ACCOUNT
# *      [my_account]@[my_domain.com]
# To set the active account, run:
#     $ gcloud config set account `ACCOUNT`
# Note: The gcloud command-line tool is the powerful and unified command-line tool in Google Cloud. It comes preinstalled in Cloud Shell. Among its features, gcloud offers tab completion in the shell. For more information, see gcloud command-line tool overview.
# Run the following command to confirm that you are using the correct project for this lab:

gcloud config list project

# Command output

# [core]
# project = [PROJECT_ID]
# If the correct project is not listed, you can set it with this command:

gcloud config set project [PROJECT_ID]

# Command output:

# Updated property [core/project].
# To create a folder called gcp-logging, run the following command:

mkdir gcp-logging

# Change to the folder you just created:

cd gcp-logging

# Clone a simple Python Flask app from Github:

 git clone https://GitHub.com/GoogleCloudPlatform/training-data-analyst.git

# Change to the deploying-apps-to-gcp folder:

 cd training-data-analyst/courses/design-process/deploying-apps-to-gcp

# In Cloud Shell, click Open Editor (Open Editor icon) and then Open in a window.

# Expand the gcp-logging/training-data-analyst/courses/design-process/deploying-apps-to-gcp folder in the navigation pane, and then click main.py to open it.

# Add the following import statement at the top of the file (line 2):

 import googlecloudprofiler

# Note: Profiler allows you to monitor the resources your applications use. For more information, refer to the Google Cloud Profiler documentation.
# After the main() function, add the following code snippet to start Profiler (after line 11):

try:
    googlecloudprofiler.start(verbose=3)
except (ValueError, NotImplementedError) as exc:
    print(exc)

# Profiler will continuously report application metrics. Your code should look like this:

# main.py code block

# Note: This code simply turns Profiler on. Once on, Profiler starts reporting application metrics to Google Cloud.
# You also have to add the Profiler library to your requirements.txt file. Open that file in the code editor and add the following:

google-cloud-profiler==3.0.6
protobuf==3.20.1

# The file should look like this:

# requirements.txt file

# Profiler has to be enabled in the project. In Cloud Shell, enter the following command:

 gcloud services enable cloudprofiler.googleapis.com

# To test the program, enter the following command to build a Docker container of the image:

 docker build -t test-python .

# To run the Docker image, enter the following command:
 docker run --rm -p 8080:8080 test-python

# To see the program running, click Web Preview (Web Preview icon) in the Google Cloud Shell toolbar. Then select Preview on port 8080.
# The program should be displayed in a new browser tab.

# In Cloud Shell, type Ctrl+C to stop the program.
# Click Check my progress to verify the objective.
# Enable the Profiler

# Task 2. Deploy an application to App Engine and examine the Cloud logs
# Now you will deploy the program to App Engine and use Google Cloud tools to monitor it.

# In the Cloud Shell code editor, in the Explorer pane, select the gcp-logging/training-data-analyst/courses/design-process/deploying-apps-to-gcp folder.

# On the File menu, click New File, and then name the file app.yaml.

# Paste the following into the file you just created:

 runtime: python37

# Save your changes.

# In a project, an App Engine application has to be created. This is done just once using the gcloud app create command and specifying the region where you want the app to be created. Enter the following command:

 gcloud app create --region=us-central

# Now deploy your app with the following command:

 gcloud app deploy --version=one --quiet

# Note: This command will take a couple of minutes to complete. Wait for it to complete before continuing.
# In the Cloud Console, on the Navigation menu (Navigation menu icon), click App Engine > Dashboard. The upper-right corner of the dashboard should display a link to your application similar to this:
# qwiklabs-gcp-02-2299defb275.appspot.com link

# Note: By default, the URL to an App Engine instance is in the form of https://project-id/appspot.com.
# Click on the link to test your program.

# Refresh your browser a few times to make some requests.

# Return to the Console and click the App Engine > Versions and click on the version link.

# Click Tools in the Diagnose column of the table, and then click Logs.

# The logs should indicate that Profiler has started and profiles are being generated. If you get to this point too quickly, wait a minute and click Refresh.

# Logs

# Click Check my progress to verify the objective.
# Deploy an application to App Engine and examine the Cloud logs

# Task 3. View Profiler information
# In the Cloud Console, on the Navigation menu (Navigation menu icon), click Profiler. The screen should look similar to this:
# Profiler page

# Note: The gray bar at the top represents the total amount of CPU time used by the program. The bars below represent the amount of CPU time used by the program's functions relative to the total. At this point, there is no traffic, so the chart is not very interesting. Throw some load at the application.
# On the Navigation menu, click Compute Engine.
# Click Create Instance to create a virtual machine.
# Change the region to someplace other than us-central1 (the App Engine app is in us-central1). Accept all the rest of the defaults and click Create.
# Click Check my progress to verify the objective.
# Create an instance

# When the VM is ready, click SSH to log in to it.

# You will generate some traffic to your App Engine app using the web testing tool called Apache Bench. Enter the following commands to install it:

# sudo apt update
# sudo apt install apache2-utils -y
# Copied!
# Update <your-project-id> with your PROJECT_ID from connection details panel and enter the following command to generate some traffic to your App Engine application:

# ab -n 1000 -c 10 https://<your-project-id>.appspot.com/
# Copied!
# The command will make a thousand requests, 10 at a time, to your application.

# Note: You have to change the URL to point to your application. Recall that you can find the URL in the App Engine Dashboard. It is also on the browser tab you used to test your app, if you haven't closed it. Also, make sure you insert a slash (/) at the end of the URL.
# When the requests are finished, on the Navigation menu, click Profiler.
# Now there is a more interesting chart. Each bar represents a function. The width of the bars represents how much CPU time each function consumed.

# The Profiler is a way developers can track down parts of a program that are consuming too many resources.

# Profiler chart

# Task 4. Explore Cloud Trace
# Every request to your application is added to the Trace list. On the Navigation menu (Navigation menu icon), click Trace.
# The overview screen shows recent requests and allows you to create reports to analyze traffic. Because your program is new and has only one page, it's not very interesting, but in a real app there would be lots of useful information.

# Click Trace list.
# This shows a history of requests and their latency. Again, it's not very exciting because the application hasn't been running for very long. The chart in the upper-left plots requests and how long they took. The table to the right shows a list of requests. If you select a request, more detail will be displayed at the bottom of the screen.

# Return to the SSH window where you entered the Apache Bench command previously.

# Enter the ab command again:

# ab -n 1000 -c 10 https://<your-project-id>.appspot.com/
# Copied!
# You can also experiment with different values for the -n and -c parameters.

# Repeat this a couple of times, and then return to the Trace list page.

# Task 5. Monitor resources using Dashboards
# In the Cloud Console, on the Navigation menu (Navigation menu icon), click Monitoring.
# In the left pane, click Dashboards. Cloud Monitoring analyzes the resources used in your projects and generates some default dashboards for you. In this exercise you have used App Engine and Compute Engine virtual machines, so a table similar to the one shown below should be displayed:
# Filter Dashboards table

# Click on the App Engine dashboard, and then select your project name. A dashboard of pertinent information for your App Engine application will appear.

# In the left pane, click Dashboards.

# Click on the VM Instances dashboard, and then select your instance. A dashboard for your VM will appear.

# Note: If you don't see VM Instances right away, wait a minute and refresh your browser.
# Alternatively, return to the Dashboards page and click the +Create Dashboard. Try to create a custom dashboard.

# For New Dashboard Name, type the custom dashboard name you have chosen. You can continue with your custom dashboard by adding the charts.

# Task 6. Create uptime checks and alerts
# In the left pane, click Uptime checks, and then click the + Create Uptime Check link at the top. Fill out the form as follows:
# Property	Value
# Title	App Engine Uptime Check
# Protocol	HTTPS
# Resource Type	URL
# Hostname	<your-project-id>.appspot.com
# Path	/
# Check Frequency	1 minute
# Click on Next and then click Test to verify that your uptime check can connect to the resource. When you see a green check mark everything can connect.

# When you are asked whether you want to create an Alerting Policy, do so.

# In Alert & Notification, Name the policy Uptime Check Alert.

# Click on the drop down arrow next to Notification Channels, then click on Manage Notification Channels. A Notification channels page will open in a new tab.

# Scroll down the page and click on ADD NEW for Email.

# In the Create Email Channel dialog box, enter your personal email address in the Email Address field and a Display name.

# Click on Save.

# Go back to the previous tab. Click on Notification Channels again, then click on the Refresh icon to get the display name you mentioned in the previous step.

# Refresh icon

# Now, select your Display name and click OK.
# Click Create. The uptime check you configured takes a while for it to become active.
# Click Check my progress to verify the objective.
# Create uptime checks and alerts

# Disable the application to see whether your uptime check and alerting policy work. In the Cloud Console, on the Navigation menu, click App Engine.

# Click Settings.

# Click Disable application. Follow the instructions to disable the application.

# Return to the App Engine Dashboard and test the URL. It shouldn't work anymore.

# Return to Monitoring and then click Uptime checks. Your uptime check should be failing. If you get there too fast, wait a minute and click refresh.

# Click Alerting. An incident should have been fired.

# Check your email. You should get a message from Cloud Monitoring.

# Return to App Engine Settings and re-enable your application. Then return to the Uptime checks page. The uptime check should be working again. If not, wait a minute and then click refresh.

# Return to the Alerting page. Your incident should be resolved. As before, you might have to wait a minute and then click refresh.

# Check your email again. You should get a second email indicating that the alert recovered.

# To make sure you don't get any emails after the project is deleted, delete your alerting policy and then delete your notification channel. At the top of the Alerting page, click Edit Notification Channels.

# Find your email address and click the trash can icon to delete it.

# Now click Uptime checks and delete your App Engine Uptime check.

