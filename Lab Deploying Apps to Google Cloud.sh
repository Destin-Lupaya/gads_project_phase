#!/bin/bash

#rachelkabuyre@gmail.com

# Task 1. Download a sample app from GitHub
# Download a sample application from GitHub and preview it in Cloud Shell.

# In the Cloud Console, click Activate Cloud Shell (Activate Cloud Shell icon).

# If prompted, click Continue.

# To create a new folder, run the following command:

mkdir gcp-course

# Change to the folder you just created:

cd gcp-course

# Clone a simple Python Flask app from GitHub:

git clone https://GitHub.com/GoogleCloudPlatform/training-data-analyst.git

# Change to the deploying-apps-to-gcp folder:

cd training-data-analyst/courses/design-process/deploying-apps-to-gcp

# To test the program, enter the following command to build a Docker container of the image:

docker build -t test-python .

# To run the Docker image, enter the following command:
docker run --rm -p 8080:8080 test-python

# To see the program running, click Web Preview (Web Preview icon) in the toolbar of Google Cloud Shell. Then, select Preview on port 8080.
# The program should be displayed in a new browser tab.

# In Cloud Shell, type Ctrl+C to stop the program.

# Task 2. Deploy to App Engine
# App Engine is a completely automated deployment platform. It supports many languages, including Python, Java, JavaScript, and Go. To use it, you create a configuration file and deploy your applications with a couple of simple commands. In this task, you create a file named app.yaml and deploy it to App Engine.

# In Cloud Shell, click Open Editor (Cloud Shell Editor icon), then click Open in a new window if required.

# Select the gcp-course/training-data-analyst/courses/design-process/deploying-apps-to-gcp folder in the explorer tree on the left.

# From the File menu, select New File, and name the file app.yaml. Then click Ok.

# Paste the following into the file you just created:

runtime: python37

# Save your changes.
# Note: There are other settings you can add to the app.yaml file, but in this case only the language runtime is required.
# In a project, an App Engine application has to be created. This is done just once using the gcloud app create command and specifying the region where you want the app to be created. Enter the following command:

gcloud app create --region=us-central

# Now deploy your app with the following command:

gcloud app deploy --version=one --quiet

# Note: This command will take a couple of minutes to complete.
# On the Navigation menu (Navigation menu icon), click App Engine > Dashboard. In the upper-right corner of the dashboard is a link to your application, similar to this:
# Example of the application link

# Note: By default, the URL to an App Engine application is in the form of https://project-id.appspot.com.
# Click on the link to test your program.

# Make a change to the program to see how easy the App Engine makes managing versions.

# In the code editor, expand the training-data-analyst/courses/design-process/deploying-apps-to-gcp folder in the navigation pane on the left. Then, click main.py to open it.

# In the main() function, change the title to Hello App Engine as shown below:

@app.route("/")
def main():
    model = {"title" "Hello App Engine"}
    return render_template('index.html', model=model)
Click File > Save in the code editor toolbar to save your change.

# Now, deploy version two with the following command:

gcloud app deploy --version=two --no-promote --quiet

# Note: The --no-promote parameter tells App Engine to continue serving requests with the old version. This allows you to test the new version before putting it into production.
# When the command completes, return to the App Engine dashboard. Click the link again, and version one will still be returned. It should return Hello GCP. This is because of the --no-promote parameter in the previous command.

# On the left, click the Versions tab. Notice that two versions are listed.

# Note: You might have to click Refresh to see version two.
# Click on the version two link to test it. It should return Hello App Engine.

# To migrate production traffic to version two, click Split Traffic at the top. Change the version to two, and click Save.

# Give it a minute to complete. Refresh the browser tab that earlier returned Hello GCP. It should now return the new version.

# Click Check my progress to verify the objective.
# Deploy to App Engine

# Task 3. Deploy to Kubernetes Engine
# Kubernetes Engine allows you to create a cluster of machines and deploy any number of applications to it. Kubernetes abstracts the details of managing machines and allows you to automate the deployment of your applications with simple CLI commands.

# To deploy an application to Kubernetes, you first need to create the cluster. Then you need to add a configuration file for each application you will deploy to the cluster.

# On the Navigation menu (Navigation menu icon), click Kubernetes Engine. If a message appears saying the Kubernetes API is being initialized, wait for it to complete.

# Click Create.

# In the Create Cluster dialog box, to the right of the Standard: You manage your cluster option, click Configure.

# Accept all the defaults, and click Create. It will take a couple of minutes for the Kubernetes Engine cluster to be created. When the cluster is ready, a green check appears.

# Click the three dots to the right of the cluster and then click Connect.

# In the Connect to the cluster screen, click Run in Cloud Shell. This opens Cloud Shell with the connect command entered automatically.

# Press Enter to connect to the cluster.

# To test your connection, enter the following command:

# kubectl get nodes
# Copied!
# This command simply shows the machines in your cluster. If it works, you're connected.

# In Cloud Shell, click Open Editor (Cloud Shell Editor icon).
# Expand the training-data-analyst/courses/design-process/deploying-apps-to-gcp folder in the navigation pane on the left. Then, click main.py to open it.
# In the main() function, change the title to Hello Kubernetes Engine as shown below:
# @app.route("/")
# def main():
#     model = {"title" "Hello Kubernetes Engine"}
#     return render_template('index.html', model=model)
# Save your change.

# Add a file named kubernetes-config.yaml to the training-data-analyst/courses/design-process/deploying-apps-to-gcp folder.

# Paste the following code in that file to configure the application:

# ---
# apiVersion: apps/v1
# kind: Deployment
# metadata:
#   name: devops-deployment
#   labels:
#     app: devops
#     tier: frontend
# spec:
#   replicas: 3
#   selector:
#     matchLabels:
#       app: devops
#       tier: frontend
#   template:
#     metadata:
#       labels:
#         app: devops
#         tier: frontend
#     spec:
#       containers:
#       - name: devops-demo
#         image: <YOUR IMAGE PATH HERE>
#         ports:
#         - containerPort: 8080
# ---
# apiVersion: v1
# kind: Service
# metadata:
#   name: devops-deployment-lb
#   labels:
#     app: devops
#     tier: frontend-lb
# spec:
#   type: LoadBalancer
#   ports:
#   - port: 80
#     targetPort: 8080
#   selector:
#     app: devops
#     tier: frontend
# Copied!
# Note: In the first section of the YAML file above, you are configuring a deployment. In this case, you are deploying 3 instances of your Python web app. Notice the image attribute. You will update this value with your image in a minute after you build it. In the second section, you are configuring a service of the type "load balancer". The load balancer will have a public IP address. Users will access your application through the load balancer.

# For more information on Kubernetes deployments and services, see the links below:

# Kubernetes Deployments page
# Kubernetes Create an External Load Balancer page
# To use Kubernetes Engine, you need to build a Docker image. Enter the following commands to use Cloud Build to create the image and store it in Container Registry:

# cd ~/gcp-course/training-data-analyst/courses/design-process/deploying-apps-to-gcp
# gcloud builds submit --tag gcr.io/$DEVSHELL_PROJECT_ID/devops-image:v0.2 .
# Copied!
# When the previous command completes, the image name will be listed in the output. The image name is in the form gcr.io/project-id/devops-image:v0.2.

# Highlight your image name and copy it to the clipboard. Paste that value in the kubernetes-config.yaml file, overwriting the string <YOUR IMAGE PATH HERE>.

# You should see something similar to below:

# spec:
#   containers:
#   - name: devops-demo
#     image: gcr.io/test-1-263611/devops-image:v0.2
#     ports:
# Enter the following Kubernetes command to deploy your application:

# kubectl apply -f kubernetes-config.yaml
# Copied!
# In the configuration file, three replicas of the application were specified. Type the following command to see whether three instances have been created:

# kubectl get pods
# Copied!
# Make sure all the pods are ready. If they aren't, wait a few seconds and try again.

# A load balancer was also added in the configuration file. Type the following command to see whether it was created:

# kubectl get services
# Copied!
# You should see something similar to below:

# Output

# If the load balancer's external IP address says "pending", wait a few seconds and try again.

# When you have an external IP, open a browser tab and make a request to it. It should return Hello Kubernetes Engine. It might take a few seconds to be ready.
# Click Check my progress to verify the objective.
# Deploy to Kubernetes Engine

# Task 4. Deploy to Cloud Run
# Cloud Run simplifies and automates deployments to Kubernetes. When you use Cloud Run, you don't need a configuration file. You simply choose a cluster for your application. With Cloud Run, you can use a cluster managed by Google, or you can use your own Kubernetes cluster.

# To use Cloud Run, your application needs to be deployed using a Docker image and it must be stateless.

# Open the Cloud Shell code editor and expand the training-data-analyst/courses/design-process/deploying-apps-to-gcp folder in the navigation pane on the left. Then, click main.py to open it.
# In the main() function, change the title to Hello Cloud Run as shown below:
# @app.route("/")
# def main():
#     model = {"title" "Hello Cloud Run"}
#     return render_template('index.html', model=model)
# Save your change.

# To use Cloud Run, you need to build a Docker image. In Cloud Shell, enter the following commands to use Cloud Build to create the image and store it in Container Registry:

# cd ~/gcp-course/training-data-analyst/courses/design-process/deploying-apps-to-gcp
# gcloud builds submit --tag gcr.io/$DEVSHELL_PROJECT_ID/cloud-run-image:v0.1 .
# Copied!
# When the build completes, in the Navigation menu (Navigation menu icon), click Cloud Run.

# Click Create service. This enables the Cloud Run API.

# Click the Select link in the Container image URL text box. In the resulting dialog, expand cloud-run-image and select the image listed. Then click Select.

# In Service name, type hello-cloud-run.

# In Autoscaling set the Maximum number of instances to 6. Leave the rest as defaults.

# For Authentication, select Allow unauthenticated invocations.

# In Container, Connections, Security for Container, select default in the Execution environment section.

# Finally, click Create.

# It shouldn't take long for the service to deploy. When a green check appears, click on the URL that is automatically generated for the application. It should return Hello Cloud Run.