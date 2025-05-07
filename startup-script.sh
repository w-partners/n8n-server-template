#!/bin/bash
apt update && apt install -y docker.io docker-compose git ffmpeg python3-pip curl unzip

git clone https://github.com/w-partners/n8n-server-template.git /opt/n8n
cd /opt/n8n

cp .env.sample .env
docker-compose up --build -d

bash restore.sh
