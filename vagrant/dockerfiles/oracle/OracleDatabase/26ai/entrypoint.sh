#!/bin/bash
# Path to the lock file
DB_CONFIG_LOCK="/opt/oracle/oradata/db_configured"

if [ ! -f "$DB_CONFIG_LOCK" ]; then
    echo "First boot detected. Starting Oracle 26ai configuration..."
    
    # Run the RPM-provided configuration script as root
    # This creates the ORCLCDB database by default
    /etc/init.d/oracledb_ORCLCDB-26ai configure | tee >(grep -m 1 --line-buffered "100%")

# Define the target file path


# Append the commands using a heredoc
cat << EOF >> /home/oracle/.bash_profile
export ORACLE_HOME=$ORACLE_HOME
export ORACLE_SID=$ORACLE_SID
export ORACLE_PDB=$ORACLE_PDB
export PATH=\$ORACLE_HOME/bin:\$PATH
EOF

# Ensure the oracle user still owns the file
chown oracle:oinstall /home/oracle/.bash_profile

su - oracle <<EOF
    sqlplus -s / as sysdba 
        ALTER USER SYS IDENTIFIED BY "$ORACLE_PWD";
        ALTER USER SYSTEM IDENTIFIED BY "$ORACLE_PWD";
        ALTER SESSION SET CONTAINER=$ORACLE_PDB;
        ALTER USER PDBADMIN IDENTIFIED BY "$ORACLE_PWD";
        ALTER PLUGGABLE DATABASE ALL OPEN;
        EXIT;
EOF

    # Mark as configured
    touch "$DB_CONFIG_LOCK"
    echo "Database configuration complete."

    # Execute custom provided setup scripts
su - oracle << EOF
    export ORACLE_PWD=$ORACLE_PWD;
    export APEX_FILE=$APEX_FILE;
    export APEX_EMAIL=$APEX_EMAIL;
    export APEX_PASSWORD=$APEX_PASSWORD;
    /tmp/runUserScripts.sh /tmp/userScripts
EOF

    # Oracle has increased the security in recent versions, which can cause issues with some clients. 
    # to prevent connection errors from OAS we need to allow weak DN matching in sqlnet.ora
cat <<EOF >> ORACLE_HOME/network/admin/sqlnet.ora
SSL_SERVER_DN_MATCH = NO
SSL_ALLOW_WEAK_DN_MATCH = TRUE
EOF
else
    echo "Database already configured. Skipping setup."
fi

/etc/init.d/oracledb_ORCLCDB-26ai start
# Note: The database should already be open, but we can ensure it is by connecting as sysdba and issuing the command again
su - oracle <<EOF
    sqlplus -s / as sysdba
        ALTER PLUGGABLE DATABASE ALL OPEN;
        EXIT;
EOF

su - oracle <<EOF
    if /opt/oracle/checkDBStatus.sh; then 
        echo "#########################"
        echo "DATABASE IS READY TO USE!"
        echo "#########################"
    else
        echo "#############################"
        echo "DATABASE IS NOT READY YET. $?"
        echo "#############################"
    fi
EOF


# Keep the container running
tail -f /opt/oracle/cfgtoollogs/dbca/ORCLCDB/ORCLCDB.log