#!/bin/bash

#rachelkabuyre@gmail.com

gcloud compute networks subnets list --network default

gcloud compute routes list --filter='network=default AND priority=1000'

gcloud compute firewall-rules list

gcloud compute firewall-rules delete [NAME]

gcloud compute networks delete default

gcloud compute networks create local

gcloud compute firewall-rules create local-allow-ssh --network local --allow=tcp:22 --source

gcloud compute firewall-rules create local-allow-rdp --network local --allow=tcp:3389 --source

gcloud compute firewall-rules create local-allow-https --network local --allow=tcp:443 --source

gcloud compute firewall-rules create local-allow-http --network local --allow=tcp:80 --source

#Create a VM instance in us-east4

gcloud compute instances create mynet-us-vm --project=qwiklabs-gcp-01-ebb257e17d6d --zone=us-east4-b --machine-type=e2-micro --network-interface=network-tier=PREMIUM,subnet=mynetwork --metadata=enable-oslogin=true  --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=1028655937043-compute@developer.gserviceaccount.com   --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,   https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,   https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append    --create-disk=auto-delete=yes,boot=yes,device-name=mynet-us-vm,image=projects/debian-cloud/global/images/debian-11-bullseye-v20221102,    mode=rw,size=10,type=projects/qwiklabs-gcp-01-ebb257e17d6d/zones/us-east4-b/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm    --shielded-integrity-monitoring --reservation-affinity=any


#Create a VM instance in europe-west1

     gcloud compute instances create mynet-eu-vm --project=qwiklabs-gcp-01-ebb257e17d6d --zone=europe-west1-c --machine-type=e2-micro --network-interface=network-tier=PREMIUM,subnet=mynetwork --metadata=enable-oslogin=true --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=1028655937043-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --create-disk=auto-delete=yes,boot=yes,device-name=mynet-eu-vm,image=projects/debian-cloud/global/images/debian-11-bullseye-v20221102,mode=rw,size=10,type=projects/qwiklabs-gcp-01-ebb257e17d6d/zones/us-east4-b/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any


     #Verify connectivity for the VM instances
     ping -c 3 10.132.0.2
     ping -c 3 34.79.19.164

Convert the network to a custom mode network

{
  "autoCreateSubnetworks": true,
  "creationTimestamp": "2022-11-30T09:17:19.055-08:00",
  "description": "",
  "id": "7728105607154773744",
  "kind": "compute#network",
  "mtu": 1460,
  "name": "mynetwork",
  "networkFirewallPolicyEnforcementOrder": "AFTER_CLASSIC_FIREWALL",
  "routingConfig": {
    "routingMode": "REGIONAL"
  },
  "selfLink": "projects/qwiklabs-gcp-01-ebb257e17d6d/global/networks/mynetwork",
  "selfLinkWithId": "https://www.googleapis.com/compute/beta/projects/qwiklabs-gcp-01-ebb257e17d6d/global/networks/7728105607154773744",
  "subnetworks": [
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/me-west1/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/europe-west4/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/asia-east1/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/europe-north1/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/us-west3/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/us-east5/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/us-west4/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/us-east1/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/us-east4/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/southamerica-west1/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/europe-west2/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/europe-west1/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/asia-northeast1/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/us-south1/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/us-west2/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/us-central1/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/asia-south1/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/us-west1/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/europe-west3/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/australia-southeast1/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/asia-southeast1/subnetworks/mynetwork",
    "projects/qwiklabs-gcp-01-ebb257e17d6d/regions/europe-central2/subnetworks/mynetwork"
  ]
}


#Create the managementnet network
gcloud compute networks create managementnet --project=qwiklabs-gcp-01-ebb257e17d6d --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional

gcloud compute networks subnets create managementsubnet-us --project=qwiklabs-gcp-01-ebb257e17d6d --range=10.240.0.0/20 --stack-type=IPV4_ONLY --network=managementnet --region=us-east4

#Create the privatenet network Create the privatenet network using the gcloud command line. In the Cloud Console, click Activate Cloud Shell
gcloud compute networks create privatenet --subnet-mode=custom

gcloud compute networks subnets create privatesubnet-us --network=privatenet --region=us-east4 --range=172.16.0.0/24

gcloud compute networks subnets create privatesubnet-eu --network=privatenet --region=europe-west1 --range=172.20.0.0/20

gcloud compute networks list

gcloud compute networks subnets list --sort-by=NETWORK

#Create the firewall rules for managementnet Create firewall rules to allow SSH, ICMP, and RDP ingress traffic to VM instances on the managementnet network.

gcloud compute --project=qwiklabs-gcp-01-ebb257e17d6d firewall-rules create managementnet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=managementnet --action=ALLOW --rules=tcp:22,tcp:3389,icmp --source-ranges=0.0.0.0/0

#Create the firewall rules for privatenet Create the firewall rules for privatenet network using the gcloud command line.

gcloud compute firewall-rules create privatenet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=privatenet --action=ALLOW --rules=icmp,tcp:22,tcp:3389 --source-ranges=0.0.0.0/0

gcloud compute firewall-rules list --sort-by=NETWORK

#Create the managementnet-us-vm instance
gcloud compute instances create managementnet-us-vm --project=qwiklabs-gcp-01-ebb257e17d6d --zone=us-east4-b --machine-type=e2-micro --network-interface=network-tier=PREMIUM,subnet=managementsubnet-us --metadata=enable-oslogin=true --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=1028655937043-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --create-disk=auto-delete=yes,boot=yes,device-name=managementnet-us-vm,image=projects/debian-cloud/global/images/debian-11-bullseye-v20221102,mode=rw,size=10,type=projects/qwiklabs-gcp-01-ebb257e17d6d/zones/us-east4-b/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

#Create the privatenet-us-vm instance Create the privatenet-us-vm instance using the gcloud command line. Return to Cloud Shell. If necessary, click Activate Cloud Shell

gcloud compute instances create privatenet-us-vm --zone=us-east4-b --machine-type=e2-micro --subnet=privatesubnet-us --image-family=debian-11 --image-project=debian-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=privatenet-us-vm

gcloud compute instances list --sort-by=ZONE

#Task 4. Explore the connectivity across networks

ping -c 3 34.79.19.164
ping -c 3 10.132.0.2

ping -c 3 10.132.0.2

ping -c 3 10.132.0.2

ping -c 3 10.132.0.2
