# LICENSE UPL 1.0
#
# Copyright (c) 2018, 2020 Oracle and/or its affiliates.
#
# ORACLE DOCKERFILES PROJECT
# --------------------------
# This is the Dockerfile for Oracle Database 19c
#
# REQUIRED FILES TO BUILD THIS IMAGE
# ----------------------------------
# (1) db_home.zip
#     Download Oracle Database 19c Enterprise Edition or Standard Edition 2 for Linux x64
#     from http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html
#
# HOW TO BUILD THIS IMAGE
# -----------------------
# Put all downloaded files in the same directory as this Dockerfile
# Run:
#      $ docker build -t oracle/database:19.3.0-${EDITION} .
#
# Pull base image
# ---------------
FROM oraclelinux:7-slim as base

# Labels
# ------
LABEL "provider"="Oracle"                                               \
      "issues"="https://github.com/oracle/docker-images/issues"         \
      "volume.data"="/opt/oracle/oradata"                               \
      "volume.setup.location1"="/opt/oracle/scripts/setup"              \
      "volume.setup.location2"="/docker-entrypoint-initdb.d/setup"      \
      "volume.startup.location1"="/opt/oracle/scripts/startup"          \
      "volume.startup.location2"="/docker-entrypoint-initdb.d/startup"  \
      "port.listener"="1521"                                            \
      "port.oemexpress"="5500"

# Environment variables required for this build (do NOT change)
# -------------------------------------------------------------
ENV ORACLE_BASE=/opt/oracle \
    ORACLE_HOME=/opt/oracle/product/19c/dbhome_1 \
    INSTALL_DIR=/opt/install \
    INSTALL_FILE_1="LINUX.X64_193000_db_home.zip" \
    INSTALL_RSP="db_inst.rsp" \
    CONFIG_RSP="dbca.rsp.tmpl" \
    PWD_FILE="setPassword.sh" \
    RUN_FILE="runOracle.sh" \
    START_FILE="startDB.sh" \
    CREATE_DB_FILE="createDB.sh" \
    SETUP_LINUX_FILE="setupLinuxEnv.sh" \
    CHECK_SPACE_FILE="checkSpace.sh" \
    CHECK_DB_FILE="checkDBStatus.sh" \
    USER_SCRIPTS_FILE="runUserScripts.sh" \
	  INSTALL_ORE="installORE.sh" \
    INSTALL_DB_BINARIES_FILE="installDBBinaries.sh" \
	  INSTALL_SAMPLE_SCHEMAS="installSampleSchemas.sh" \
	  SAMPLE_SCHEMAS="db-sample-schemas-master.zip" \
    ORE_SERVER="ore-server-linux-x86-64-1.5.1.zip" \
	  ORE_SUPPORT="ore-supporting-linux-x86-64-1.5.1.zip"

# Use second ENV so that variable get substituted
ENV PATH=$ORACLE_HOME/bin:$ORACLE_HOME/OPatch/:/usr/sbin:$PATH \
    LD_LIBRARY_PATH=$ORACLE_HOME/lib:/usr/lib \
    CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib

# Copy files needed during both installation and runtime
# -------------
COPY $SETUP_LINUX_FILE $CHECK_SPACE_FILE $INSTALL_DIR/
COPY $RUN_FILE $START_FILE $CREATE_DB_FILE $CONFIG_RSP $PWD_FILE $CHECK_DB_FILE $USER_SCRIPTS_FILE $ORE_SERVER $ORE_SUPPORT $SAMPLE_SCHEMAS $INSTALL_ORE $INSTALL_SAMPLE_SCHEMAS $ORACLE_BASE/

RUN yum install -y yum-utils zip unzip dos2unix && \
    yum-config-manager --enable ol7_optional_latest && \
    yum-config-manager --enable ol7_addons  && \
	  yum install -y cairo-devel libpng-devel R

RUN chmod ug+x $INSTALL_DIR/*.sh && \
    sync && \
    $INSTALL_DIR/$CHECK_SPACE_FILE && \
    $INSTALL_DIR/$SETUP_LINUX_FILE && \
    rm -rf $INSTALL_DIR

#############################################
# -------------------------------------------
# Start new stage for installing the database
# -------------------------------------------
#############################################

FROM base AS builder

ARG DB_EDITION

# Copy DB install file
COPY --chown=oracle:dba $INSTALL_FILE_1 $INSTALL_RSP $INSTALL_DB_BINARIES_FILE $ORE_SERVER $ORE_SUPPORT $INSTALL_DIR/

RUN echo "DB_EDITION = $DB_EDITION"

# Install DB software binaries
USER oracle
RUN chmod ug+x $INSTALL_DIR/*.sh && \
    sync && \
    $INSTALL_DIR/$INSTALL_DB_BINARIES_FILE $DB_EDITION



#############################################
# -------------------------------------------
# Start new layer for database runtime
# -------------------------------------------
#############################################

FROM base

USER oracle
COPY --chown=oracle:dba --from=builder $ORACLE_BASE $ORACLE_BASE


USER root
RUN $ORACLE_BASE/oraInventory/orainstRoot.sh && \
    $ORACLE_HOME/root.sh

USER oracle
WORKDIR /home/oracle

HEALTHCHECK --interval=1m --start-period=5m \
   CMD "$ORACLE_BASE/$CHECK_DB_FILE" >/dev/null || exit 1

# Define default command to start Oracle Database.
CMD exec $ORACLE_BASE/$RUN_FILE
