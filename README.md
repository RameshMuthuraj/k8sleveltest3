# AIM:
  - Automatically Deploy Highly Available K8s cluster on GCP with add-ons listed below.
  - Create CI/CD pipeline to deploy "mediawiki" application from github using helm.
  - Setup Docker private repository.
  - Setup Vulnerability scaner(clair)
  - Deploy Nginx ingress controller 
  - Setup Istio
  - Setup k8s-dashboard
  
# Add-ons:
1)	Nginx ingress controller 
2)	Jenkins master and executers  
3)	Docker private repository
4)	Kubernetes Dashboard
5)	Prometheous
6)	Grafana
7)	heapster
	
## Prerequisites:
1)	GCP account 
2)	Terraform 

# Steps:
   This Repo will help you install kubernetes cluster with High Availability.

1) First step is to clone this repo 
 #git clone https://github.com/pbalajiips/k8sleveltest3.git

2) Create GCP  service account with "ComputeAdmin, ServiceAccount User, StorageAdmin role" and download the json authentication file using below URL and save it to  dir  clusterbuild/terrafrom  URL# https://console.cloud.google.com/apis/credentials/serviceaccountkey?_ga=2.85288474.-260090499.1561174311

3) Initialize and apply the form
###### cd clusterbuild/terrafrom
###### terrafrom init ; terrafrom plan; terrafrom apply

The Cluster is ready for use , since this is test cluster i havenot created the LB for master. you can access any one of the master and check the status.


## Steps Involved
 This terradata form will create GCP AutoScalling group for WORKER, MASTER Nodes; (on enterprise setup we can create Nodes for PKI, ETCD,INFRA).

 Instances created within this autoscalling group use the template created by terrrafrom which has the Startup script to setup cluster components based on Autoscalling group Name and labels.

 It uses the Ansible and bash to setup cluster. to store certs, we can use etcd python client to store the Token/Certs in etcd.

 On worker node, once docker and  kubelet installed ansible will get the key and master LB URL. And run the kubectl join command. Or we can use certificates to join cluster.
 
 On master node, once the api-server is ready we can start install the add-ons  which is stored in add-ons dir using kubectl apply –f ./add-ons/

## setup Jenkins,
  To setup CICD we need to deploy jekins and its slaves on cluster. the jenkins/setup.sh will do that instatllation. 

  Once the jenkins is up configure them as admin user
  
  Using jenkins/deploy.groovy we can deploy the applicaion on the cluster.


## Docker private repo setup

## Docker image scanner

## Deploy Istio

## Deploy K8s DashBoard

## using Terraform destory we can delete cluster setup.
 
# Todo List:
  Need to create LoadBalancer for Master URL 
  Need to create common file share to upload and download certs

