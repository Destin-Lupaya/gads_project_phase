#!/bin/bash

#rachelkabuyre@gmail.com

# Overview
# In this lab, you learn how to use Cloud Monitoring to gain insight into applications that run on Google Cloud.

# Objectives
# In this lab, you learn how to perform the following tasks:

# Explore Cloud Monitoring

# Add charts to dashboards

# Create alerts with multiple conditions

# Create resource groups

# Create uptime checks

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

# Task 1. Create a Cloud Monitoring workspace
# Verify resources to monitor
# Three VM instances have been created for you that you will monitor.

# In the Cloud Console, on the Navigation menu (Navigation menu icon), click Compute Engine > VM instances. Notice the nginxstack-1, nginxstack-2 and nginxstack-3 instances.
# Create a Monitoring workspace
# You will now setup a Monitoring workspace that's tied to your Google Cloud Project. The following steps create a new account that has a free trial of Monitoring.

# In the Cloud Console, click on Navigation menu > Monitoring.

# Wait for your workspace to be provisioned.

# When the Monitoring dashboard opens, your workspace is ready.
# Task 2. Custom dashboards
# Create a dashboard
# In the left pane, click Dashboards.

# Click +Create Dashboard.

# For New Dashboard Name, type My Dashboard.

# Add a chart
# From Chart library, Select Line.

# For Title, give your chart a name (you can revise this before you save based on the selections you make).

# Type CPU utilization or CPU usage in Resource & Metric field, Click VM Instance > Instance. Select CPU utilization or CPU usage and click Apply.

# Click + Add Filter and explore the various options.

# Metrics Explorer
# The Metrics Explorer allows you to examine resources and metrics without having to create a chart on a dashboard. Try to recreate the chart you just created using the Metrics Explorer.

# In the left pane, click Metrics explorer.
# For Resource & Metric, Select a Metric.
# Explore the various options and try to recreate the chart you created earlier.
# Note: Not all metrics are currently available on the Metrics Explorer, so you might not be able to find the exact metric you used on the previous step.

# Create an alert and add the first condition
# In the Cloud Console, from the Navigation menu, select Monitoring > Alerting.
# Click + Create Policy.
# Click on Select a metric dropdown. Disable the Show only active resources & metrics.
# Type VM Instance in filter by resource and metric name and click on VM Instance > Instance. Select CPU usage or CPU Utilization and click Apply.
# Note: If you cannot locate the VM Instance resource type, you might have to refresh the page.
# Set Rolling windows to 1 min.

# Click Next. Set Threshold position to Above Threshold and set 20 as your Threshold value.

# Add a second condition
# Click +ADD ALERT CONDITION.

# Repeat the steps above to specify the second condition for this policy. For example, repeat the condition for a different instance. Click Next.

# In Multi-condition-triggers, for Trigger when, click All conditions are met.

# Click Next.

# Configure notifications and finish the alerting policy
# Click on the dropdown arrow next to Notification Channels, then click on Manage Notification Channels.
# A Notification channels page will open in a new tab.

# Scroll down the page and click on ADD NEW for Email.
# Enter your personal email in the Email Address field and a Display name.
# Click Save.
# Go back to the previous Create alerting policy tab.
# Click on Notification Channels again, then click on the Refresh icon to get the display name you mentioned in the previous step. Click Notification Channels again if needed.
# Now, select your Display name and click OK.
# Enter a name of your choice in the Alert name field.
# Click Next.
# Review the alert and click Create Policy.
# Click Check my progress to verify the objective.

Task 4. Resource groups
In the left pane, click Groups.
Click + Create Group.
Enter a name for the group. For example: VM instances
In the Criteria section, type nginx in the value field below Contains.
Click DONE.
Click CREATE.
Review the dashboard Cloud Monitoring created for your group.