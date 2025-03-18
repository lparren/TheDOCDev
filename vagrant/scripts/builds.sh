# This is an optional file used for my setup.

echo "******************************************************************************"
echo "Get latest oraclelinux:7/8-slim." `date`
echo "******************************************************************************"

# Get latest oraclelinux:7-slim
sudo docker pull oraclelinux:8-slim
sudo docker pull oraclelinux:9-slim

echo "******************************************************************************"
echo "Copy Oracle 19.3.0 software." `date`
echo "******************************************************************************"

cd /u01/dockerfiles/oracle/OracleDatabase/19.3.0
cp /vagrant/software/LINUX.X64_193000_db_home.zip .
cp /vagrant/software/apex-latest.zip .
cp /vagrant/software/db-sample-schemas-master.zip .
cp /vagrant/software/tpch-data-3.0.1.zip.301 ./tpch-data-3.0.1.zip
cp /vagrant/software/tpch-data-3.0.1.z0* .

echo "******************************************************************************"
echo "docker build Oracle 19.3.0 software" `date`
echo "THIS WILL TAKE A WHILE, PLEASE BE PATIENT"
echo "******************************************************************************"
# sudo docker compose --project-directory /u01/dockerfiles/oracle/ build --no-cache  --force-rm  oradb

echo "******************************************************************************"
echo "Copy Oracle 23ai-free software." `date`
echo "******************************************************************************"

cd /u01/dockerfiles/oracle/OracleDatabase/23aifree
cp /vagrant/software/apex-latest.zip .
cp /vagrant/software/tpch-data-3.0.1.zip.301 ./tpch-data-3.0.1.zip

echo "******************************************************************************"
echo "docker build Oracle 23ai-free software" `date`
echo "THIS WILL TAKE A WHILE, PLEASE BE PATIENT"
echo "******************************************************************************"
# sudo docker compose --project-directory /u01/dockerfiles/oracle/ build --no-cache  --force-rm  23ai

echo "******************************************************************************"
echo "Copy ORDS software." `date`
echo "******************************************************************************"

cd /u01/dockerfiles/oracle/ords
cp /vagrant/software/OpenJDK11U-jdk_x64_linux_hotspot_11.0.23_9.tar.gz .
cp /vagrant/software/apache-tomcat-9.0.90.tar.gz .
cp /vagrant/software/ords-latest.zip .
cp /vagrant/software/apex-latest.zip .
cp /vagrant/software/sqlcl-latest.zip . 

echo "******************************************************************************"
echo "docker build ORDS" `date`
echo "THIS WILL TAKE A WHILE, PLEASE BE PATIENT"
echo "******************************************************************************"
# sudo docker compose --project-directory /u01/dockerfiles/oracle/ build --no-cache  --force-rm  ords

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
# sudo docker compose --project-directory /u01/dockerfiles/oracle/ build --no-cache  --force-rm oas

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
# sudo docker compose --project-directory /u01/dockerfiles/oracle/ build --no-cache  --force-rm oas

echo "******************************************************************************"
echo "Copy OracleAnalyticsServer 8.2.0 software." `date`
echo "******************************************************************************"
cd /u01/dockerfiles/oracle/OracleAnalyticsServer/8.2.0
cp /vagrant/software/jdk-8u411-linux-x64.rpm .
cp /vagrant/software/Oracle_Analytics_Server_Linux_8.2.0.zip .
cp /vagrant/software/fmw_12.2.1.4.0_infrastructure_Disk1_1of1.zip .
cp /vagrant/software/p28186730_1394218_Generic.zip .
cp /vagrant/software/p37476485_122140_Generic.zip .
cp /vagrant/software/p37388935_122140_Generic.zip .
cp /vagrant/software/p34809489_122140_Generic.zip .
cp /vagrant/software/p37284722_122140_Generic.zip .
cp /vagrant/software/p37035947_122140_Generic.zip .
cp /vagrant/software/p36946553_122140_Generic.zip .
cp /vagrant/software/p36316422_122140_Generic.zip .

echo "******************************************************************************"
echo "docker build OracleAnalyticsServer 8.2.0." `date`
echo "THIS WILL TAKE A WHILE, PLEASE BE PATIENT"
echo "******************************************************************************"
# sudo docker compose --project-directory /u01/dockerfiles/oracle/ build --no-cache  --force-rm oas

# echo "******************************************************************************"
# echo "Copy RStudio software." `date`
# echo "******************************************************************************"
# cd /u01/dockerfiles/Rstudio
# cp /vagrant/software/ore-client-linux-x86-64-1.5.1.zip .
# cp /vagrant/software/ore-server-linux-x86-64-1.5.1.zip .
# cp /vagrant/software/ore-supporting-linux-x86-64-1.5.1.zip .
# cp /vagrant/software/rstudio-server-rhel-1.3.1093-x86_64.rpm .

# echo "******************************************************************************"
# echo "docker build RStudio Server 3.6.1." `date`
# echo "******************************************************************************"
# sudo docker-compose --project-directory /u01/dockerfiles/ build --no-cache  --force-rm rstudio


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


# echo "******************************************************************************"
# echo "docker build Portainer" `date`
# echo "******************************************************************************"
# cd /u01/dockerfiles
# #docker-compose build portainer

sudo docker image prune -f

echo "******************************************************************************"
echo "Finished"
echo " - cd /u01/dockerfiles/"
echo " - user docker-compose up oradb|oas|rstudio|dbt container"
echo "******************************************************************************"
