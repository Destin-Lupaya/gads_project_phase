#!/bin/bash

#rachelkabuyre@gmail.com

gsutil ls gs://[YOUR_BUCKET_NAME]

#Use the Service Account User
gcloud compute instances list

gsutil cp gs://[YOUR_BUCKET_NAME]/sample.txt 

mv sample.txt sample2.txt

gsutil cp sample2.txt gs://[YOUR_BUCKET_NAME]

gsutil cp sample2.txt gs://[YOUR_BUCKET_NAME]