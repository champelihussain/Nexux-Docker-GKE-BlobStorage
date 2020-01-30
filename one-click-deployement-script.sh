#!/bin/bash

# This script can be executed from a tooling server deployed in GCloud
yum install git -y
yum install docker -y
systemctl enable docker
service docker start
yum install kubectl -y

mkdir /tmp/nexus-gcp-prj
cd /tmp/nexus-gcp-prj
git clone https://github.com/champelihussain/Nexux-Docker-GKE-BlobStorage.git
cd /tmp/nexus-gcp-prj/Nexux-Docker-GKE-BlobStorage/docker

docker build -t gcr.io/vital-program-266112/nexus-app:v1 .
docker push gcr.io/vital-program-266112/nexus-app:v1
gcloud container clusters create nexus-gke-cluster --num-nodes=2 --zone=us-central1-a
cd /tmp/nexus-gcp-prj/Nexux-Docker-GKE-BlobStorage/kubernetes
kubectl apply -f deployment-gke.yaml
kubectl apply -f service-gke.yaml

# After this wait for 2-3 mins and open Loadbalaner IP in browser
# nexus admin password can be found in passwd.sh file