echo "******************************************************************************"
echo "Check if this is the first run." `date`
echo "******************************************************************************"
FIRST_RUN="false"
if [ ! -f ~/CONTAINER_ALREADY_STARTED_FLAG ]; then
  echo "First run."
  FIRST_RUN="true"
  touch ~/CONTAINER_ALREADY_STARTED_FLAG
else
  echo "Not first run."
fi

if [ "${FIRST_RUN}" == "true" ]; then
  echo "APEX Images."
  cd ${SOFTWARE_DIR}
  unzip -oq ${SOFTWARE_DIR}/${APEX_FILE}
  rm -f ${SOFTWARE_DIR}/${APEX_FILE}
  mv ${SOFTWARE_DIR}/apex/images .
  rm -Rf ${SOFTWARE_DIR}/apex

  echo "******************************************************************************"
  echo "Configure ORDS. Safe to run on DB with existing config." `date`
  echo "******************************************************************************"

  ords --config ${ORDS_CONFIG} install \
       --log-folder ${ORDS_CONFIG}/logs \
       --admin-user SYS \
       --db-hostname ${DB_HOSTNAME} \
       --db-port ${DB_PORT} \
       --db-servicename ${DB_SERVICE} \
       --feature-db-api true \
       --feature-rest-enabled-sql true \
       --feature-sdw true \
       --gateway-mode proxied \
       --gateway-user APEX_PUBLIC_USER \
       --proxy-user \
       --password-stdin <<EOF
${SYS_PASSWORD}
${APEX_LISTENER_PASSWORD}
EOF

  ords --config ${ORDS_CONFIG} config set standalone.static.path ${SOFTWARE_DIR}/images
  ords --config ${ORDS_CONFIG} config set jdbc.InitialLimit 10
  ords --config ${ORDS_CONFIG} config default set jdbc.MaxLimit 200
fi

ords --config ${ORDS_CONFIG} serve