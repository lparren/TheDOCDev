# This is an optional file used for my setup.

echo "******************************************************************************"
echo "Get latest oraclelinux:8/9-slim." `date`
echo "******************************************************************************"

# Get latest oraclelinux:7-slim
sudo docker pull oraclelinux:8-slim
sudo docker pull oraclelinux:9-slim

echo "******************************************************************************"
echo "Generate TPC-H data" `date`
echo "******************************************************************************"
# orabuild tpch
docker compose --project-directory /u01/dockerfiles/oracle/ build --no-cache  --force-rm  tpch
docker compose --project-directory /u01/dockerfiles/oracle/ run --rm tpch -v -f
sudo rm -f /home/docker_user/project/tpch_data/*.zip
sudo zip -j /home/docker_user/project/tpch_data/tpch-data.zip /home/docker_user/project/tpch_data/*.tbl
# Add zip to every DB instance
cp /home/docker_user/project/tpch_data/tpch-data.zip /u01/dockerfiles/oracle/OracleDatabase/19.3.0/
cp /home/docker_user/project/tpch_data/tpch-data.zip /u01/dockerfiles/oracle/OracleDatabase/19c/
cp /home/docker_user/project/tpch_data/tpch-data.zip /u01/dockerfiles/oracle/OracleDatabase/23aifree/
cp /home/docker_user/project/tpch_data/tpch-data.zip /u01/dockerfiles/oracle/OracleDatabase/26ai/

# echo "******************************************************************************"
# echo "Generate TPC-DS data" `date`
# echo "******************************************************************************"
# orabuild tpch
docker compose --project-directory /u01/dockerfiles/oracle/ build --no-cache  --force-rm  tpcds
docker compose --project-directory /u01/dockerfiles/oracle/ run --rm tpcds -force -verbose Y -scale 1  -dir /data
sudo rm -f /home/docker_user/project/tpcds_data/*.zip
sudo zip -j /home/docker_user/project/tpcds_data/tpcds-data.zip /home/docker_user/project/tpcds_data/*.dat
# Add zip to every DB instance
cp /home/docker_user/project/tpcds_data/tpcds-data.zip /u01/dockerfiles/oracle/OracleDatabase/19.3.0/
cp /home/docker_user/project/tpcds_data/tpcds-data.zip /u01/dockerfiles/oracle/OracleDatabase/19c/
cp /home/docker_user/project/tpcds_data/tpcds-data.zip /u01/dockerfiles/oracle/OracleDatabase/23aifree/
cp /home/docker_user/project/tpcds_data/tpcds-data.zip /u01/dockerfiles/oracle/OracleDatabase/26ai/

echo "******************************************************************************"
echo "Copy Oracle 19.3.0 software." `date`
echo "******************************************************************************"

cd /u01/dockerfiles/oracle/OracleDatabase/19.3.0
cp /vagrant/software/LINUX.X64_193000_db_home.zip .
cp /vagrant/software/apex-latest.zip .
cp /vagrant/software/db-sample-schemas-23.3.zip .

# echo "******************************************************************************"
# echo "docker build Oracle 19.3.0 software" `date`
# echo "THIS WILL TAKE A WHILE, PLEASE BE PATIENT"
# echo "******************************************************************************"
# docker compose --project-directory /u01/dockerfiles/oracle/ build --no-cache  --force-rm  oradb

echo "******************************************************************************"
echo "Copy Oracle 19c software." `date`
echo "******************************************************************************"

cd /u01/dockerfiles/oracle/OracleDatabase/19c
cp /vagrant/software/oracle-database-ee-19c-1.0-1.x86_64.rpm .
cp /vagrant/software/apex-latest.zip .
cp /vagrant/software/db-sample-schemas-19c.zip .

# echo "******************************************************************************"
# echo "docker build Oracle 19.3.0 software" `date`
# echo "THIS WILL TAKE A WHILE, PLEASE BE PATIENT"
# echo "******************************************************************************"
# docker compose --project-directory /u01/dockerfiles/oracle/ build --no-cache  --force-rm  oradb


echo "******************************************************************************"
echo "Copy Oracle 26ai software." `date`
echo "******************************************************************************"

cd /u01/dockerfiles/oracle/OracleDatabase/26ai
cp /vagrant/software/oracle-ai-database-ee-26ai-1.0-1.el9.x86_64.rpm .
cp /vagrant/software/apex-latest.zip .
cp /vagrant/software/db-sample-schemas-23.3.zip .

# echo "******************************************************************************"
# echo "docker build Oracle 19.3.0 software" `date`
# echo "THIS WILL TAKE A WHILE, PLEASE BE PATIENT"
# echo "******************************************************************************"
# docker compose --project-directory /u01/dockerfiles/oracle/ build --no-cache  --force-rm  26ai


echo "******************************************************************************"
echo "Copy Oracle 23ai-free software." `date`
echo "******************************************************************************"

cd /u01/dockerfiles/oracle/OracleDatabase/23aifree
cp /vagrant/software/apex-latest.zip .


# echo "******************************************************************************"
# echo "docker build Oracle 23ai-free software" `date`
# echo "THIS WILL TAKE A WHILE, PLEASE BE PATIENT"
# echo "******************************************************************************"
# docker compose --project-directory /u01/dockerfiles/oracle/ build --no-cache  --force-rm  23ai

# echo "******************************************************************************"
# echo "Copy ORDS software." `date`
# echo "******************************************************************************"

# cd /u01/dockerfiles/oracle/ords
# cp /vagrant/software/OpenJDK11U-jdk_x64_linux_hotspot_11.0.23_9.tar.gz .
# cp /vagrant/software/apache-tomcat-9.0.90.tar.gz .
# cp /vagrant/software/ords-latest.zip .
# cp /vagrant/software/apex-latest.zip .
# cp /vagrant/software/sqlcl-latest.zip .

# echo "******************************************************************************"
# echo "docker build ORDS" `date`
# echo "THIS WILL TAKE A WHILE, PLEASE BE PATIENT"
# echo "******************************************************************************"
# docker compose --project-directory /u01/dockerfiles/oracle/ build --no-cache  --force-rm  ords

# echo "******************************************************************************"
# echo "Copy OracleAnalyticsServer 6.4.0 software." `date`
# echo "******************************************************************************"
# cd /u01/dockerfiles/oracle/OracleAnalyticsServer/6.4.0
# cp /vagrant/software/jdk-8u321-linux-x64.rpm .
# cp /vagrant/software/fmw_12.2.1.4.0_infrastructure_Disk1_1of1.zip .
# cp /vagrant/software/Oracle_Analytics_Server_Linux_2022\(6.4\).zip ./Oracle_Analytics_Server_Linux_6.4.0.zip
# cp /vagrant/software/p28186730_139428_Generic.zip .
# cp /vagrant/software/p33618954_122140_Generic.zip .
# cp /vagrant/software/p33751264_122140_Generic.zip .
# cp /vagrant/software/p33735326_12214220105_Generic.zip .
# cp /vagrant/software/p33791665_12214220105_Generic.zip .

# echo "******************************************************************************"
# echo "docker build OracleAnalyticsServer 6.4.0." `date`
# echo "******************************************************************************"
# sudo docker-compose --project-directory /u01/dockerfiles/oracle/ build --no-cache  --force-rm oas


# echo "******************************************************************************"
# echo "Copy OracleAnalyticsServer 7.0.0 software." `date`
# echo "******************************************************************************"
# cd /u01/dockerfiles/oracle/OracleAnalyticsServer/7.0.0
# cp /vagrant/software/jdk-8u361-linux-x64.rpm .
# cp /vagrant/software/Oracle_Analytics_Server_Linux_7.0.0.zip .
# cp /vagrant/software/fmw_12.2.1.4.0_infrastructure_Disk1_1of1.zip .
# cp /vagrant/software/p28186730_1394211_Generic.zip .
# cp /vagrant/software/p34065178_122140_Generic.zip .
# cp /vagrant/software/p34974729_122140_Generic.zip .
# cp /vagrant/software/p34839859_122140_Generic.zip .
# cp /vagrant/software/p34542329_122140_Generic.zip .
# cp /vagrant/software/p34944256_122140_Generic.zip .
# cp /vagrant/software/p33950717_122140_Generic.zip .
# cp /vagrant/software/p34549208_122140_Generic.zip .

# echo "******************************************************************************"
# echo "docker build OracleAnalyticsServer 7.0.0." `date`
# echo "THIS WILL TAKE A WHILE, PLEASE BE PATIENT"
# echo "******************************************************************************"
# docker compose --project-directory /u01/dockerfiles/oracle/ build --no-cache  --force-rm oas

# echo "******************************************************************************"
# echo "Copy OracleAnalyticsServer 7.6.0 software." `date`
# echo "******************************************************************************"
# cd /u01/dockerfiles/oracle/OracleAnalyticsServer/7.6.0
# cp /vagrant/software/jdk-8u411-linux-x64.rpm .
# cp /vagrant/software/Oracle_Analytics_Server_Linux_7.6.0.zip .
# cp /vagrant/software/fmw_12.2.1.4.0_infrastructure_Disk1_1of1.zip .
# cp /vagrant/software/p28186730_1394215_Generic.zip .
# cp /vagrant/software/p34065178_122140_Generic.zip .
# cp /vagrant/software/p36485713_122140_Generic.zip .
# cp /vagrant/software/p36402397_122140_Generic.zip .
# cp /vagrant/software/p34542329_122140_Generic.zip .
# cp /vagrant/software/p36348444_122140_Generic.zip .
# cp /vagrant/software/p36316422_122140_Generic.zip .
# cp /vagrant/software/p36349529_122140_Generic.zip .

# echo "******************************************************************************"
# echo "docker build OracleAnalyticsServer 7.6.0." `date`
# echo "THIS WILL TAKE A WHILE, PLEASE BE PATIENT"
# echo "******************************************************************************"
# docker compose --project-directory /u01/dockerfiles/oracle/ build --no-cache  --force-rm oas

echo "******************************************************************************"
echo "Copy OracleAnalyticsServer 8.2.0 software." `date`
echo "******************************************************************************"
cd /u01/dockerfiles/oracle/OracleAnalyticsServer/8.2.0
cp /vagrant/software/jdk-8u481-linux-x64.rpm .
cp /vagrant/software/Oracle_Analytics_Server_Linux_8.2.0.zip .
cp /vagrant/software/fmw_12.2.1.4.0_infrastructure_Disk1_1of1.zip .
cp /vagrant/software/p28186730_1394222_Generic.zip .
cp /vagrant/software/p37476485_122140_Generic.zip .
cp /vagrant/software/p37388935_122140_Generic.zip .
cp /vagrant/software/p34809489_122140_Generic.zip .
cp /vagrant/software/p37284722_122140_Generic.zip .
cp /vagrant/software/p37035947_122140_Generic.zip .
cp /vagrant/software/p36946553_122140_Generic.zip .
cp /vagrant/software/p36316422_122140_Generic.zip .

# echo "******************************************************************************"
# echo "docker build OracleAnalyticsServer 8.2.0." `date`
# echo "THIS WILL TAKE A WHILE, PLEASE BE PATIENT"
# echo "******************************************************************************"
# docker compose --project-directory /u01/dockerfiles/oracle/ build --no-cache  --force-rm oas

# echo "******************************************************************************"
# echo "Copy DBT software." `date`
# echo "******************************************************************************"
# cd /u01/dockerfiles/dbt
# cp /vagrant/software/oracle-instantclient-basic-21.1.0.0.0-1.x86_64.rpm .
# cp /vagrant/software/oracle-instantclient-devel-21.1.0.0.0-1.x86_64.rpm .
# cp /vagrant/software/oracle-instantclient-jdbc-21.1.0.0.0-1.x86_64.rpm .
# cp /vagrant/software/oracle-instantclient-odbc-21.1.0.0.0-1.x86_64.rpm .
# cp /vagrant/software/oracle-instantclient-sqlplus-21.1.0.0.0-1.x86_64.rpm .

# echo "******************************************************************************"
# echo "docker build DBT" `date`
# echo "******************************************************************************"
# #sudo docker build --force-rm=true --no-cache=true   -t thedoc/dbt:0.19.0  .

sudo docker image prune -f

echo "******************************************************************************"
echo "Finished"
echo " - docker compose up oradb|oas|23aifree|26ai"
echo "******************************************************************************"
