#!/bin/bash

#rachelkabuyre@gmail.com

#Create a VPC network and firewall rules
gcloud compute networks create privatenet --project=qwiklabs-gcp-03-3d39a65bb75f --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional


gcloud compute networks subnets create privatenet-us --project=qwiklabs-gcp-03-3d39a65bb75f --range=10.130.0.0/20 --stack-type=IPV4_ONLY --network=privatenet --region=us-central1

#

gcloud compute --project=qwiklabs-gcp-03-3d39a65bb75f firewall-rules create privatenet-allow-ssh --direction=INGRESS --priority=1000 --network=privatenet --action=ALLOW --rules=tcp:22 --source-ranges=35.235.240.0/20

