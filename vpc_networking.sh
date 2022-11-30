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

gcloud compute instances create mynet-us-vm --project=qwiklabs-gcp-01-ebb257e17d6d --zone=us-east4-b
 --machine-type=e2-micro --network-interface=network-tier=PREMIUM,subnet=mynetwork --metadata=enable-oslogin=true
  --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=1028655937043-compute@developer.gserviceaccount.com
   --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,
   https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,
   https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append
    --create-disk=auto-delete=yes,boot=yes,device-name=mynet-us-vm,image=projects/debian-cloud/global/images/debian-11-bullseye-v20221102,
    mode=rw,size=10,type=projects/qwiklabs-gcp-01-ebb257e17d6d/zones/us-east4-b/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm
     --shielded-integrity-monitoring --reservation-affinity=any


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
