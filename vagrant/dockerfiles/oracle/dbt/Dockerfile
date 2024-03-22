##
# base image (abstract)
##
FROM ghcr.io/dbt-labs/dbt-core:1.6.5 as base

# Env vars
ENV ORA_PYTHON_DRIVER_TYPE: thin

# Set docker basics
WORKDIR /usr/app/dbt/
VOLUME /usr/app

RUN python3.8 -m pip install --no-cache-dir dbt-oracle 

ENTRYPOINT ["dbt"]
