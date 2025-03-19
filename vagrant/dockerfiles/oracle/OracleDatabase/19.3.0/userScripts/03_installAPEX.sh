echo "*******************************************************"
echo "*** Installing db sample schemas                    ***"
echo "*******************************************************"
cd /opt/oracle
unzip $APEX_FILE
cd apex

sqlplus / as sysdba <<EOF
alter session set container = ${ORACLE_PDB};
create tablespace apex datafile '/opt/oracle/oradata/DB1930/PDB1930/apex01.dbf' size 1m autoextend on next 1m;
@apexins.sql APEX APEX TEMP /i/

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
--@apex_epg_config.sql ${ORACLE_HOME}

alter user APEX_PUBLIC_USER identified by "${APEX_PASSWORD}" account unlock;
alter user APEX_REST_PUBLIC_USER identified by "${APEX_PASSWORD}" account unlock;

exit;
EOF