# Use the latest Debian image
FROM debian:latest

# Set environment variable for non-interactive installs
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install required packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    jq \
    aria2 \
    pv \
    openssl \
    curl \
    git \
    wget \
    unzip \
    ffmpeg \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a virtual environment and install Python packages inside it.
RUN python3 -m venv /app/venv
RUN /app/venv/bin/pip install --upgrade pip setuptools wheel \
    && /app/venv/bin/pip install telethon speedtest-cli pycryptodome docopt

# Set working directory
WORKDIR /app
RUN chmod 777 /app

# Copy all files to the workdir
COPY . .

# Default command
CMD ["bash","tgbot.sh"]
