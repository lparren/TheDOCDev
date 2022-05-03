##
# base image (abstract)
##
FROM oraclelinux:8 as base

# N.B. The refs updated automagically every release via bumpversion
# N.B. dbt-postgres is currently found in the core codebase so a value of dbt-core@<some_version> is correct

ENV dbt_core_ref=dbt-coree@v1.2.0a1 \
    dbt_third_party=dbt-oracle

# System setup
RUN dnf update -y \
  && dnf install oracle-instantclient-release-el8 \
  && dnf install -y  git \
    make \
    openssh-clients \
    python38 \
    python38-libs \
    python38-pip \
    python38-setuptools \
    oracle-instantclient-release-el8.x86_64 \
    oracle-instantclient-basic.x86_64 \
    oracle-instantclient-devel.x86_64 \
    oracle-instantclient-jdbc.x86_64 \
    oracle-instantclient-odbc.x86_64 \
    oracle-instantclient-sqlplus.x86_64 \
    oracle-instantclient-tools.x86_64 \
    cx_oracle \
  && rm -rf \
    /tmp/* \
    /var/tmp/*

# Env vars
ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8

# Update python
RUN python3.8 --version
RUN python3.8 -m pip install --upgrade pip setuptools wheel --no-cache-dir

# Set docker basics
WORKDIR /usr/app/dbt/
VOLUME /usr/app
ENTRYPOINT ["dbt"]

##
# dbt-core
##
FROM base as dbt-core
RUN python3.8 -m pip install --no-cache-dir "git+https://github.com/dbt-labs/${dbt_core_ref}#egg=dbt-core&subdirectory=core"

##
# dbt-third-party
##
FROM dbt-core as dbt-third-party
RUN python3.8 -m pip install --no-cache-dir "${dbt_third_party}"
