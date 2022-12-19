#!/bin/bash

#rachelkabuyre@gmail.com

#Create a VPC network and firewall rules
gcloud compute networks create privatenet --project=qwiklabs-gcp-03-3d39a65bb75f --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional


gcloud compute networks subnets create privatenet-us --project=qwiklabs-gcp-03-3d39a65bb75f --range=10.130.0.0/20 --stack-type=IPV4_ONLY --network=privatenet --region=us-central1

#

gcloud compute --project=qwiklabs-gcp-03-3d39a65bb75f firewall-rules create privatenet-allow-ssh --direction=INGRESS --priority=1000 --network=privatenet --action=ALLOW --rules=tcp:22 --source-ranges=35.235.240.0/20

#Create the VM instance with no public IP address
gcloud compute instances create vm-internal --project=qwiklabs-gcp-03-3d39a65bb75f --zone=us-central1-c --machine-type=n1-standard-1 --network-interface=subnet=privatenet-us,no-address --metadata=enable-oslogin=true --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=850563189237-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --create-disk=auto-delete=yes,boot=yes,device-name=vm-internal,image=projects/debian-cloud/global/images/debian-11-bullseye-v20221206,mode=rw,size=10,type=projects/qwiklabs-gcp-03-3d39a65bb75f/zones/us-central1-a/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

#SSH to vm-internal to test the IAP tunnel
#In the Cloud Console, click Activate Cloud Shell (Cloud Shell). If prompted, click Continue. To connect to vm-internal, run the following command:

gcloud compute ssh vm-internal --zone us-central1-c --tunnel-through-iap

ping -c 2 www.google.com

#Task 2. Enable Private Google Access
#Create a Cloud Storage bucket Create a Cloud Storage bucket to test access to Google APIs and services. In the Cloud Console, on the Navigation menu (Navigation menu icon), click Cloud Storage > Buckets. Click Create.
#In the Cloud Console, on the Navigation menu (Navigation menu icon), click Cloud Storage > Buckets. Click Create.


export MY_BUCKET=<enter your bucket name here>


echo $MY_BUCKET

#Copy an image file into your bucket Copy an image from a public Cloud Storage bucket to your own bucket. In Cloud Shell, run the following command:
gsutil cp gs://cloud-training/gcpnet/private/access.svg gs://$MY_BUCKET

#In Cloud Shell, to try to copy the image from your bucket, run the following command:

gsutil cp gs://$MY_BUCKET/*.svg .

#This should work because Cloud Shell has an external IP address! To connect to vm-internal, run the following command:

gcloud compute ssh vm-internal --zone us-central1-c --tunnel-through-iap

export MY_BUCKET=<enter your bucket name here>

echo $MY_BUCKET

#Try to copy the image to vm-internal, run the following command:
gsutil cp gs://$MY_BUCKET/*.svg .

#Enable Private Google Access
#Private Google Access is enabled at the subnet level. When it is enabled, instances in the subnet that only have private IP addresses can send traffic to Google APIs and services through the default route (0.0.0.0/0) with a next hop to the default internet gateway.

# In the Cloud Console, on the Navigation menu (Navigation menu icon), click VPC network > VPC networks.
# Click privatenet to open the network.
# Click privatenet-us to open the subnet.
# Click Edit.
# For Private Google access, select On.
# Click Save.


#EQUIVALENT REST

{
  "gatewayAddress": "10.130.0.1",
  "id": "621945485637003068",
  "ipCidrRange": "10.130.0.0/20",
  "name": "privatenet-us",
  "networkUrl": "projects/qwiklabs-gcp-03-3d39a65bb75f/global/networks/privatenet",
  "regionUrl": "projects/qwiklabs-gcp-03-3d39a65bb75f/regions/us-central1",
  "selfLink": "projects/qwiklabs-gcp-03-3d39a65bb75f/regions/us-central1/subnetworks/privatenet-us",
  "stackType": "IPV4_ONLY"
}

#Note: Enabling Private Google Access is as simple as selecting On within the subnet!
# In Cloud Shell for vm-internal, to try to copy the image to vm-internal, run the following command, replacing <your_bucket_name> with the name of your bucket:

# gsutil cp gs://<your_bucket_name>/*.svg .

# This should work because vm-internal's subnet has Private Google Access enabled!

# To return to your Cloud Shell instance, run the following command:

exit

#Task 3. Configure a Cloud NAT gateway

# Although vm-internal can now access certain Google APIs and services without an external IP address, the instance cannot access the internet for updates and patches. Configure a Cloud NAT gateway, which allows vm-internal to reach the internet.

# Try to update the VM instances
# In Cloud Shell, to try to re-synchronize the package index, run the following:

sudo apt-get update


# this should work because Cloud Shell has an external IP address!

# To connect to vm-internal, run the following command:

gcloud compute ssh vm-internal --zone us-central1-c --tunnel-through-iap

# If prompted, type Y to continue.

# To try to re-synchronize the package index of vm-internal, run the following command:

sudo apt-get update

# This should only work for Google Cloud packages because vm-internal only has access to Google APIs and services!

# Press Ctrl+C to stop the request.

# Configure a Cloud NAT gateway


# Cloud NAT is a regional resource. You can configure it to allow traffic from all ranges of all subnets in a region, from specific subnets in the region only, or from specific primary and secondary CIDR ranges only.

# In the Cloud Console, on the Navigation menu (Navigation menu icon), click Network services > Cloud NAT.

# Click Get started to configure a NAT gateway.

# Specify the following:

# Specify the following:

# Property	Value (type value or select option as specified)
# Gateway name	nat-config
# Network	privatenet
# Region	us-central1
# For Cloud Router, select Create new router.

# For Name, type nat-router

# Click Create.
# Note: The NAT mapping section allows you to choose the subnets to map to the NAT gateway. You can also manually assign static IP addresses that should be used when performing NAT. Do not change the NAT mapping configuration in this lab.
# Click Create.
# Wait for the gateway's status to change to Running.

# Verify the Cloud NAT gateway

# It may take up to 3 minutes for the NAT configuration to propagate to the VM, so wait at least a minute before trying to access the internet again.

# In Cloud Shell for vm-internal, to try to re-synchronize the package index of vm-internal, run the following command:

sudo apt-get update
exit

#Task 4. Configure and view logs with Cloud NAT Logging

# Cloud NAT logging allows you to log NAT connections and errors. When Cloud NAT logging is enabled, one log entry can be generated for each of the following scenarios:

# When a network connection using NAT is created.
# When a packet is dropped because no port was available for NAT.
# You can opt to log both kinds of events, or just one or the other. Created logs are sent to Cloud Logging.

# Enabling logging
# If logging is enabled, all collected logs are sent to Cloud Logging by default. You can filter these so that only certain logs are sent.

# You can also specify these values when you create a NAT gateway or by editing one after it has been created. The following directions show how to enable logging for an existing NAT gateway.

# In the GCP Console, on the Navigation menu (Navigation menu icon), click Network services > Cloud NAT.

# Click on the nat-config gateway and then click Edit.

# Click the Advanced configurations dropdown to open that section.

# Under Stackdriver logging, select Translation and errors and then click Save.


# NAT logging in Cloud Operations

# Now that you have set up Cloud NAT logging for the nat-config gateway, let's find out where we can view our logs.

# Click on nat-config to expose its details. Then click on the Logs tab. Then click the link to Cloud Logging.

# This will open a new tab with Operations Logging.

# You will see that there aren't any logs yet—that's because we just enabled this feature for the gateway. Keep this tab open and return to your other GCP Console tab.

# Generating logs
# As a reminder, Cloud NAT logs are generated for the following sequences:

# When a network connection using NAT is created.
# When a packet is dropped because no port was available for NAT.
# Let's connect the host to the internal VM again to see if any logs are generated.

# In Cloud Shell for vm-internal, to try to re-synchronize the package index of vm-internal, run the following command:

gcloud compute ssh vm-internal --zone us-central1-c --tunnel-through-iap

# If prompted, type Y to continue.

# Try to re-synchronize the package index of vm-internal by running the following:

sudo apt-get update

exit


