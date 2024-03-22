ARG PYTHON_VERSION

FROM python:${PYTHON_VERSION}-slim

# ARG MELTANO_VERSION

# Meltano project directory - this is where you should mount your Meltano project
ARG WORKDIR="/project"

ENV PIP_NO_CACHE_DIR=1

ARG USER_ID
ARG GROUP_ID

# USER_ID and _GROUP_ID are passed as parameters
# A new user and group is added matching the user of the host user so files are created with the same ID's
RUN groupadd -g ${GROUP_ID} meltano_user && \
    useradd -l -u ${USER_ID} -g meltano_user meltano_user && \
    install -d -m 0755 -o meltano_user -g meltano_user /home/meltano_user && \
    echo meltano_user:vagrant | chpasswd

RUN mkdir "${WORKDIR}" && \
    chown -R meltano_user ${WORKDIR} && \
    chmod 777 ${WORKDIR} && \
    apt-get update && \
    apt-get install -y build-essential freetds-bin freetds-dev git libkrb5-dev libssl-dev tdsodbc unixodbc unixodbc-dev && \
    rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

# Create a virtual environment, and activate it
RUN python -m venv /venv
ENV PATH="/venv/bin:${PATH}"

# Installing the application the same way our users do when using PyPI
RUN pip install --upgrade pip wheel && \
    pip install "meltano"

USER meltano_user
WORKDIR "${WORKDIR}"

ENTRYPOINT ["meltano"]