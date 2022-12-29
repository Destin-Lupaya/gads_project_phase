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

# Task 2. Prepare the data disk
# Create a directory and format and mount the disk
# The disk is attached to the instance, but it is not yet mounted or formatted.

# For mc-server, click SSH to open a terminal and connect.

# To create a directory that serves as the mount point for the data disk, run the following command:

sudo mkdir -p /home/minecraft

# To format the disk, run the following command:

sudo mkfs.ext4 -F -E lazy_itable_init=0,\
lazy_journal_init=0,discard \
/dev/disk/by-id/google-minecraft-disk

# To mount the disk, run the following command:
sudo mount -o discard,defaults /dev/disk/by-id/google-minecraft-disk /home/minecraft

# Task 3. Install and run the application
# The Minecraft server runs on top of the Java Virtual Machine (JVM), so it requires the Java Runtime Environment (JRE) to run. Because the server doesn't need a graphical user interface, you use the headless version of the JRE. This reduces the JRE's resource usage on the machine, which helps ensure that the Minecraft server has enough room to expand its own resource usage if needed.

# Install the Java Runtime Environment (JRE) and the Minecraft server
# In the SSH terminal for mc-server, to update the Debian repositories on the VM, run the following command:

sudo apt-get update

# After the repositories are updated, to install the headless JRE, run the following command:

sudo apt-get install -y default-jre-headless

# To navigate to the directory where the persistent disk is mounted, run the following command:

cd /home/minecraft

# To install wget, run the following command:

sudo apt-get install wget

# If prompted to continue, type Y.

# To download the current Minecraft server JAR file (1.11.2 JAR), run the following command:

sudo wget https://launcher.mojang.com/v1/objects/d0d0fe2b1dc6ab4c65554cb734270872b72dadd6/server.jar

# Initialize the Minecraft server
# To initialize the Minecraft server, run the following command:
sudo java -Xmx1024M -Xms1024M -jar server.jar nogui

# To see the files that were created in the first initialization of the Minecraft server, run the following command:
sudo ls -l

# Note: You could edit the server.properties file to change the default behavior of the Minecraft server.
# To edit the EULA, run the following command:

sudo nano eula.txt

# Change the last line of the file from eula=false to eula=true.
# Press Ctrl+O, ENTER to save the file and then press Ctrl+X to exit nano.
# Note: Don't try to restart the Minecraft server yet. You use a different technique in the next procedure.
