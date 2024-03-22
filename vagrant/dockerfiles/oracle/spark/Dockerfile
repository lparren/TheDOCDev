FROM oraclelinux:7-slim as base

ENV LOG_TAG="[ZEPPELIN_${Z_VERSION}]:"

RUN echo "$LOG_TAG install basic packages" && \
    yum install -y yum-utils zip unzip git bzip2 initscripts systemd sudo wget && \
    yum install -y oraclelinux-developer-release-el7                      && \
    yum install -y oracle-epel-release-el7                                && \
    yum-config-manager --enable ol7_optional_latest ol7_addons ol7_developer && \
    yum -y update && \
    yum install -y libcurl-devel openssl-devel

#RUN yum update \
# && yum install -y locales \
# && dpkg-reconfigure -f noninteractive locales \
# && locale-gen C.UTF-8 \
# && /usr/sbin/update-locale LANG=C.UTF-8 \
# && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
# && locale-gen \
# && yum clean \
# && rm -rf /var/lib/apt/lists/*

## Users with other locales should set this in their derivative image
#ENV LANG en_US.UTF-8
#ENV LANGUAGE en_US:en
#ENV LC_ALL en_US.UTF-8
#
#RUN yum update \
# && yum install -y curl unzip \
#    python3 python3-setuptools \
# && ln -s /usr/bin/python3 /usr/bin/python \
# && easy_install3 pip py4j \
# && yum clean \
# && rm -rf /var/lib/apt/lists/*
#
## http://blog.stuart.axelbrooke.com/python-3-on-spark-return-of-the-pythonhashseed
#ENV PYTHONHASHSEED 0
#ENV PYTHONIOENCODING UTF-8
#ENV PIP_DISABLE_PIP_VERSION_CHECK 1
#
## JAVA
#RUN yum update \
# && yum install -y openjdk-8-jre \
# && yum clean \
# && rm -rf /var/lib/apt/lists/*
#
## HADOOP
#ENV HADOOP_VERSION 3.0.0
#ENV HADOOP_HOME /usr/hadoop-$HADOOP_VERSION
#ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
#ENV PATH $PATH:$HADOOP_HOME/bin
#RUN curl -sL --retry 3 \
#  "http://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz" \
#  | gunzip \
#  | tar -x -C /usr/ \
# && rm -rf $HADOOP_HOME/share/doc \
# && chown -R root:root $HADOOP_HOME
#
## SPARK
#ENV SPARK_VERSION 2.4.4
#ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-without-hadoop
#ENV SPARK_HOME /usr/spark-${SPARK_VERSION}
#ENV SPARK_DIST_CLASSPATH="$HADOOP_HOME/etc/hadoop/*:$HADOOP_HOME/share/hadoop/common/lib/*:$HADOOP_HOME/share/hadoop/common/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/hdfs/lib/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/yarn/lib/*:$HADOOP_HOME/share/hadoop/yarn/*:$HADOOP_HOME/share/hadoop/mapreduce/lib/*:$HADOOP_HOME/share/hadoop/mapreduce/*:$HADOOP_HOME/share/hadoop/tools/lib/*"
#ENV PATH $PATH:${SPARK_HOME}/bin
#RUN curl -sL --retry 3 \
#  "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz" \
#  | gunzip \
#  | tar x -C /usr/ \
# && mv /usr/$SPARK_PACKAGE $SPARK_HOME \
# && chown -R root:root $SPARK_HOME
#
#WORKDIR $SPARK_HOME
#CMD ["bin/spark-class", "org.apache.spark.deploy.master.Master"]

CMD [sleep infinity]
