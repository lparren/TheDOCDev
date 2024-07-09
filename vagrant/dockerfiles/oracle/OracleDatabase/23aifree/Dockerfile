FROM gvenzl/oracle-free:latest as base

# ------------------------------------------------------------------------------
# Define fixed (build time) environment variables.
ENV APEX_FILE="apex-latest.zip" \
    INSTALL_DIR=/opt/install 

COPY --chown=oracle:oinstall ${APEX_FILE} ${INSTALL_DIR}/

