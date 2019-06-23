#!/bin/bash
#To install k8s mastercomponents

yum install -y yum-config-manager
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

## Install Docker CE.
yum update -y && yum -y install docker-ce-18.06.2.ce

## Create /etc/docker directory.
mkdir /etc/docker

# Setup daemon.
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}
EOF

mkdir -p /etc/systemd/system/docker.service.d
systemctl enable --now docker
# Restart Docker
systemctl daemon-reload
systemctl restart docker

#setup python-etcd
yum -y install python-pip  
pip install python-etcd

#setup Kubernetes components 
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF

setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
systemctl enable --now kubelet

sleep 5
kubeadm init
######
sleep 5
######
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

git clone https://github.com/pbalajiips/k8sleveltest3.git
kubectl apply -f k8sleveltest3/add-ons
kubectl apply -f k8sleveltest3/add-ons

##install jenkins
./k8sleveltest3/jenkins-kubernetes/setup.sh
 

