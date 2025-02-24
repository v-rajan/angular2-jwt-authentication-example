# Use IBM MQ Advanced for Developers as the base image
FROM ibmcom/mq:latest

# Accept the IBM MQ license agreement
ENV LICENSE=accept

# Define the default Queue Manager name (change as needed)
ENV MQ_QMGR_NAME=DEVQMGR

# Expose ports:
#   - 1414: MQ client connections
#   - 9443: Web console access
EXPOSE 1414 9443

# Switch to root to perform system configuration tasks
USER root

# Create the mqm group and user if they do not already exist.
# Then create directories for logs and data and assign proper ownership.
RUN groupadd -r mqm && \
    useradd -r -g mqm mqm && \
    mkdir -p /var/mqm/log /var/mqm/data && \
    chown -R mqm:mqm /var/mqm/log /var/mqm/data /etc/mqm /mnt/mqm /run

# Switch to the non-root mqm user (if further customization or security is needed)
USER mqm

# (Optional) Copy any custom configuration or scripts into the image
# COPY mqconfig/ /etc/mqm/

# Start the IBM MQ server when the container launches
CMD ["runmqserver"]
