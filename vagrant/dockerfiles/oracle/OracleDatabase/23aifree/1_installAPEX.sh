echo "*******************************************************"
echo "*** Installing APEX                                 ***"
echo "*******************************************************"
cd ~
mkdir install
cd install
cp /container-entrypoint-initdb.d/${APEX_FILE} .
unzip ${APEX_FILE}
cd apex

sqlplus sys/${ORACLE_PASSWORD}@FREEPDB1 as sysdba <<EOF
@apexins.sql USERS USERS TEMP /i/

BEGIN
    APEX_UTIL.set_security_group_id( 10 );
    
    APEX_UTIL.create_user(
        p_user_name       => 'ADMIN',
        p_email_address   => '${APEX_EMAIL}',
        p_web_password    => '${APEX_PASSWORD}',
        p_developer_privs => 'ADMIN' );
        
    APEX_UTIL.set_security_group_id( null );
    COMMIT;
END;
/

@apex_rest_config.sql "${APEX_PASSWORD}" "${APEX_PASSWORD}"

alter user APEX_PUBLIC_USER identified by "${APEX_PASSWORD}" account unlock;
alter user APEX_REST_PUBLIC_USER identified by "${APEX_PASSWORD}" account unlock;

exit;
EOF

cd ..
rm -Rf apex