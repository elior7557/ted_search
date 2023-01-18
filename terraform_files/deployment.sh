#!/bin/bash
set -vx
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
usermod -aG docker ubuntu
chmod 777 /var/run/docker.sock
# Build the image
cd /tmp/production
docker load -i docker_image
docker compose up -d


echo "production is up and running!!"
exit 0
