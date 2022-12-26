# Task 1. Use Marketplace to build a deployment
# Navigate to Marketplace
# In the Cloud Console, on the Navigation menu (Navigation menu icon), click Marketplace.
# Locate the Jenkins deployment by searching for Jenkins packaged by Bitnami.
# Click on the deployment and read about the service provided by the software.
# Jenkins is an open-source continuous integration environment. You can define jobs in Jenkins that can perform tasks such as running a scheduled build of software and backing up data. Notice the software that is installed as part of Jenkins shown in the left side of the description.

# The service you are using, Marketplace, is part of Google Cloud. The Jenkins template is developed and maintained by an ecosystem partner named Bitnami. Notice on the left side a field that says "Last updated." How recently was this template updated?

# Launch Jenkins
# Click Launch.
# Verify the deployment, accept the terms and services and click Deploy.
# Note: It will take a minute or two for Deployment Manager to set up the deployment. You can watch the status as tasks are being performed. Deployment Manager is acquiring a virtual machine instance and installing and configuring software for you. You will see jenkins-1 has been deployed when the process is complete.

# Deployment Manager is a Google Cloud service that uses templates written in a combination of YAML, python, and Jinja2 to automate the allocation of Google Cloud resources and perform setup tasks. Behind the scenes a virtual machine has been created. A startup script was used to install and configure software, and network Firewall Rules were created to allow traffic to the service.

# Task 2. Examine the deployment
# In this section, you examine what was built in Google Cloud.

# View installed software and login to Jenkins
# In the right pane, note the Admin user and Admin password values and add them to a text editor.
# Click Visit the site to view the site in another browser tab. If you get an error, you might have to reload the page a couple of times.
# Log in with the Admin user and Admin password values.
# Note: If you get an http 404 error, then remove the /jenkins part from the site address and hit Enter. For example: http://35.238.162.236
# After logging in, if you are asked to Customize Jenkins. Click Install suggested plugins, and then click Restart after the installation is complete. The restart will take a couple of minutes.
# Note: If you are getting an installation error, retry the installation and if it fails again, continue past the error and save and finish before restarting. The code of this solution is managed and supported by Bitnami.
# Explore Jenkins
# In the Jenkins interface, in the left pane, click Manage Jenkins. Look at all of the actions available. You are now prepared to manage Jenkins. The focus of this lab is Google Cloud infrastructure, not Jenkins management, so seeing that this menu is available is the purpose of this step.
# Leave the browser window open to the Jenkins service. You will use it in the next task.
# Note: Now you have seen that the software is installed and working properly. In the next task you will open an SSH terminal session to the VM where the service is hosted, and verify that you have administrative control over the service.

# Task 3. Administer the service
# View the deployment and SSH to the VM
# In the Cloud Console, on the Navigation menu(Navigation menu icon), click Deployment Manager.
# Click jenkins-1.
# Click SSH to connect to the Jenkins server.
# Note: The Console interface is performing several tasks for you transparently. For example, it has transferred keys to the virtual machine that is hosting the Jenkins software so that you can connect securely to the machine using SSH.

# Shut down and restart the services
# In the SSH window, enter the following command to shut down all the running services:

sudo /opt/bitnami/ctlscript.sh stop

# Refresh the browser window for the Jenkins UI. You will no longer see the Jenkins interface because the service was shut down.

# In the SSH window, enter the following command to restart the services:
sudo /opt/bitnami/ctlscript.sh restart

# Return to the browser window for the Jenkins UI and refresh it. You may have to do it a couple of times before the service is reachable.

# In the SSH window, type exit to close the SSH terminal session.