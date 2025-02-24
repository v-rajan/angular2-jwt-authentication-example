# Use the official WildFly base image
FROM jboss/wildfly:14.0.1.Final

# Set working directory
WORKDIR /opt/jboss/wildfly

# Run as non-root user for security (if possible)
USER root

# Ensure required directories exist
RUN mkdir -p /opt/jboss/wildfly/standalone/deployments \
    && mkdir -p /opt/jboss/wildfly/modules/system/layers/base/com/ibm/mq/main \
    && mkdir -p /opt/jboss/wildfly/modules/system/layers/base/com/mysql/main \
    && mkdir -p /logs/apps/CTS

# Copy IBM MQ driver
COPY com.ibm.mq.allclient-9.4.1.1.jar /opt/jboss/wildfly/modules/system/layers/base/com/ibm/mq/main/

# Copy MySQL connector JAR
COPY mysql-connector-j-8.4.0.jar /opt/jboss/wildfly/modules/system/layers/base/com/mysql/main/

# Copy module.xml files
COPY mq-module.xml /opt/jboss/wildfly/modules/system/layers/base/com/ibm/mq/main/module.xml
COPY mysql-module.xml /opt/jboss/wildfly/modules/system/layers/base/com/mysql/main/module.xml

# Ensure MySQL module is installed before executing CLI
RUN ls -l /opt/jboss/wildfly/modules/system/layers/base/com/mysql/main/
RUN ls -l /opt/jboss/wildfly/modules/system/layers/base/com/ibm/mq/main/

# Copy CLI script for MySQL datasource
COPY configure.cli /opt/jboss/wildfly/configure.cli

# Run CLI to configure MySQL and messaging
RUN /opt/jboss/wildfly/bin/jboss-cli.sh --file=/opt/jboss/wildfly/configure.cli

# Add WildFly admin user
RUN /opt/jboss/wildfly/bin/add-user.sh admin pass1234 --silent

# Expose WildFly ports
EXPOSE 8080 9990

# Start WildFly
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-c", "standalone-full.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
