FROM ubuntu:20.04

RUN apt-get update -y
RUN apt-get -y install make gcc

RUN mkdir -p /opt/tpch
RUN mkdir -p /data

COPY data/tpch /opt/tpch
ENV TPCH_VERSION="3.0.1" 


RUN cd /opt/tpch/$TPCH_VERSION/dbgen && make
RUN chmod +x /opt/tpch/gendata.sh

ENV PATH="${PATH}:/opt/tpch/${TPCH_VERSION}/dbgen"

ENV DSS_PATH="/data"

WORKDIR /opt/tpch/${TPCH_VERSION}/dbgen

ENTRYPOINT ["dbgen"]