FROM n8nio/n8n:latest

USER root
RUN apt-get update && apt-get install -y ffmpeg python3-pip && \
    pip3 install yt-dlp && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV OMP_NUM_THREADS=8
ENV MKL_NUM_THREADS=8
ENV OPENBLAS_NUM_THREADS=8

USER node
