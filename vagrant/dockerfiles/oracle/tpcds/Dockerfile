FROM ubuntu:20.04

RUN apt-get update -y
RUN apt-get -y install make gcc bison flex

RUN mkdir -p /opt/tpcds
RUN mkdir -p /data

COPY data/tpcds /opt/tpcds
ENV TPCDS_VERSION="4.0.0" 

RUN cd /opt/tpcds/$TPCDS_VERSION/tools && make
# RUN chmod +x /opt/tpcds/$TPCDS_VERSION/tools/dsdgen.sh

ENV PATH="${PATH}:/opt/tpcds/${TPCDS_VERSION}/tools"

ENV DSS_PATH="/data"

WORKDIR /opt/tpcds/${TPCDS_VERSION}/tools

ENTRYPOINT ["dsdgen"]