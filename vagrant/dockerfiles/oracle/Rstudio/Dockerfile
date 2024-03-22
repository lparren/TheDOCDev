FROM oraclelinux:7-slim as base

ENV LD_LIBRARY_PATH=/usr/lib/oracle/21/client64/lib/${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH} \
    ORACLE_HOME=/usr/lib/oracle/21/client64 

ENV PATH=$PATH:$ORACLE_HOME/bin 

RUN yum install -y yum-utils zip unzip git initscripts systemd \
 && yum-config-manager --enable ol7_optional_latest       \
 && yum-config-manager --enable ol7_addons                \
 && yum install -y oraclelinux-developer-release-el7      \
 && yum-config-manager --enable ol7_developer             \
 && yum install -y R python3                              \
 && mkdir -p /opt/install                                 

COPY oracle-instantclient* /opt/install/
COPY ore-supporting-linux-x86-64-1.5.1.zip /opt/install/
COPY ore-client-linux-x86-64-1.5.1.zip /opt/install/
COPY rstudio-server-rhel-1.3.1093-x86_64.rpm /opt/install/ 

RUN yum install -y /opt/install/oracle-instantclient*.rpm \ 
 && cd /opt/install \       
 && unzip ore-client-linux-x86-64-1.5.1.zip \
 && unzip ore-supporting-linux-x86-64-1.5.1.zip \
 && R CMD INSTALL /opt/install/client/ORE_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz                \
 && R CMD INSTALL /opt/install/client/OREbase_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz            \
 && R CMD INSTALL /opt/install/client/OREcommon_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz          \
 && R CMD INSTALL /opt/install/client/OREdm_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz              \
 && R CMD INSTALL /opt/install/client/OREdplyr_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz           \
 && R CMD INSTALL /opt/install/client/OREeda_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz             \
 && R CMD INSTALL /opt/install/client/OREembed_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz           \
 && R CMD INSTALL /opt/install/client/OREgraphics_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz        \
 && R CMD INSTALL /opt/install/client/OREmodels_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz          \
 && R CMD INSTALL /opt/install/client/OREpredict_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz         \
 && R CMD INSTALL /opt/install/client/OREstats_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz           \
 && R CMD INSTALL /opt/install/client/ORExml_1.5.1_R_x86_64-unknown-linux-gnu.tar.gz             \
 && R CMD INSTALL /opt/install/supporting/Cairo_1.5-9_R_x86_64-unknown-linux-gnu.tar.gz          \
 && R CMD INSTALL /opt/install/supporting/DBI_0.6-1_R_x86_64-unknown-linux-gnu.tar.gz            \
 && R CMD INSTALL /opt/install/supporting/ROracle_1.3-2_R_x86_64-unknown-linux-gnu.tar.gz        \
 && R CMD INSTALL /opt/install/supporting/arules_1.5-0_R_x86_64-unknown-linux-gnu.tar.gz         \
 && R CMD INSTALL /opt/install/supporting/png_0.1-7_R_x86_64-unknown-linux-gnu.tar.gz            \
 && R CMD INSTALL /opt/install/supporting/randomForest_4.6-12_R_x86_64-unknown-linux-gnu.tar.gz  \
 && R CMD INSTALL /opt/install/supporting/statmod_1.4.29_R_x86_64-unknown-linux-gnu.tar.gz       \
 && yum install -y /opt/install/rstudio-server-rhel-1.3.1093-x86_64.rpm
 
# Add nonroot user
RUN useradd rstudio \
  && echo "rstudio:rstudio" | chpasswd 

EXPOSE 8787

CMD rstudio-server start && sleep infinity
