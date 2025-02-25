# Use an official Ubuntu base image
FROM ubuntu:20.04

# Avoid interactive prompts during package installs
ENV DEBIAN_FRONTEND=noninteractive

# Update package index and install ca-certificates
RUN apt-get update && apt-get install -y ca-certificates

# Configure APT to disable HTTPS certificate verification
RUN echo 'Acquire::https::Verify-Peer "false";\nAcquire::https::Verify-Host "false";' \
    > /etc/apt/apt.conf.d/99insecure

# Backup the default sources list
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak

# Replace the default Ubuntu APT sources with your Nexus repository mirror with authentication.
# Make sure to adjust "focal" if you are using a different Ubuntu version.
RUN echo "deb [trusted=yes] https://123:123@repository.chnoumis.org/repository/ubuntu-mirror/ focal main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb [trusted=yes] https://123:123@repository.chnoumis.org/repository/ubuntu-mirror/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb [trusted=yes] https://123:123@repository.chnoumis.org/repository/ubuntu-mirror/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list


# Remove cached APT package lists after installing software.
# RUN apt-get update && \
#    apt-get install -y docker-ce docker-ce-cli containerd.io && \
#    rm -rf /var/lib/apt/lists/*

# Update the package index and install Docker packages from your Nexus repository mirror.
RUN apt-get update \
    apt-get install -y vim

# Set the default command
CMD ["/bin/bash"]
