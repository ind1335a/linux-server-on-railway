FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/bash

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    sudo \
    ca-certificates \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Create user with passwordless sudo
RUN useradd -m -s /bin/bash user && \
    echo "user:ind1335a_RailWayLinuxServer" | chpasswd && \
    usermod -aG sudo user && \
    echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user

# Install sshx directly (automatically places binary into /usr/local/bin)
RUN curl -sSf https://sshx.io/get | sh

# Switch to the non-root user
USER user
WORKDIR /home/user

# Run sshx in an infinite loop DURING the build
RUN bash -c 'while true; do sshx; echo "sshx closed. Restarting in 2s..."; sleep 2; done'
