FROM jboss/wildfly:latest

# Set working directory
WORKDIR /opt/jboss/wildfly

# Copy EAR files for deployment
#COPY myapp1.ear /opt/jboss/wildfly/standalone/deployments/
#COPY myapp2.ear /opt/jboss/wildfly/standalone/deployments/

# Copy IBM Db2 JDBC driver to modules directory
COPY jcc-11.5.6.0.jar /opt/jboss/wildfly/modules/system/layers/base/com/ibm/db2/main/

# Copy module XML configuration for Db2 driver
COPY module.xml /opt/jboss/wildfly/modules/system/layers/base/com/ibm/db2/main/module.xml

# Copy CLI script for configuring the Db2 datasource
COPY configure-adb2.cli /opt/jboss/wildfly/configure-adb2.cli

# Register Db2 driver as a module
RUN /opt/jboss/wildfly/bin/jboss-cli.sh --file=/opt/jboss/wildfly/configure-adb2.cli

# Expose WildFly ports
EXPOSE 8080 9990

# Start WildFly
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
