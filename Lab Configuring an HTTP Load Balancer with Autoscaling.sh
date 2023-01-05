#!/bin/bash

#rachelkabuyre@gmail.com

# Overview
# Google Cloud HTTP(S) load balancing is implemented at the edge of Google's network in Google's points of presence (POP) around the world. User traffic directed to an HTTP(S) load balancer enters the POP closest to the user and is then load-balanced over Google's global network to the closest backend that has sufficient available capacity.

# In this lab, you configure an HTTP load balancer as shown in the diagram below. Then, you stress test the load balancer to demonstrate global load balancing and autoscaling.

# Network diagram

# Objectives
# In this lab, you learn how to perform the following tasks:

# Create a health check firewall rule
# Create a NAT configuration using Cloud Router
# Create a custom image for a web server
# Create an instance template based on the custom image
# Create two managed instance groups
# Configure an HTTP load balancer with IPv4 and IPv6
# Stress test an HTTP load balancer
# For each lab, you get a new Google Cloud project and set of resources for a fixed time at no cost.

# Sign in to Qwiklabs using an incognito window.

# Note the lab's access time (for example, 1:15:00), and make sure you can finish within that time.
# There is no pause feature. You can restart if needed, but you have to start at the beginning.

# When ready, click Start lab.

# Note your lab credentials (Username and Password). You will use them to sign in to the Google Cloud Console.

# Click Open Google Console.

# Click Use another account and copy/paste credentials for this lab into the prompts.
# If you use other credentials, you'll receive errors or incur charges.

# Accept the terms and skip the recovery resource page.

# Note: Do not click End Lab unless you have finished the lab or want to restart it. This clears your work and removes the project.

# Task 1. Configure a health check firewall rule
# Health checks determine which instances of a load balancer can receive new connections. For HTTP load balancing, the health check probes to your load-balanced instances come from addresses in the ranges 130.211.0.0/22 and 35.191.0.0/16. Your firewall rules must allow these connections.

# Create the health check rule
# Create a firewall rule to allow health checks.

# In the Cloud Console, on the Navigation menu (Navigation menu icon), click VPC network > Firewall.
# Notice the existing ICMP, internal, RDP, and SSH firewall rules.

# Each Google Cloud project starts with the default network and these firewall rules.

# Click Create Firewall Rule.

# Specify the following, and leave the remaining settings as their defaults:

# Property	Value (type value or select option as specified)
# Name	fw-allow-health-checks
# Network	default
# Targets	Specified target tags
# Target tags	allow-health-checks
# Source filter	IPv4 ranges
# Source IPv4 ranges	130.211.0.0/22 and 35.191.0.0/16
# Protocols and ports	Specified protocols and ports
# Note: Make sure to include the /22 and /16 in the Source IP ranges.
# Select tcp and specify port 80.
# Click Create.
# Click Check my progress to verify the objective.
# Configure health check firewall rule

gcloud compute --project=qwiklabs-gcp-01-66ae1717943a firewall-rules create fw-allow-health-checks --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 --source-ranges=130.211.0.0/22,35.191.0.0/16 --target-tags=allow-health-checks

POST https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-01-66ae1717943a/global/firewalls
{
  "kind": "compute#firewall",
  "name": "fw-allow-health-checks",
  "selfLink": "projects/qwiklabs-gcp-01-66ae1717943a/global/firewalls/fw-allow-health-checks",
  "network": "projects/qwiklabs-gcp-01-66ae1717943a/global/networks/default",
  "direction": "INGRESS",
  "priority": 1000,
  "targetTags": [
    "allow-health-checks"
  ],
  "allowed": [
    {
      "IPProtocol": "tcp",
      "ports": [
        "80"
      ]
    }
  ],
  "sourceRanges": [
    "130.211.0.0/22",
    "35.191.0.0/16"
  ]
}

# Task 2. Create a NAT configuration using Cloud Router
# The Google Cloud VM backend instances that you set up in Task 3 will not be configured with external IP addresses.

# Instead, you will set up the Cloud NAT service to allow these VM instances to send outbound traffic only through the Cloud NAT, and receive inbound traffic through the load balancer.

# Create the Cloud Router instance
# In the Cloud Console, on the Navigation menu (Navigation menu icon), click Network services > Cloud NAT.

# Click Get started.

# Specify the following, and leave the remaining settings as their defaults:

# Property	Value (type value or select option as specified)
# Gateway name	nat-config
# Network	default
# Region	us-central1
# Click Cloud Router, and select Create new router.

# For Name, type nat-router-us-central1.

# Click Create.

# In Create a NAT gateway, click Create.

# Note: Wait until the NAT Gateway Status changes to Running before moving onto the next task.
# Click Check my progress to verify the objective.
# Create a NAT configuration using Cloud Router

# Task 3. Create a custom image for a web server
# Create a custom web server image for the backend of the load balancer.

# Create a VM
# In the Cloud Console, on the Navigation menu (Navigation menu icon), click Compute Engine > VM instances.

# Click Create Instance.

# Specify the following, and leave the remaining settings as their defaults:

# Property	Value (type value or select option as specified)
# Name	webserver
# Region	us-central1
# Zone	us-central1-a
# Boot disk	Debian GNU/Linux 10 (buster)
# Under Boot disk, click Change > Show Advanced Configuration.

# For Deletion rule, select Keep boot disk.

# Click Select.

# Click Networking, Disks, Security, Management, Sole-tenancy.

# Click Networking.

# For Network tags, type allow-health-checks.
# Under Network interfaces , click default.
# Under External IPv4 IP dropdown, select None.
# Click Done.

# Click Create.

#EQUIVALENT COMMANDE LINE

gcloud compute instances create webserver --project=qwiklabs-gcp-01-66ae1717943a --zone=us-central1-a --machine-type=e2-medium --network-interface=subnet=default,no-address --metadata=enable-oslogin=true --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=1020462315781-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --tags=allow-health-check --create-disk=boot=yes,device-name=webserver,image=projects/debian-cloud/global/images/debian-10-buster-v20221206,mode=rw,size=10,type=projects/qwiklabs-gcp-01-66ae1717943a/zones/us-central1-a/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

POST https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-01-66ae1717943a/zones/us-central1-a/instances
{
  "canIpForward": false,
  "confidentialInstanceConfig": {
    "enableConfidentialCompute": false
  },
  "deletionProtection": false,
  "description": "",
  "disks": [
    {
      "autoDelete": false,
      "boot": true,
      "deviceName": "webserver",
      "diskEncryptionKey": {},
      "initializeParams": {
        "diskSizeGb": "10",
        "diskType": "projects/qwiklabs-gcp-01-66ae1717943a/zones/us-central1-a/diskTypes/pd-balanced",
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
  "machineType": "projects/qwiklabs-gcp-01-66ae1717943a/zones/us-central1-a/machineTypes/e2-medium",
  "metadata": {
    "items": [
      {
        "key": "enable-oslogin",
        "value": "true"
      }
    ]
  },
  "name": "webserver",
  "networkInterfaces": [
    {
      "stackType": "IPV4_ONLY",
      "subnetwork": "projects/qwiklabs-gcp-01-66ae1717943a/regions/us-central1/subnetworks/default"
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
      "email": "1020462315781-compute@developer.gserviceaccount.com",
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
      "allow-health-check"
    ]
  },
  "zone": "projects/qwiklabs-gcp-01-66ae1717943a/zones/us-central1-a"
}

# Customize the VM
# For webserver, click SSH to launch a terminal and connect.

# If you see the Connection via Cloud Identity-Aware Proxy Failed popup, click Retry.

# To install Apache2, run the following commands:

sudo apt-get update
sudo apt-get install -y apache2

# To start the Apache server, run the following command:

sudo service apache2 start

# To test the default page for the Apache2 server, run the following command:

curl localhost

# The default page for the Apache2 server should be displayed.

# Set the Apache service to start at boot
# The software installation was successful. However, when a new VM is created using this image, the freshly booted VM does not have the Apache web server running. Use the following command to set the Apache service to automatically start on boot. Then test it to make sure it works.

# In the webserver SSH terminal, set the service to start on boot:

sudo update-rc.d apache2 enable

# In the Cloud Console, select webserver, and then click More actions moreoptions.png .

# Click Reset.

# In the confirmation dialog, click Reset.

# Note: Reset will stop and reboot the machine. It keeps the same IPs and the same persistent boot disk, but memory is wiped. Therefore, if the Apache service is available after the reset, the update-rc command was successful.
# Check the server by connecting via SSH to the VM and entering the following command:

sudo service apache2 status

# Note: If you see the Connection via Cloud Identity-Aware Proxy Failed popup, click Retry.
# The result should show Started The Apache HTTP Server.

# Prepare the disk to create a custom image
# Verify that the boot disk will not be deleted when the instance is deleted.

# On the VM instances page, click webserver to view the VM instance details.

# Under Storage > Boot disk, verify that When deleting instance is set to Keep disk.

# Return to the VM instances page, select webserver, and then click More actions (More actions icon) .

# Click Delete.

# In the confirmation dialog, click Delete.

# In the left pane, click Disks and verify that the webserver disk exists.

# Create the custom image
# In the left pane, click Images.

# Click Create image.

# Specify the following, and leave the remaining settings as their defaults:

# Property	Value (type value or select option as specified)
# Name	mywebserver
# Source	Disk
# Source disk	webserver
# Click Create.

# Note: You have created a custom image that multiple identical webservers can be started from. At this point, you could delete the webserver disk.
# The next step is to use that image to define an instance template that can be used in the managed instance groups.

# Click Check my progress to verify the objective.
# Create a custom image for a web server

# Task 4. Configure an instance template and create instance groups
# A managed instance group uses an instance template to create a group of identical instances. Use these to create the backends of the HTTP load balancer.

# Configure the instance template
# An instance template is an API resource that you can use to create VM instances and managed instance groups. Instance templates define the machine type, boot disk image, subnet, labels, and other instance properties.

# In the Cloud Console, on the Navigation menu (Navigation menu icon), click Compute Engine > Instance templates.

# Click Create Instance Template.

# For Name, type mywebserver-template.

# For Series, select N1.

# For Machine type, select f1-micro (1 vCPU).

# For Boot disk, click Change.

# Click Custom images > Select a Project.

# In Select a Project dialog, click Project_ID.

# For Image, Select mywebserver.

# Click Select.

# # Click Networking, Disks, Security, Management, Sole-tenancy.

# # Click Networking.

# # For Network tags, type allow-health-checks.
# # Under Network interfaces , click default.
# # Under External IPv4 IP dropdown, select None.
# # Click Done.
# # Click Create.

# # Create the health check for managed instance groups
# # On the Navigation menu, click Compute Engine > Health checks.

# # Click Create health check.

# # Specify the following, and leave the remaining settings as their defaults:

# # Property	Value (select option as specified)
# # Name	http-health-check
# # Protocol	TCP
# # Port	80
# # Click Create.

# # Managed instance group health checks proactively signal to delete and recreate instances that become unhealthy.
# # Create the managed instance groups
# # Create a managed instance group in us-central1 and one in europe-west1.

# # On the Navigation menu, click Compute Engine > Instance groups.

# # Click Create Instance Group.

# # Specify the following, and leave the remaining settings as their defaults:

# # Property	Value (type value or select option as specified)
# # Name	us-central1-mig
# # Instance template	mywebserver-template
# # Location	Multiple zones
# # Region	us-central1
# # Under Autoscaling, enter Minimum number of instances 1 and Maximum number of instances 2.

# # Under Autoscaling metrics, click on the CPU utilization.

# # Under Metric type, select HTTP load balancing utilization.

# # Enter Target HTTP load balancing utilization to 80.

# # Click Done.

# Click Cool down period and set to 60 seconds.

# Note: Managed instance groups offer autoscaling capabilities that allow you to automatically add or remove instances from a managed instance group based on increases or decreases in load. Autoscaling helps your applications gracefully handle increases in traffic and reduces cost when the need for resources is lower. You just define the autoscaling policy, and the autoscaler performs automatic scaling based on the measured load.
# In Autohealing, for health check type http-health-check

# Select http-health-check (TCP)

# For Initial delay, type 60. This is how long the Instance Group waits after initializing the boot-up of a VM before it tries a health check. You don't want to wait 5 minutes for this during the lab, so you set it to 1 minute.

# Click Create.

# Click Confirm in the dialog window.

# Note: Wait a few minutes for the Instance Group to be created before repeating the same procedure for europe-west1-mig in europe-west1: Click Refresh until the Status changes to Transforming.
# Note: If a warning window appears, or you see a red exclamation mark to the left of the instance group after creation stating There is no backend service attached to the instance group. Ignore this; you will configure the load balancer with a backend service in the next section of the lab.
# Click Create Instance Group.

# Specify the following, and leave the remaining settings as their defaults:

# Property	Value (type value or select option as specified)
# Name	europe-west1-mig
# Instance template	mywebserver-template
# Location	Multiple zones
# Region	europe-west1
# Autoscaling > Minimum number of instances	1
# Autoscaling > Maximum number of instances	2
# Autoscaling metrics > Metric Type	HTTP load balancing utilization
# Target HTTP load balancing utilization	80
# Cool down period	60
# For Health check, select http-health-check (TCP).

# For Initial delay, type 60.

# Click Create.

# Click Confirm in the dialog window.

# Click Check my progress to verify the objective.
# Configure an instance template and create instance groups

# Verify the backends
# Verify that VM instances are being created in both regions.

# On the Navigation menu, click Compute Engine > VM instances.
# Notice the instances that start with us-central1-mig and europe-west1-mig. These instances are part of the managed instance groups.

# Task 5. Configure the HTTP load balancer
# Configure the HTTP load balancer to balance traffic between the two backends (us-central1-mig in us-central1 and europe-west1-mig in europe-west1) as illustrated in the network diagram:

# Network diagram

# Start the configuration
# On the Navigation menu, click Network Services > Load balancing.

# Click Create Load Balancer.

# Under HTTP(S) Load Balancing, click Start configuration.

# Under Internet facing or internal only, select From Internet to my VMs or serverless services.

# Under Global or Regional, select Global HTTP(S) Load Balancer (classic).

# Click Continue.

# For Name, type http-lb.

# Configure the frontend
# The host and path rules determine how your traffic will be directed. For example, you could direct video traffic to one backend and direct static traffic to another backend. However, you are not configuring the host and path rules in this lab.

# Click Frontend configuration.

# Specify the following, and leave the remaining settings as their defaults:

# Property	Value (type value or select option as specified)
# Protocol	HTTP
# IP version	IPv4
# IP address	Ephemeral
# Port	80
# Click Done.

# Click Add Frontend IP and Port.

# Specify the following, and leave the remaining settings as their defaults:

# Property	Value (type value or select option as specified)
# Protocol	HTTP
# IP version	IPv6
# IP address	Ephemeral
# Port	80
# Click Done.

# HTTP(S) load balancing supports both IPv4 and IPv6 addresses for client traffic. Client IPv6 requests are terminated at the global load balancing layer and then proxied over IPv4 to your backends.
# # Configure the backend
# # Backend services direct incoming traffic to one or more attached backends. Each backend is composed of an instance group and additional serving capacity metadata.

# # Click Backend Configuration.

# # Click Backend services & backend buckets > Create a Backend Service.

# # Specify the following, and leave the remaining settings as their defaults:

# # Property	Value (select option as specified)
# # Name	http-backend
# # Backend type	Instance group
# # Instance group	us-central1-mig
# # Port numbers	80
# # Balancing mode	Rate
# # Maximum RPS	50
# # Capacity	100
# # Note: This configuration means that the load balancer attempts to keep each instance of us-central1-mig at or below 50 requests per second (RPS).
# # Click Done.

# # Click Add Backend.

# # Specify the following, and leave the remaining settings as their defaults:

# # Property	Value (select option as specified)
# # Instance group	europe-west1-mig
# # Port numbers	80
# # Balancing mode	Utilization
# # Maximum backend utilization	80
# # Capacity	100
# # Note: This configuration means that the load balancer attempts to keep each instance of europe-west1-mig at or below 80% CPU utilization.
# # Click Done.

# For Health Check, select http-health-check.

# Click check for the Enable logging checkbox.

# Specify Sample rate as 1.

# Click Create.

# Click OK.

# Review and create the HTTP load balancer
# Click Review and finalize.
# Review the Backend services and Frontend.
# Click Create. Wait for the load balancer to be created.
# Click on the name of the load balancer (http-lb).
# Note the IPv4 and IPv6 addresses of the load balancer for the next task. They will be referred to as [LB_IP_v4] and [LB_IP_v6], respectively.
# Note: The IPv6 address is the one in hexadecimal format.
# Click Check my progress to verify the objective.
# Configure the HTTP load balancer

# Task 6. Stress test the HTTP load balancer
# Now that you have created the HTTP load balancer for your backends, it is time to verify that traffic is forwarded to the backend service.


# The HTTP load balancer should forward traffic to the region that is closest to you.

# True

# False

# Access the HTTP load balancer
# On the Google Cloud Console title bar, click Activate Cloud Shell (Activate Cloud Shell icon).

# If prompted, click Continue.

# To check the status of the load balancer, run the following command, replace [LB_IP_v4] with the IPv4 address of the load balancer:

LB_IP=[LB_IP_v4]
while [ -z "$RESULT" ] ; 
do 
  echo "Waiting for Load Balancer";
  sleep 5;
  RESULT=$(curl -m1 -s $LB_IP | grep Apache);
done

# Note: Once the load balancer is ready, the command will exit.
# Open a new tab in your browser and navigate to http://[LB_IP_v4]. Make sure to replace [LB_IP_v4] with the IPv4 address of the load balancer.

# Stress test the HTTP load balancer
# Create a new VM to simulate a load on the HTTP load balancer. Then determine whether traffic is balanced across both backends when the load is high.

# In the Cloud Console, on the Navigation menu (Navigation menu icon), click Compute Engine > VM instances.

# Click Create instance.

# Specify the following, and leave the remaining settings as their defaults:

# Property	Value (type value or select option as specified)
# Name	stress-test
# Region	us-west1
# Zone	us-west1-b
# Series	N1
# Machine type	f1-micro (1 vCPU)
# Note: Because us-west1 is closer to us-central1 than to europe-west1, traffic should be forwarded only to us-central1-mig (unless the load is too high).
# For Boot Disk, click Change.

# Click Custom images > Select a Project.

# In Select a Project dialog, click Project_ID.

# For Image, select mywebserver.

# Click Select.

# Click Create.
# Wait for the stress-test instance to be created.

# For stress-test, click SSH to launch a terminal and connect.

# To create an environment variable for your load balancer IP address, run the following command:

export LB_IP=<Enter your [LB_IP_v4] here>

# Verify it with echo:

echo $LB_IP

# To place a load on the load balancer, run the following command:

ab -n 500000 -c 1000 http://$LB_IP/


Stress test the HTTP load balancer

# In the Cloud Console, on the Navigation menu (Navigation menu icon), click Network Services > Load balancing.
# Click http-lb.
# Click Monitoring.
# Monitor the Frontend Location (Total inbound traffic) between North America and the two backends for a couple of minutes.
# Note: At first, traffic should just be directed to us-central1-mig, but as the RPS increases, traffic is also directed to europe-west1-mig. This demonstrates that by default traffic is forwarded to the closest backend, but if the load is very high, traffic can be distributed across the backends.
# Traffic flow diagram

# In the Cloud Console, on the Navigation menu (Navigation menu icon), click Compute Engine > Instance groups.
# Click on us-central1-mig to open the instance group page.
# Click Monitoring to monitor the number of instances and LB capacity.
# Repeat the same for the europe-west1-mig instance group.
# Note: Depending on the load, you might see the backends scale to accommodate the load.
# Task 7. Review
# In this lab, you configured an HTTP load balancer with backends in us-central1 and europe-west1. Then you stress-tested the load balancer with a VM to demonstrate global load balancing and autoscaling.

# End your lab