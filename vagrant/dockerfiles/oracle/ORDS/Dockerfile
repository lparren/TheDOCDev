FROM oraclelinux:8
LABEL maintainer="Ólafur Tryggvason <olafur.tryggvason@advania.is>"

RUN yum-config-manager --add-repo=http://yum.oracle.com/repo/OracleLinux/OL8/oracle/software/x86_64

ENV ORDS_CONFIG="/opt/oracle/config_ords"
ENV SOFTWARE_DIR="/opt/oracle"
ENV ORA_DEFAULT_DATABASE="odinn"

RUN dnf -y -q update
RUN dnf -y install java-17-openjdk unzip zip which wget sudo man
RUN dnf -y install ords
RUN dnf clean all

# COPY ./config_ords/ /opt/oracle/config_ords/
COPY ./runords.sh /opt/oracle/config_ords/
COPY ${APEX_FILE} ${SOFTWARE_DIR}/
RUN chmod +x /opt/oracle/config_ords/runords.sh

EXPOSE 8000

ENTRYPOINT [ "sh","-c","/opt/oracle/config_ords/runords.sh" ]