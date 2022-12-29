#!/bin/bash

#rachelkabuyre@gmail.com



# Task 1. Setup for two users
# Sign in to the Cloud Console as the first user
# This lab provisions you with two user names available in the Connection Details dialog. Sign in to the Cloud Console in an Incognito window as usual with the Username 1 provided in Qwiklabs. Note that both user names use the same single password.

# Sign in to the Cloud Console as the second user
# Open another tab in your incognito window.
# Browse to console.cloud.google.com.
# Click on the user icon in the top-right corner of the screen, and then click Add account.
# Sign in to the Cloud Console with the Username 2 provided in Qwiklabs.
# Note: At some points in this lab, if you sign out of the Username 1 account, the Username 2 account is deleted by Qwiklabs. So remain signed in to Username 1 until you are done using Username 2.

# Task 2. Explore the IAM console
# Make sure you are on the Username 1 Cloud Console tab.

# Navigate to the IAM console and explore roles
# On the Navigation menu (Navigation menu icon), click IAM & admin > IAM.
# Click Grant Access and explore the roles in the drop-down menu. Note the various roles associated with each resource by navigating the Roles menu.
# Click CANCEL.
# Switch to the Username 2 Cloud Console tab.
# On the Navigation menu (Navigation menu icon), click IAM & admin > IAM. Browse the list for the lines with the names associated with Username 1 and Username 2 in the Qwiklabs Connection Details dialog.
# Note: Username 2 currently has access to the project, but does not have the Project Owner role, so it cannot edit any of the roles. Hover over the pencil icon for Username 2 to verify this.
# Switch back to the Username 1 Cloud Console tab.

# In the IAM console, for Username 2, click on the pencil icon. Username 2 currently has the Viewer role. Do not change the Project Role.

# Click CANCEL.

# Task 3. Prepare a resource for access testing
# Create a bucket and upload a sample file
# Switch to the Username 1 Cloud Console tab if you aren't already there.

# On the Navigation menu (Navigation menu icon), click Cloud Storage > Buckets.

# Click +Create.

# Specify the following, and leave the remaining settings as their defaults:

# Property	Value (type value or select option as specified)
# Name	Enter a globally unique name
# Location type	Multi-region
# Note: Record the bucket name: it will be used in a later step and referred to as [YOUR_BUCKET_NAME]
# Click CREATE.
# Click UPLOAD FILES.
# Upload any sample file from your local machine.
# When the file has been uploaded, click on the three dots at the end of the line containing the file, and click Rename.
# Rename the file to sample.txt, and click RENAME.
# Verify project viewer access
# Switch to the Username 2 Cloud Console tab.

# In the Console, navigate to Navigation menu > Cloud Storage > Buckets.

# Verify that Username 2 can see the bucket.

# Task 4. Remove project access
# Remove Project Viewer role for Username 2
# Switch to the Username 1 Cloud Console tab.
# On the Navigation menu (Navigation menu icon), click IAM & admin > IAM.
# Select Username 2 and click Remove Access.
# Note: Verify that you're removing access for Username 2. If you accidentally remove access for Username 1 you will have to restart this lab!
# Confirm by clicking CONFIRM.

# Verify that Username 2 has lost access
# Switch to the Username 2 Cloud Console tab.

# On the Navigation menu (Navigation menu icon), click Cloud overview > Dashboard.

# On the Navigation menu (Navigation menu icon), click Cloud Storage > Buckets. An error will be displayed. If not, refresh the page. Username 2 still has a Google Cloud account, but has no access to the project.

# Task 5. Add storage access
# Add storage permissions
# Copy the value of Username 2 from the Qwiklabs Connection Details dialog.
# Switch to the Username 1 Cloud Console tab.
# On the Navigation menu (Navigation menu icon), click IAM & admin > IAM.
# Click Grant Access to add the user.
# For New principals, paste the Username 2 value you copied from the Qwiklabs Connection Details dialog.
# For Select a role, select Cloud Storage > Storage Object Viewer.
# Click SAVE.
# Verify that Username 2 has storage access
# Switch to the Username 2 Cloud Console tab.
# Note: Username 2 doesn't have Project Viewer roles, so that user can't see the project or any of its resources in the Console. However, the user has specific access to Cloud Storage.
# To start Cloud Shell, click Activate Cloud Shell (Activate Cloud Shell icon). If prompted, click Continue.

# To view the contents of the bucket you created earlier, run the following command, replacing [YOUR_BUCKET_NAME] with the unique name of the Cloud Storage bucket you created:

gsutil ls gs://[YOUR_BUCKET_NAME]

# As you can see, Username 2 has limited access to Cloud Storage.

# Close the Username 2 Cloud Console tab. The rest of the lab is performed on the Username 1 Cloud Console tab.

# Switch to the Username 1 Cloud Console tab.

# Task 6. Set up the Service Account User
# In this part of the lab, you assign narrow permissions to service accounts and learn how to use the Service Account User role.

# Create a service account
# On the Navigation menu (Navigation menu icon), click IAM & Admin > Service Accounts.

# Click + CREATE SERVICE ACCOUNT.

# Specify the Service account name as read-bucket-objects .

# Click CREATE AND CONTINUE.

# For Select a role, select Cloud Storage > Storage Object Viewer .

# Click CONTINUE.

# Click DONE.

# Add the user to the service account
# Select the read-bucket-objects service account.
# Click on the three dots to the right of the service account name. Then click on Manage permissions
# Note: You will grant the user the role of Service Account User, which allows that person to use a service account on a VM, if they have access to the VM. You could perform this activity for a specific user, group, or domain. For training purposes, you will grant the Service Account User role to everyone at a company called Altostrat.com. Altostrat.com is a fake company used for demonstration and training.
# Click on the GRANT ACCESS button. Specify the following, and leave the remaining settings as their defaults:
# Property	Value (type value or select option as specified)
# New principals	altostrat.com
# Role	Service Accounts > Service Account User
# Click SAVE.

# Grant Compute Engine access
# You now give the entire organization at Altostrat the Compute Engine Admin role.

# On the Navigation menu (Navigation menu icon), click IAM & admin > IAM.
# Click Grant Access.
# Specify the following, and leave the remaining settings as their defaults:
# Property	Value (type value or select option as specified)
# New principals	altostrat.com
# Select a role	Compute Engine > Compute Instance Admin (v1)
# Click SAVE.
# Note: This step is a rehearsal of the activity you would perform for a specific user. This action gives the user limited abilities with a VM instance. The user will be able to connect via SSH to a VM and perform some administration tasks.
# Create a VM with the Service Account User
# On the Navigation menu (Navigation menu icon), click Compute Engine > VM instances.
# Click CREATE INSTANCE.
# Specify the following, and leave the remaining settings as their defaults:
# Property	Value (type value or select option as specified)
# Name	demoiam
# Region	us-east1
# Zone	us-east1-b
# Series	E2
# Machine Type	e2-micro (2 vCPU, 1 GB memory)
# Boot disk	Debian GNU/Linux 11 (bullseye)
# Service account	read-bucket-objects
# Click Create.

gcloud compute instances create demoiam --project=qwiklabs-gcp-04-432fef0e552c --zone=us-east1-b --machine-type=e2-micro --network-interface=network-tier=PREMIUM,subnet=default --metadata=enable-oslogin=true --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=id-read-bucket-objects@qwiklabs-gcp-04-432fef0e552c.iam.gserviceaccount.com --scopes=https://www.googleapis.com/auth/cloud-platform --create-disk=auto-delete=yes,boot=yes,device-name=demoiam,image=projects/debian-cloud/global/images/debian-11-bullseye-v20221206,mode=rw,size=10,type=projects/qwiklabs-gcp-04-432fef0e552c/zones/us-east1-b/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

# Task 7. Explore the Service Account User role
# At this point, you might have the user test access by connecting via SSH to the VM and performing the next actions. As the owner of the project, you already possess the Service Account User role. So you can simulate what the user would experience by just using SSH to access the VM from the Cloud Console.

# The actions you perform and results will be the same as if you were the target user.

# Use the Service Account User
# For demoiam, click SSH to launch a terminal and connect.

# Run the following command:

gcloud compute instances list

# What happened? Why?

# Copy the sample.txt file from the bucket you created earlier. Note that the trailing period is part of the command below. It means copy to "this location":

gsutil cp gs://[YOUR_BUCKET_NAME]/sample.txt 

# To rename the file you copied, run the following command:


mv sample.txt sample2.txt

# To copy the renamed file back to the bucket, run the following command:

gsutil cp sample2.txt gs://[YOUR_BUCKET_NAME]

# Note: What happened? Because you connected via SSH to the instance, you can act as the service account essentially assuming the same permissions. The service account the instance was started with had the Storage Viewer role, which permits downloading objects from GCS buckets in the project. To list instances in a project, you need to grant the compute.instance.list permission. Because the service account did not have this permission, you could not list instances running in the project. Because the service account did have permission to download objects, it could download an object from the bucket. It did not have permission to write objects, so you got an 403 access denied message.
# On the Navigation menu (Navigation menu icon), click IAM & admin > IAM.

# Browse the list for the lines with read-bucket-objects, click on the pencil icon. read-bucket-objects currently has the Storage Object Viewer role. Alter the Role to Cloud Storage > Storage Object Creator .

# Click Save

# Return to the SSH window for demoiam

# To copy the renamed file back to the bucket, run the following command:

gsutil cp sample2.txt gs://[YOUR_BUCKET_NAME]

# This time the command succeeds as the service account has the correct permissions.