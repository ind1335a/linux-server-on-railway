FROM ubuntu:latest
RUN apt update && apt upgrade -y
RUN useradd -m -s /bin/bash user || true
RUN echo "user:ind1335a_RailWayLinuxServer" | chpasswd
RUN usermod -aG sudo user
RUN echo "user ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/user
RUN mkdir -p /home/user/
RUN chown -R user:user /home/user/
CMD sudo -u user sh -c 'cd ~/ && curl -sSf https://sshx.io/get | sh'
