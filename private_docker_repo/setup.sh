#!/bin/bash
mkdir -p /opt/docker/containers/docker-registry/certs
openssl req -newkey rsa:2048 -nodes -sha256  -x509 -days 365  -keyout /opt/docker/containers/docker-registry/certs/docker_registry.key  -out /opt/docker/containers/docker-registry/certs/docker_registry.crt

mkdir -p /opt/docker/containers/docker-registry/auth
docker run --entrypoint htpasswd  registry -Bbn docker_user password > /opt/docker/containers/docker-registry/auth/htpasswd

mkdir /opt/docker/containers/docker-registry/registry
docker pull registry

docker run -d \
 --name docker-registry \
 --restart=always \
 -p 5000:5000 \
 -v /opt/docker/containers/docker-registry/registry:/var/lib/registry \
 -v /opt/docker/containers/docker-registry/auth:/auth \
 -e "REGISTRY_AUTH=htpasswd" \
 -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
 -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
 -v /opt/docker/containers/docker-registry/certs:/certs \
 -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/docker-registry.crt \
 -e REGISTRY_HTTP_TLS_KEY=/certs/docker-registry.key \
 registry


sleep 20
mkdir -p /etc/docker/certs.d/127.0.0.1:5000
cp /opt/docker/containers/docker-registry/certs/docker-registry.crt /etc/docker/certs.d/127.0.0.1:5000/ca.crt
