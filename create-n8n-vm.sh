#!/bin/bash
PROJECT_ID="n8n-gcp-server"
ZONE="asia-northeast3-a"
VM_NAME="n8n-server-$(date +%Y%m%d-%H%M)"
STARTUP_SCRIPT_URL="https://raw.githubusercontent.com/w-partners/n8n-server-template/main/startup-script.sh"

gcloud compute firewall-rules create allow-n8n-5678 \
  --allow=tcp:5678 \
  --target-tags=n8n \
  --network=default \
  --source-ranges=0.0.0.0/0 || true

gcloud compute instances create "$VM_NAME" \
  --project="$PROJECT_ID" \
  --zone="$ZONE" \
  --machine-type="c2-standard-8" \
  --image-family=debian-11 \
  --image-project=debian-cloud \
  --boot-disk-size=50GB \
  --boot-disk-type=pd-ssd \
  --tags=n8n \
  --metadata=startup-script-url="$STARTUP_SCRIPT_URL" \
  --scopes=https://www.googleapis.com/auth/cloud-platform

gcloud compute instances describe "$VM_NAME" --zone "$ZONE" \
  --format="get(networkInterfaces[0].accessConfigs[0].natIP)"
