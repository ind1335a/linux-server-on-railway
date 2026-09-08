FROM ubuntu:latest

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages (curl, sudo, ca-certificates are missing by default in ubuntu:latest)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    sudo \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create user, set password, and configure passwordless sudo
RUN useradd -m -s /bin/bash user && \
    echo "user:ind1335a_RailWayLinuxServer" | chpasswd && \
    usermod -aG sudo user && \
    echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user

# Switch to the non-root user and set home directory
USER user
WORKDIR /home/user

# Run sshx
CMD ["sh", "-c", "curl -sSf https://sshx.io/get | sh"]
