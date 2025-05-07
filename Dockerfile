FROM n8nio/n8n:latest
RUN apt-get update && apt-get install -y ffmpeg python3-pip && \
    pip3 install yt-dlp && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
