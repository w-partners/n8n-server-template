#!/bin/bash
set -e
apt update && apt install -y docker.io docker-compose git ffmpeg python3-pip curl unzip
git clone https://github.com/w-partners/n8n-server-template.git /opt/n8n
cd /opt/n8n
cp .env.sample .env || echo "N8N_ENCRYPTION_KEY=changeme" > .env


echo "▶ Installing base packages..."
apt update && apt install -y docker.io docker-compose git ffmpeg python3-pip curl unzip cpufrequtils ddclient

echo "▶ Cloning n8n-server-template..."
git clone https://github.com/w-partners/n8n-server-template.git /opt/n8n

cd /opt/n8n
cp .env.sample .env || echo "N8N_ENCRYPTION_KEY=changeme" > .env

echo "▶ Setting CPU governor to performance (if supported)..."
cpufreq-set -g performance || echo "cpufreq-set failed or not supported."

echo "▶ Setting up ddclient (Cloudflare DDNS)..."
cp ddclient.conf.template /etc/ddclient.conf
systemctl enable ddclient
systemctl restart ddclient

echo "▶ Launching Docker containers..."

docker-compose up --build -d
docker ps
bash restore.sh || true
