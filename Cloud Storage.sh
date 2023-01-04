#!/bin/bash

#rachelkabuyre@gmail.com
# Overview
# Cloud Storage is a fundamental resource in Google Cloud, with many advanced features. In this lab, you exercise many Cloud Storage features that could be useful in your designs. You explore Cloud Storage using both the console and the gsutil tool.

# Objectives
# In this lab, you learn how to perform the following tasks:

# Create and use buckets

# Set access control lists to restrict access

# Use your own encryption keys

# Implement version controls

# Use directory synchronization

# Share a bucket across projects using IAM

# Task 1. Preparation
# Create a Cloud Storage bucket
# On the Navigation menu (Navigation menu icon), click Cloud Storage > Buckets.
# Note: a bucket must have a globally unique name. You could use part of your PROJECT_ID_1 in the name to help make it unique. For example, if the PROJECT_ID_1 is myproj-154920 your bucket name might be storecore154920
# Click Create bucket.
# Specify the following, and leave the remaining settings as their defaults:
# Property	Value (type value or select option as specified)
# Name	Enter a globally unique name
# Location type	Multi-region
# Enforce public access prevention on this bucket	unchecked
# Access control	Fine-grained (object-level permission in addition to your bucket-level permissions)
# Make a note of the bucket name. It will be used later in this lab and referred to as [BUCKET_NAME_1].
# Click Create.

# Download a sample file using CURL and make two copies
# In the Cloud Console, click Activate Cloud Shell (Cloud Shell).

# If prompted, click Continue.

# Store [BUCKET_NAME_1] in an environment variable:
export BUCKET_NAME_1=<enter bucket name 1 here>
# Verify it with echo:
echo $BUCKET_NAME_1
# Run the following command to download a sample file (this sample file is a publicly available Hadoop documentation HTML file):
curl \
https://hadoop.apache.org/docs/current/\
hadoop-project-dist/hadoop-common/\
ClusterSetup.html > setup.html
# To make copies of the file, run the following commands:
cp setup.html setup2.html
cp setup.html setup3.html

# Task 2. Access control lists (ACLs)
# Copy the file to the bucket and configure the access control list
# Run the following command to copy the first file to the bucket:
gsutil cp setup.html gs://$BUCKET_NAME_1/
# To get the default access list that's been assigned to setup.html, run the following command:
gsutil acl get gs://$BUCKET_NAME_1/setup.html  > acl.txt
cat acl.txt

# To set the access list to private and verify the results, run the following commands:
gsutil acl set private gs://$BUCKET_NAME_1/setup.html
gsutil acl get gs://$BUCKET_NAME_1/setup.html  > acl2.txt
cat acl2.txt

# To update the access list to make the file publicly readable, run the following commands:
gsutil acl ch -u AllUsers:R gs://$BUCKET_NAME_1/setup.html
gsutil acl get gs://$BUCKET_NAME_1/setup.html  > acl3.txt
cat acl3.txt

# Examine the file in the Cloud Console
# In the Cloud Console, on the Navigation menu (Navigation menu icon), click Cloud Storage > Buckets.

# Click [BUCKET_NAME_1].

# Verify that for file setup.html, Public access has a Public link available.
# Delete the local file and copy back from Cloud Storage
# Return to Cloud Shell. If necessary, click Activate Cloud Shell (Cloud Shell).

# Run the following command to delete the setup file:
rm setup.html
# To verify that the file has been deleted, run the following command:
ls
# To copy the file from the bucket again, run the following command:
gsutil cp gs://$BUCKET_NAME_1/setup.html setup.html

# Task 3. Customer-supplied encryption keys (CSEK)
# Generate a CSEK key
# For the next step, you need an AES-256 base-64 key.

# Run the following command to create a key:
python3 -c 'import base64; import os; print(base64.encodebytes(os.urandom(32)))'

# Result (this is example output):
# Copy the value of the generated key excluding b' and \n' from the command output. Key should be in form of tmxElCaabWvJqR7uXEWQF39DhWTcDvChzuCmpHe6sb0=.

# Modify the boto file
# The encryption controls are contained in a gsutil configuration file named .boto.

# To view and open the boto file, run the following commands:
ls -al
nano .boto

# Note: if the .boto file is empty, close the nano editor with Ctrl+X and generate a new .boto file using the gsutil config -n command. Then, try opening the file again with the above commands.

# If the .boto file is still empty, you might have to locate it using the gsutil version -l command.

# Locate the line with "#encryption_key="
# Note: the bottom of the nano editor provides you with shortcuts to quickly navigate files. Use the Where Is shortcut to quickly locate the line with the #encryption_key=.
# Uncomment the line by removing the # character, and paste the key you generated earlier at the end.
# Example (this is an example):

Before:
# encryption_key=
After:
encryption_key=tmxElCaabWvJqR7uXEWQF39DhWTcDvChzuCmpHe6sb0=


# Press Ctrl+O, ENTER to save the boto file, and then press Ctrl+X to exit nano.

# Upload the remaining setup files (encrypted) and verify in the Cloud Console
# To upload the remaining setup.html files, run the following commands:
gsutil cp setup2.html gs://$BUCKET_NAME_1/
gsutil cp setup3.html gs://$BUCKET_NAME_1/

# Return to the Cloud Console.
# Click [BUCKET_NAME_1]. Both setup2.html and setup3.html files show that they are customer-encrypted.

# Delete local files, copy new files, and verify encryption

# To delete your local files, run the following command in Cloud Shell:
rm setup*
# To copy the files from the bucket again, run the following command:

gsutil cp gs://$BUCKET_NAME_1/setup* ./
Copied!
# To cat the encrypted files to see whether they made it back, run the following commands:

cat setup.html
cat setup2.html
cat setup3.html

# Task 4. Rotate CSEK keys
# Move the current CSEK encrypt key to decrypt key
# Run the following command to open the .boto file:

nano .boto

# Comment out the current encryption_key line by adding the # character to the beginning of the line.
# Note: the bottom of the nano editor provides you with shortcuts to quickly navigate files. Use the Where Is shortcut to quickly locate the line with the #encryption_key=.
# Uncomment decryption_key1 by removing the # character, and copy the current key from the encryption_key line to the decryption_key1 line.
# Result (this is example output):

Before:
encryption_key=2dFWQGnKhjOcz4h0CudPdVHLG2g+OoxP8FQOIKKTzsg=
# decryption_key1=
After:
# encryption_key=2dFWQGnKhjOcz4h0CudPdVHLG2g+OoxP8FQOIKKTzsg=
decryption_key1=2dFWQGnKhjOcz4h0CudPdVHLG2g+OoxP8FQOIKKTzsg=
# Press Ctrl+O, ENTER to save the boto file, and then press Ctrl+X to exit nano.
# Note: In practice, you would delete the old CSEK key from the encryption_key line.

eOxwIF5CV0BnCIvngiTMovx3KjHTKyIjcnzckwlLXhs=

# Note: In practice, you would delete the old CSEK key from the encryption_key line.

# Generate another CSEK key and add to the boto file
# Run the following command to generate a new key:

python3 -c 'import base64; import os; print(base64.encodebytes(os.urandom(32)))'

# Copy the value of the generated key excluding b' and \n' from the command output. Key should be in form of tmxElCaabWvJqR7uXEWQF39DhWTcDvChzuCmpHe6sb0=.

# To open the boto file, run the following command:

nano .boto

# Uncomment encryption and paste the new key value for encryption_key=.
# Result (this is example output):

Before:
# encryption_key=2dFWQGnKhjOcz4h0CudPdVHLG2g+OoxP8FQOIKKTzsg=
After:
encryption_key=HbFK4I8CaStcvKKIx6aNpdTse0kTsfZNUjFpM+YUEjY=
# Press Ctrl+O, ENTER to save the boto file, and then press Ctrl+X to exit nano.

# Rewrite the key for file 1 and comment out the old decrypt key
# When a file is encrypted, rewriting the file decrypts it using the decryption_key1 that you previously set, and encrypts the file with the new encryption_key.

# You are rewriting the key for setup2.html, but not for setup3.html, so that you can see what happens if you don't rotate the keys properly.

# Run the following command:
gsutil rewrite -k gs://$BUCKET_NAME_1/setup2.html
# To open the boto file, run the following command:
nano .boto

# Comment out the current decryption_key1 line by adding the # character back in.
# Result (this is example output):

Before:
decryption_key1=2dFWQGnKhjOcz4h0CudPdVHLG2g+OoxP8FQOIKKTzsg=
After:
# decryption_key1=2dFWQGnKhjOcz4h0CudPdVHLG2g+OoxP8FQOIKKTzsg=

# Press Ctrl+O, ENTER to save the boto file, and then press Ctrl+X to exit nano.
# Note: In practice, you would delete the old CSEK key from the decryption_key1 line.

# Download setup 2 and setup3
# To download setup2.html, run the following command:

gsutil cp  gs://$BUCKET_NAME_1/setup2.html recover2.html

# To download setup3.html, run the following command:

gsutil cp  gs://$BUCKET_NAME_1/setup3.html recover3.html

# Note: What happened? setup3.html was not rewritten with the new key, so it can no longer be decrypted, and the copy will fail.
# You have successfully rotated the CSEK keys.
# Task 5. Enable lifecycle management
# View the current lifecycle policy for the bucket
# Run the following command to view the current lifecycle policy:

gsutil lifecycle get gs://$BUCKET_NAME_1

# Note: there is no lifecycle configuration. You create one in the next steps.

# Create a JSON lifecycle policy file
# To create a file named life.json, run the following command:

nano life.json

# Paste the following value into the life.json file:

{
  "rule":
  [
    {
      "action": {"type": "Delete"},
      "condition": {"age": 31}
    }
  ]
}

# Note: these instructions tell Cloud Storage to delete the object after 31 days.
# Press Ctrl+O, ENTER to save the file, and then press Ctrl+X to exit nano.

# Set the policy and verify
# To set the policy, run the following command:

gsutil lifecycle set life.json gs://$BUCKET_NAME_1

# To verify the policy, run the following command:

gsutil lifecycle get gs://$BUCKET_NAME_1

# Task 6. Enable versioning
# View the versioning status for the bucket and enable versioning
# Run the following command to view the current versioning status for the bucket:

gsutil versioning get gs://$BUCKET_NAME_1

# Note: the Suspended policy means that it is not enabled.
# To enable versioning, run the following command:

gsutil versioning set on gs://$BUCKET_NAME_1

# To verify that versioning was enabled, run the following command:

gsutil versioning get gs://$BUCKET_NAME_1

# Create several versions of the sample file in the bucket
# Check the size of the sample file:

ls -al setup.html

# Open the setup.html file:

nano setup.html

# Delete any 5 lines from setup.html to change the size of the file.

# Press Ctrl+O, ENTER to save the file, and then press Ctrl+X to exit nano.

# Copy the file to the bucket with the -v versioning option:

gsutil cp -v setup.html gs://$BUCKET_NAME_1

# Open the setup.html file:

nano setup.html

# Delete another 5 lines from setup.html to change the size of the file.

# Press Ctrl+O, ENTER to save the file, and then press Ctrl+X to exit nano.

# Copy the file to the bucket with the -v versioning option:

gsutil cp -v setup.html gs://$BUCKET_NAME_1

# List all versions of the file
# To list all versions of the file, run the following command:

gsutil ls -a gs://$BUCKET_NAME_1/setup.html

# Highlight and copy the name of the oldest version of the file (the first listed), referred to as [VERSION_NAME] in the next step.
# Note: make sure to copy the full path of the file, starting with gs://
# Store the version value in the environment variable [VERSION_NAME].

export VERSION_NAME=<Enter VERSION name here>

# Verify it with echo:

echo $VERSION_NAME

# Result (this is example output):

gs://BUCKET_NAME_1/setup.html#1584457872853517
# Download the oldest, original version of the file and verify recovery
# Download the original version of the file:

gsutil cp $VERSION_NAME recovered.txt

# To verify recovery, run the following commands:

ls -al setup.html
ls -al recovered.txt

# Note: you have recovered the original file from the backup version. Notice that the original is bigger than the current version because you deleted lines.
# Task 7. Synchronize a directory to a bucket
# Make a nested directory and sync with a bucket
# Make a nested directory structure so that you can examine what happens when it is recursively copied to a bucket.

# Run the following commands:

mkdir firstlevel
mkdir ./firstlevel/secondlevel
cp setup.html firstlevel
cp setup.html firstlevel/secondlevel

# To sync the firstlevel directory on the VM with your bucket, run the following command:

gsutil rsync -r ./firstlevel gs://$BUCKET_NAME_1/firstlevel

# Examine the results
# In the Cloud Console, on the Navigation menu (Navigation menu icon), click Cloud Storage > Buckets.

# Click [BUCKET_NAME_1]. Notice the subfolders in the bucket.

# Click on /firstlevel and then on /secondlevel.

# Compare what you see in the Cloud Console with the results of the following command:

gsutil ls -r gs://$BUCKET_NAME_1/firstlevel

# Exit Cloud Shell:

exit

# Task 8. Cross-project sharing
# Switch to the second project
# Open a new incognito tab.

# Navigate to console.cloud.google.com to open a Cloud Console.

# Click the project selector dropdown in the title bar.

# Click All, and then click the second project provided for you in the Qwiklabs Connection Details dialog. Remember that the Project ID is a unique name across all Google Cloud projects. The second project ID will be referred to as [PROJECT_ID_2].

# Prepare the bucket
# In the Cloud Console, on the Navigation menu (Navigation menu icon), click Cloud Storage > Buckets.
# Click Create bucket.
# Specify the following, and leave the remaining settings as their defaults:
# Property	Value (type value or select option as specified)
# Name	Enter a globally unique name
# Location type	Multi-region
# Access control	Fine-grained (object-level permission in addition to your bucket-level permissions)
# Note the bucket name. It will be referred to as [BUCKET_NAME_2] in the following steps.

# Click Create.

# Upload a text file to the bucket
# Upload a file to [BUCKET_NAME_2]. Any small example file or text file will do.

# Note the file name (referred to as [FILE_NAME]); you will use it later.

# Create an IAM Service Account
# In the Cloud Console, on the Navigation menu (Navigation menu icon), click IAM & admin > Service accounts.
# Click Create service account.
# On Service account details page, specify the Service account name as cross-project-storage.
# Click Create and Continue.
# On the Service account permissions page, specify the role as Cloud Storage > Storage Object Viewer.
# Click Continue and then Done.
# Click the cross-project-storage service account to add the JSON key.
# In Keys tab, click Add Key dropdown and select Create new key.
# Select JSON as the key type and click Create. A JSON key file will be downloaded. You will need to find this key file and upload it in into the VM in a later step.
# Click Close.
# On your hard drive, rename the JSON key file to credentials.json.
# In the upper pane, switch back to [PROJECT_ID_1].
# Click Check my progress to verify the objective.
# Create the resources in the second project

# Create a VM
# On the Navigation menu (Navigation menu icon), click Compute Engine > VM instances.
# Click Create Instance.
# Specify the following, and leave the remaining settings as their defaults:
# Property	Value (type value or select option as specified)
# Name	crossproject
# Region	europe-west1
# Zone	europe-west1-d
# Series	N1
# Machine type	n1-standard-1
# Boot disk	Debian GNU/Linux 10 (buster)
# Click Create.

# SSH to the VM
# For crossproject, click SSH to launch a terminal and connect.
# Note: if the message appears like Connection via Cloud Identity-Aware Proxy Failed then click Connect without Identity-Aware Proxy.

# Store [BUCKET_NAME_2] in an environment variable:

export BUCKET_NAME_2=<enter bucket name 2 here>

# Verify it with echo:

echo $BUCKET_NAME_2

# Store [FILE_NAME] in an environment variable:

export FILE_NAME=<enter FILE_NAME here>

# Verify it with echo:

echo $FILE_NAME

# List the files in [PROJECT_ID_2]:

gsutil ls gs://$BUCKET_NAME_2/

# Result (this is example output):

# AccessDeniedException: 403 404513585876-compute@developer.gserviceaccount.com does not have storage.objects.list access to the Google Cloud Storage bucket.
# Authorize the VM
# To upload credentials.json through the SSH VM terminal, click on the up arrow icon (upload icon) in the upper-right corner, and then click Upload file.

# Select credentials.json and upload it.

# Click Close in the File Transfer window.

# Verify that the JSON file has been uploaded to the VM:

ls

# Result (this is example output):

credentials.json
Enter the following command in the terminal to authorize the VM to use the Google Cloud API:

gcloud auth activate-service-account --key-file credentials.json

# Note: the image you are using has the Google Cloud SDK pre-installed; therefore, you don't need to initialize the Google Cloud SDK.

# If you are attempting this lab in a different environment, make sure you have followed these procedures from the Install the gcloud CLI guide regarding installing the Google Cloud SDK.
# Verify access
# Retry this command:

gsutil ls gs://$BUCKET_NAME_2/

# Retry this command:

gsutil cat gs://$BUCKET_NAME_2/$FILE_NAME

# Try to copy the credentials file to the bucket:

gsutil cp credentials.json gs://$BUCKET_NAME_2/

# Result (this is example output):

Copying file://credentials.json [Content-Type=application/json]...
AccessDeniedException: 403 cross-project-storage@qwiklabs-gcp-02-c638e3daa975.iam.gserviceaccount.com does not have storage.objects.create access to the Google Cloud Storage object.
Modify role
In the upper pane, switch back to [PROJECT_ID_2].
In the Cloud Console, on the Navigation menu (Navigation menu icon), click IAM & admin > IAM.
Click the pencil icon for the cross-project-storage service account (You might have to scroll to the right to see this icon).
Click on the Storage Object Viewer role, and then click Cloud Storage > Storage Object Admin.
Click Save. If you don't click Save, the change will not be made.
Click Check my progress to verify the objective.
Create and verify the resources in the first project

Verify changed access
Return to the SSH terminal for crossproject.

Copy the credentials file to the bucket:

gsutil cp credentials.json gs://$BUCKET_NAME_2/
Copied!
Result (this is example output):

Copying file://credentials.json [Content-Type=application/json]...
- [1 files][  2.3 KiB/  2.3 KiB]
Operation completed over 1 objects/2.3 KiB.
Note: in this example the VM in PROJECT_ID_1 can now upload files to Cloud Storage in a bucket that was created in another project.

Note that the project where the bucket was created is the billing project for this activity. That means if the VM uploads a ton of files, it will not be billed to PROJECT_ID_1, but instead to PROJECT_ID_2.

Task 9. Review
In this lab you learned to create and work with buckets and objects, and you learned about the following features for Cloud Storage:

CSEK: Customer-supplied encryption key
Use your own encryption keys
Rotate keys
ACL: Access control list
Set an ACL for private, and modify to public
Lifecycle management
Set policy to delete objects after 31 days
Versioning
Create a version and restore a previous version
Directory synchronization
Recursively synchronize a VM directory with a bucket
Cross-project resource sharing using IAM
Use IAM to enable access to resources across projects
End your lab