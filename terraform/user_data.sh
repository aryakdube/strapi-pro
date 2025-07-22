#!/bin/bash
set -e

# Log output for debugging
exec > /var/log/user-data.log 2>&1

# Update system and install Docker, curl, git
apt-get update -y
apt-get install -y docker.io curl git

# Enable and start Docker service
systemctl enable docker
systemctl start docker

# Install Docker Compose plugin (v2)
mkdir -p /usr/local/lib/docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.29.2/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# Clone your repo (replace with your repo URL)
cd /opt
if [ ! -d "strapi-config-crew" ]; then
  git clone https://github.com/aryakdube/strapi-pro.git
fi
cd strapi-pro

# Create .env with all necessary environment variables (replace secrets accordingly)
cat << EOF > .env
HOST=0.0.0.0
PORT=1337
APP_KEYS=H5mnz8odDwNsrPrHYZMK+w==,vflz6dcxdZtLmb/qr/38bg==,2RQzSRADDruCIWu1qHtkGw==,gwSyUiod2cNkoIifB1wClw==
API_TOKEN_SALT=ntITJUKq7KPLSs3yMDWmWw==
ADMIN_JWT_SECRET=EYw8dnO6uAJgieoP0V2QCA==
TRANSFER_TOKEN_SALT=6hJTsNusRF6kArOCiUI0aA==
ENCRYPTION_KEY=oQQVoC1EbAsvD0UUeGNHDA==
JWT_SECRET=EYw8dnO6uAJgieoP0V2QCA==
DATABASE_CLIENT=postgres
DATABASE_HOST=postgres
DATABASE_PORT=5432
DATABASE_NAME=strapi
DATABASE_USERNAME=strapi
DATABASE_PASSWORD=strapi
DATABASE_SSL=false
EOF

# Remove existing containers if any conflict arises
docker compose down || true

# Build and start all containers in detached mode
docker compose build
docker compose up -d
