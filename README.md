# AIM:
  Deploy Highly Available K8s cluster on GCP with listed add-ons and create Ci/CD pipeline to deploy minikube application from github using helm.
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
2)	Terrafrom installed locally 

# Steps:
   This Repo will help you install kubernetes cluster with High Availability.
1)	As a first step clone this repo 
#git clone <>
2)	Change directory to clusterbuild/terrafrom, and  create GCP  service account with ComputeAdmin, ServiceAccount User, StorageAdmin role and download the json authentication file using below URL and save to  dir  clusterbuild/terrafrom  URL# https://console.cloud.google.com/apis/credentials/serviceaccountkey?_ga=2.85288474.-260090499.1561174311

###### cd clusterbuild/terrafrom
###### terrafrom init ; terrafrom plan; terrafrom apply

## Steps Involved
 This terradata form will create GCP AutoScalling group for WORKER, MASTER, for enterprise setup we can create PKI, ETCD,INFRA(for infrapods).
 
 Instances created within this autos calling group use the template created by terrrafrom which has the Startup script to setup cluster components based on Autoscalling group Name.

 Also It uses the Ansible to download token from central repo or we can use etcd python client to store the Token/Certs in etcd.

 On worker node, once docker and  kubelet installed ansible will get the key and master LB URL. And run the kubectl  join command. Or we can use certificates to join cluster.
 
  On master node once the api-server is ready we can start install the add-ons  which is stored in add-ons dir using kubectl apply –f ./add-ons/


#tTodo List:
  Need to create LoadBalancer for Master URL 
  Need to create common file share to upload and download certs

