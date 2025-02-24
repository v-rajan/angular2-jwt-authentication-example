# Use the official WildFly base image
FROM jboss/wildfly:14.0.1.Final

# Set working directory
WORKDIR /opt/jboss/wildfly

# Run as root to allow file copying
USER root

# Ensure required directories exist
RUN mkdir -p /opt/jboss/wildfly/standalone/deployments \
    && mkdir -p /opt/jboss/wildfly/modules/system/layers/base/com/mysql/main \
    && mkdir -p /logs/apps/CTS

# Copy IBM MQ Resource Adapter (RAR file)
COPY wmq.jmsra-9.0.5.0.rar /opt/jboss/wildfly/standalone/deployments/

# Copy MySQL connector JAR
COPY mysql-connector-j-8.4.0.jar /opt/jboss/wildfly/modules/system/layers/base/com/mysql/main/

# Copy module.xml for MySQL
COPY mysql-module.xml /opt/jboss/wildfly/modules/system/layers/base/com/mysql/main/module.xml

# Ensure MySQL module is installed before executing CLI
RUN ls -l /opt/jboss/wildfly/modules/system/layers/base/com/mysql/main/

# Copy CLI script for configuring IBM MQ and MySQL
COPY configure.cli /opt/jboss/wildfly/configure.cli

# Run CLI to configure IBM MQ and MySQL
RUN /opt/jboss/wildfly/bin/jboss-cli.sh --file=/opt/jboss/wildfly/configure.cli

# Add WildFly admin user
RUN /opt/jboss/wildfly/bin/add-user.sh admin pass1234 --silent

# Expose WildFly ports
EXPOSE 8080 9990

# Start WildFly
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-c", "standalone-full.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
