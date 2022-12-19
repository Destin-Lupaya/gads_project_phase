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
