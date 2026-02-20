# Use the official Oracle Linux 8 slim image
FROM oraclelinux:8-slim

# Set environment variables for the installation
ENV ORACLE_DOCKER_INSTALL=true \
    ORACLE_HOME=/opt/oracle/product/19c/dbhome_1 \
    PATH=$PATH:/opt/oracle/product/19c/dbhome_1/bin \
    APEX_FILE="apex-latest.zip"

# Install the Preinstallation RPM to configure kernel parameters and create 'oracle' user
RUN microdnf install -y dnf dnf-utils dos2unix iproute perl 
RUN dnf install -y oraclelinux-release-el8 && \
    dnf install -y oraclelinux-developer-release-el8  && \
    dnf install -y oracle-database-preinstall-19c  && \
    dnf clean all

# Copy the Enterprise Edition RPM (must be in the same directory as Dockerfile)
# Note: You must download this manually as it requires an Oracle Account
COPY oracle-database-ee-19c-1.0-1.x86_64.rpm /tmp/

# Install the Database Enterprise Edition RPM
RUN dnf -y localinstall /tmp/oracle-database-ee-19c-1.0-1.x86_64.rpm
RUN rm -rf /tmp/oracle-database-ee-19c-1.0-1.x86_64.rpm

# Expose the standard Oracle listener port
EXPOSE 1521

# Copy the entrypoint script and make it executable
COPY entrypoint.sh /opt/oracle/entrypoint.sh
RUN dos2unix /opt/oracle/entrypoint.sh
RUN chmod +x /opt/oracle/entrypoint.sh

COPY checkDBStatus.sh /opt/oracle/checkDBStatus.sh
RUN dos2unix /opt/oracle/checkDBStatus.sh
RUN chmod +x /opt/oracle/checkDBStatus.sh

# COPY userscripts
COPY runUserScripts.sh /tmp/runUserScripts.sh
RUN dos2unix /tmp/runUserScripts.sh
RUN chmod +x /tmp/runUserScripts.sh

COPY  db-sample-schemas-19c.zip $APEX_FILE tpch-data.zip tpcds-data.zip /tmp/

RUN mkdir -p /tmp/userScripts
COPY ./userScripts/* /tmp/userScripts/
RUN dos2unix /tmp/userScripts/*
RUN chmod +x /tmp/userScripts/*

ENTRYPOINT ["/opt/oracle/entrypoint.sh"]