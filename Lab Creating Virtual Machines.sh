#!/bin/bash

#rachelkabuyre@gmail.com

# Task 1. Create a utility virtual machine
# Create a VM
# In the Cloud Console, on the Navigation menu (Navigation menu icon), click Compute Engine > VM instances.
# Click Create Instance.
# For Name, type a name for your instance. Hover over the question mark icon for advice about what constitutes a properly formed name.
# For Region and Zone select us-central1 and us-central1-c respectively.
# For Machine configuration, select Series as N1.
# For Machine type, examine the options.
# Note: Notice that the menu lists the number of vCPUs, the amount of memory, and a symbolic name such as n1-standard-1. The symbolic name is the parameter you would use to select the machine type if you were creating a VM using the gcloud command. Notice to the right of the zone and machine type that there is a per-month estimated cost.
# Click Details to the right of the Machine type list to see the breakdown of estimated costs.
# For Machine type, click n1-standard-4 (4 vCPUs, 15 GB memory). How did the cost change?
# For Machine type, click n1-standard-1 (1 vCPUs, 3.75 GB memory).
# For Boot disk, click Change.
# Click Version and select Debian GNU/Linux 10 (buster).
# Click Select.
# Click Networking, disks, security, management, sole tenancy.
# Click Networking.
# For Network interfaces, click the dropdown icon.
# Select None for External IP.
# Click Done.
# Leave the remaining settings as their defaults, and click Create. Wait until the new VM is created.
# Note: External IP addresses that don’t fall under the Free Tier of the Google Cloud Free Program will incur a small cost. Learn more about the pricing in the External IP address pricing section of the Virtual Private Cloud Guide.

#Equivalent command line
gcloud compute instances create kabote-instance-1 --project=qwiklabs-gcp-01-b104182dca0a --zone=us-central1-c --machine-type=n1-standard-1 --network-interface=subnet=default,no-address --metadata=enable-oslogin=true --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=43938466557-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --create-disk=auto-delete=yes,boot=yes,device-name=kabote-instance-1,image=projects/debian-cloud/global/images/debian-10-buster-v20221206,mode=rw,size=10,type=projects/qwiklabs-gcp-01-b104182dca0a/zones/us-central1-c/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

#Equivalent command Line

POST https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-01-b104182dca0a/zones/us-central1-c/instances
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
      "deviceName": "kabote-instance-1",
      "diskEncryptionKey": {},
      "initializeParams": {
        "diskSizeGb": "10",
        "diskType": "projects/qwiklabs-gcp-01-b104182dca0a/zones/us-central1-c/diskTypes/pd-balanced",
        "labels": {},
        "sourceImage": "projects/debian-cloud/global/images/debian-10-buster-v20221206"
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
  "machineType": "projects/qwiklabs-gcp-01-b104182dca0a/zones/us-central1-c/machineTypes/n1-standard-1",
  "metadata": {
    "items": [
      {
        "key": "enable-oslogin",
        "value": "true"
      }
    ]
  },
  "name": "kabote-instance-1",
  "networkInterfaces": [
    {
      "stackType": "IPV4_ONLY",
      "subnetwork": "projects/qwiklabs-gcp-01-b104182dca0a/regions/us-central1/subnetworks/default"
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
      "email": "43938466557-compute@developer.gserviceaccount.com",
      "scopes": [
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring.write",
        "https://www.googleapis.com/auth/servicecontrol",
        "https://www.googleapis.com/auth/service.management.readonly",
        "https://www.googleapis.com/auth/trace.append"
      ]
    }
  ],
  "shieldedInstanceConfig": {
    "enableIntegrityMonitoring": true,
    "enableSecureBoot": false,
    "enableVtpm": true
  },
  "tags": {
    "items": []
  },
  "zone": "projects/qwiklabs-gcp-01-b104182dca0a/zones/us-central1-c"
}


# Explore the VM details
# On the VM instances page, click on the name of your VM.
# Locate CPU platform and note the value. Click Edit.
# Note: Notice that you cannot change the machine type, the CPU platform, or the zone.

# You can add network tags and allow specific network traffic from the internet through firewalls. Some properties of a VM are integral to the VM, are established when the VM is created, and cannot be changed. Other properties can be edited.

# You can add additional disks and you can also determine whether the boot disk is deleted when the instance is deleted.

# Normally the boot disk defaults to being deleted automatically when the instance is deleted. But sometimes you will want to override this behavior. This feature is very important because you cannot create an image from a boot disk when it is attached to a running instance.

# So you would need to disable Delete boot disk when instance is deleted to enable creating a system image from the boot disk.

# Examine Availability policies.
# Note: You cannot convert a non-preemptible instance into a preemptible one. This choice must be made at VM creation. A preemptible instance can be interrupted at any time and is available at a lower cost.

# If a VM is stopped for any reason, (for example an outage or a hardware failure) the automatic restart feature will start it back up. Is this the behavior you want? Are your applications idempotent (written to handle a second startup properly)?

# During host maintenance, the VM is set for live migration. However, you can have the VM terminated instead of migrated.

# If you make changes, they can sometimes take several minutes to be implemented, especially if they involve networking changes like adding firewalls or changing the external IP.

# Click Cancel.

# Explore the VM logs
# On the VM instance details page for your VM, click Cloud Logging.
# Note: Notice that you have now navigated to the Cloud Logging page. This is a structured log view. At the top you can filter by using the pull-down menus, and there is a search box for searching based on labels or text.
# Click the small triangle to the left of one of the lines to see the kind of information it contains.
# Click Check my progress to verify the objective.

#Task 2. Create a Windows virtual machine
# Create a VM
# On the Navigation menu (Navigation menu icon), click Compute Engine > VM instances.
# Click Create instance.
# Specify the following, and leave the remaining settings as their defaults:
# Property	Value (type value or select option as specified)
# Name	Type a name for your VM
# Region	europe-west1
# Zone	europe-west1-c
# Series	N1
# Machine type	n1-standard-2(2 vCPUs, 7.5 GB memory)
# Boot disk	Change
# Public Images > Operating system	Windows Server
# Version	Windows Server 2016 Datacenter Core
# Boot disk type	SSD persistent disk
# Size (GB)	100
# Click Select.
# For Firewall, enable Allow HTTP traffic and Allow HTTPS traffic.
# Click Create.
# Note: When the VM is running, notice that the connection option in the far right column is RDP, not SSH. RDP is the Remote Desktop Protocol. You would need the RDP client installed on your local machine to connect to the Windows desktop.
# Note: Installing an RDP client on your local machine is outside the scope of this lab and of the class. For this reason, you will not be connecting to the Windows VM during this lab. However, you will step through the usual procedures up to the point of requiring the RDP client. Instructions for connecting to Windows VMs are in the Connecting to Windows VMs Guide.
# Set the password for the VM
# Click on the name of your Windows VM to access the VM instance details.
# You don't have a valid password for this Windows VM: you cannot log in to the Windows VM without a password. Click Set Windows password.
# Click Set.
# Copy the provided password, and click CLOSE.
# Note: You will not connect to the Windows VM during this lab. However, the process would look something like the following (depending on the RDP client you installed). The RDP client shown can be installed for Chrome from the Chrome webstore. On the VM instances page, you would click RDP for your Windows VM and connect with the password copied earlier.

#Equivalent Commandeline

gcloud compute instances create lupaya-instance-1 --project=qwiklabs-gcp-01-b104182dca0a --zone=europe-west1-c --machine-type=n1-standard-2 --network-interface=network-tier=PREMIUM,subnet=default --metadata=enable-oslogin=true --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=43938466557-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --tags=http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=lupaya-instance-1,image=projects/windows-cloud/global/images/windows-server-2016-dc-core-v20221214,mode=rw,size=100,type=projects/qwiklabs-gcp-01-b104182dca0a/zones/europe-west1-c/diskTypes/pd-ssd --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

#Equivalent REST

POST https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-01-b104182dca0a/zones/europe-west1-c/instances
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
      "deviceName": "lupaya-instance-1",
      "diskEncryptionKey": {},
      "initializeParams": {
        "diskSizeGb": "100",
        "diskType": "projects/qwiklabs-gcp-01-b104182dca0a/zones/europe-west1-c/diskTypes/pd-ssd",
        "labels": {},
        "sourceImage": "projects/windows-cloud/global/images/windows-server-2016-dc-core-v20221214"
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
  "machineType": "projects/qwiklabs-gcp-01-b104182dca0a/zones/europe-west1-c/machineTypes/n1-standard-2",
  "metadata": {
    "items": [
      {
        "key": "enable-oslogin",
        "value": "true"
      }
    ]
  },
  "name": "lupaya-instance-1",
  "networkInterfaces": [
    {
      "accessConfigs": [
        {
          "name": "External NAT",
          "networkTier": "PREMIUM"
        }
      ],
      "stackType": "IPV4_ONLY",
      "subnetwork": "projects/qwiklabs-gcp-01-b104182dca0a/regions/europe-west1/subnetworks/default"
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
      "email": "43938466557-compute@developer.gserviceaccount.com",
      "scopes": [
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring.write",
        "https://www.googleapis.com/auth/servicecontrol",
        "https://www.googleapis.com/auth/service.management.readonly",
        "https://www.googleapis.com/auth/trace.append"
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
      "http-server",
      "https-server"
    ]
  },
  "zone": "projects/qwiklabs-gcp-01-b104182dca0a/zones/europe-west1-c"
}

#student_01_ff39997ea
#3u(WhxC%a~;6&1.

#Task 3. Create a custom virtual machine
# Create a VM
# On the Navigation menu (Navigation menu icon), click Compute Engine > VM instances.
# Click Create instance.
# Specify the following, and leave the remaining settings as their defaults:
# Property	Value (type value or select option as specified)
# Name	Type a name for your VM
# Region	us-central1
# Zone	us-central1-a
# Series	E2
# Machine type	Custom
# Cores	2 vCPU
# Memory	4 GB
# Boot disk	Debian GNU/Linux 10 (buster)
# Click Create.

# Connect via SSH to your custom VM
# For the custom VM you just created, click SSH.

# To see information about unused and used memory and swap space on your custom VM, run the following command:
#Equivalent commandline
gcloud compute instances create destin-instance-1 --project=qwiklabs-gcp-01-b104182dca0a --zone=us-central1-a --machine-type=e2-custom-2-4096 --network-interface=network-tier=PREMIUM,subnet=default --metadata=enable-oslogin=true --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=43938466557-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --create-disk=auto-delete=yes,boot=yes,device-name=destin-instance-1,image=projects/debian-cloud/global/images/debian-10-buster-v20221206,mode=rw,size=10,type=projects/qwiklabs-gcp-01-b104182dca0a/zones/us-central1-a/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

#Equivalent Rest
POST https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-01-b104182dca0a/zones/us-central1-a/instances
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
      "deviceName": "destin-instance-1",
      "diskEncryptionKey": {},
      "initializeParams": {
        "diskSizeGb": "10",
        "diskType": "projects/qwiklabs-gcp-01-b104182dca0a/zones/us-central1-a/diskTypes/pd-balanced",
        "labels": {},
        "sourceImage": "projects/debian-cloud/global/images/debian-10-buster-v20221206"
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
  "machineType": "projects/qwiklabs-gcp-01-b104182dca0a/zones/us-central1-a/machineTypes/e2-custom-2-4096",
  "metadata": {
    "items": [
      {
        "key": "enable-oslogin",
        "value": "true"
      }
    ]
  },
  "name": "destin-instance-1",
  "networkInterfaces": [
    {
      "accessConfigs": [
        {
          "name": "External NAT",
          "networkTier": "PREMIUM"
        }
      ],
      "stackType": "IPV4_ONLY",
      "subnetwork": "projects/qwiklabs-gcp-01-b104182dca0a/regions/us-central1/subnetworks/default"
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
      "email": "43938466557-compute@developer.gserviceaccount.com",
      "scopes": [
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring.write",
        "https://www.googleapis.com/auth/servicecontrol",
        "https://www.googleapis.com/auth/service.management.readonly",
        "https://www.googleapis.com/auth/trace.append"
      ]
    }
  ],
  "shieldedInstanceConfig": {
    "enableIntegrityMonitoring": true,
    "enableSecureBoot": false,
    "enableVtpm": true
  },
  "tags": {
    "items": []
  },
  "zone": "projects/qwiklabs-gcp-01-b104182dca0a/zones/us-central1-a"
}

# Connect via SSH to your custom VM
# For the custom VM you just created, click SSH.

# To see information about unused and used memory and swap space on your custom VM, run the following command:

free

# To see details about the RAM installed on your VM, run the following command:

sudo dmidecode -t 17

# To verify the number of processors, run the following command:

nproc

# To see details about the CPUs installed on your VM, run the following command:


lscpu

#To exit the SSH terminal, run the following command:

exit