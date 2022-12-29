#!/bin/bash

#rachelkabuyre@gmail.com

# Task 1. Create the VM
# Define a VM using advanced options
# In the Cloud Console, on the Navigation menu (Navigation menu), click Compute Engine > VM instances.
# Click Create Instance.
# Specify the following and leave the remaining settings as their defaults:

# Property	Value (type value or select option as specified)
# Name	mc-server
# Region	us-central1
# Zone	us-central1-a
# Boot disk	Debian GNU/Linux 11 (bullseye)
# Identity and API access > Access scopes	Set access for each API
# Storage	Read Write
# Click Management, security, disks, networking, sole tenancy.
# Click Disks. You will add a disk to be used for game storage.
# Click Add new disk.
# Specify the following and leave the remaining settings as their defaults:
# Property	Value (type value or select option as specified)
# Name	minecraft-disk
# Disk type	SSD Persistent Disk
# Disk Source type	None (blank disk)
# Size (GB)	50
# Encryption	Google-managed encryption key
# Click Save. This creates the disk and automatically attaches it to the VM when the VM is created.
# Click Networking.
# Specify the following and leave the remaining settings as their defaults:
# Property	Value (type value or select option as specified)
# Network tags	minecraft-server
# Network interfaces	Click default to edit the interface
# External IP	Create IP Address
# Name	mc-server-ip
# Click Reserve.

# Click Done.

# Click Create.
#Equivalent commandline
gcloud compute instances create mc-server --project=qwiklabs-gcp-03-679fd1adc97b --zone=us-central1-a --machine-type=e2-medium --network-interface=address=35.239.150.13,network-tier=PREMIUM,subnet=default --metadata=enable-oslogin=true --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=14958519660-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/trace.append,https://www.googleapis.com/auth/devstorage.read_write --tags=minecraft-server --create-disk=auto-delete=yes,boot=yes,device-name=mc-server,image=projects/debian-cloud/global/images/debian-11-bullseye-v20221206,mode=rw,size=10,type=projects/qwiklabs-gcp-03-679fd1adc97b/zones/us-central1-a/diskTypes/pd-balanced --create-disk=device-name=minecraft-disk,mode=rw,name=minecraft-disk,size=50,type=projects/qwiklabs-gcp-03-679fd1adc97b/zones/us-central1-a/diskTypes/pd-ssd --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

#Equivalent REST
POST https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-03-679fd1adc97b/zones/us-central1-a/instances
{
  "canIpForward": false,
  "confidentialInstanceConfig": {
    "enableConfidentialCompute": false
  },
  "deletionProtection": false,
  "description": "",
  "disks": [
    {
      "autoDelete": true,
      "boot": true,
      "deviceName": "mc-server",
      "initializeParams": {
        "diskSizeGb": "10",
        "diskType": "projects/qwiklabs-gcp-03-679fd1adc97b/zones/us-central1-a/diskTypes/pd-balanced",
        "labels": {},
        "sourceImage": "projects/debian-cloud/global/images/debian-11-bullseye-v20221206"
      },
      "mode": "READ_WRITE",
      "type": "PERSISTENT"
    },
    {
      "autoDelete": false,
      "deviceName": "minecraft-disk",
      "diskEncryptionKey": {},
      "initializeParams": {
        "description": "",
        "diskName": "minecraft-disk",
        "diskSizeGb": "50",
        "diskType": "projects/qwiklabs-gcp-03-679fd1adc97b/zones/us-central1-a/diskTypes/pd-ssd"
      },
      "mode": "READ_WRITE",
      "type": "PERSISTENT"
    }
  ],
  "displayDevice": {
    "enableDisplay": false
  },
  "guestAccelerators": [],
  "keyRevocationActionType": "NONE",
  "labels": {},
  "machineType": "projects/qwiklabs-gcp-03-679fd1adc97b/zones/us-central1-a/machineTypes/e2-medium",
  "metadata": {
    "items": [
      {
        "key": "enable-oslogin",
        "value": "true"
      }
    ]
  },
  "name": "mc-server",
  "networkInterfaces": [
    {
      "accessConfigs": [
        {
          "name": "External NAT",
          "natIP": "35.239.150.13",
          "networkTier": "PREMIUM"
        }
      ],
      "stackType": "IPV4_ONLY",
      "subnetwork": "projects/qwiklabs-gcp-03-679fd1adc97b/regions/us-central1/subnetworks/default"
    }
  ],
  "params": {
    "resourceManagerTags": {}
  },
  "reservationAffinity": {
    "consumeReservationType": "ANY_RESERVATION"
  },
  "scheduling": {
    "automaticRestart": true,
    "onHostMaintenance": "MIGRATE",
    "provisioningModel": "STANDARD"
  },
  "serviceAccounts": [
    {
      "email": "14958519660-compute@developer.gserviceaccount.com",
      "scopes": [
        "https://www.googleapis.com/auth/servicecontrol",
        "https://www.googleapis.com/auth/service.management.readonly",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring.write",
        "https://www.googleapis.com/auth/trace.append",
        "https://www.googleapis.com/auth/devstorage.read_write"
      ]
    }
  ],
  "shieldedInstanceConfig": {
    "enableIntegrityMonitoring": true,
    "enableSecureBoot": false,
    "enableVtpm": true
  },
  "tags": {
    "items": [
      "minecraft-server"
    ]
  },
  "zone": "projects/qwiklabs-gcp-03-679fd1adc97b/zones/us-central1-a"
}
