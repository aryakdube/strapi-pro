#!/bin/bash
set -e

exec > /var/log/user-data.log 2>&1

apt-get update -y
apt-get install -y docker.io curl git

systemctl enable docker
systemctl start docker

# Docker Compose plugin install (agar chahiye to)
mkdir -p /usr/local/lib/docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.29.2/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# Terraform se pass hua image tag use kar rahe hain
IMAGE_TAG="${image_tag}"
IMAGE_NAME="aryak491/strapi-app:$IMAGE_TAG"


docker rm -f strapi_app || true

# Docker image pull karo
docker pull $IMAGE_NAME

# Container run karo
docker run -d --name strapi_app -p 1337:1337 --restart unless-stopped $IMAGE_NAME
