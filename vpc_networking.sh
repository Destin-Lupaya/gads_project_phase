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