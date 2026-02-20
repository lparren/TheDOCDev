echo "*******************************************************"
echo "*** Installing db sample schemas                    ***"
echo "*******************************************************"
cd /tmp
unzip db-sample-schemas-23.3.zip
cd db-sample-schemas-23.3
sqlplus -s sys/${ORACLE_PWD}@${ORACLE_PDB} as sysdba @./human_resources/hr_install.sql <<EOF
hr

EOF
sqlplus -s sys/${ORACLE_PWD}@${ORACLE_PDB} as sysdba @./customer_orders/co_install.sql <<EOF
co

EOF
sqlplus -s sys/${ORACLE_PWD}@${ORACLE_PDB} as sysdba @./sales_history/sh_install.sql <<EOF
co

EOF
