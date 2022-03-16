FROM oraclelinux:8

# Oracle Client version
ARG release=19
ARG update=3

ENV LD_LIBRARY_PATH=/usr/lib/oracle/21/client64/lib/${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH} \
    ORACLE_HOME=/usr/lib/oracle/21/client64  \
    PATH=$PATH:$ORACLE_HOME/bin

RUN mkdir -p /opt/install && \
    mkdir -p /usr/.dbt && \
    chmod 777 /usr/.dbt

COPY python38.module /etc/dnf/modules.d/python38.module
COPY oracle-instantclient* /opt/install/

RUN yum install -y yum-utils && \
    yum-config-manager --enable ol7_optional_latest && \
    yum-config-manager --enable ol7_oracle_instantclient  && \
    yum -y install oracle-instantclient${release}.${update}-basiclite

# Install python3.8
RUN yum install -y python38 python38-libs python38-pip python38-setuptools && \
    yum install -y unzip git bzip2 wget && \
    yum clean all

#RUN yum localinstall -y /opt/install/oracle-instantclient*.rpm

# Upgrade pip otherwise dbt install leads to error
RUN pip3 install --upgrade pip setuptools wheel

# Install dbt
RUN pip3 install dbt==0.19.0 cx_Oracle dbt-oracle=0.4.0

ENV WORKSPACE=/workspace

# Set working directory
WORKDIR $WORKSPACE

# Make dbt an API
CMD ["dbt"]
