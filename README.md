This is the TheDOC Development and Testing environment in a Vagrant VM (using virtualbox) and Docker containers for the different OS and tool versions.

# vagrant

Vagrant is used to setup a Oracle Enterprise Linux 8 virtual machine with:
- 4 cpu cores
- 20 Gb of memory
- 250 Gb of disk space (in total)
- ssh forwatding (incl X11)
- ports forwarded for several tools:
  - ssh
  - Oracle DB
  - Oracle Analytics Server
  - Spark

## Required Software

Download and install the latest version of
* [Vagrant](https://www.vagrantup.com/downloads.html)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Build
### Install the vagrant plug-ins (virtualbox guest, env)

```
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-env
```

### configure
Set the appropirate values in the .env file for the VM

### Start Virtal machine
```
vagrant up
```

You can log into the VM on ssh port 2222 (default port assigned by vagrant, when more vm's are active this can change) with users: docker or root (the password for all accounts is vagrant). X11 forwarding has been enabled in the vm and docker is sudo enabled.

### Oracle Software
In addition you will need to download all the required software and put it into the "software" directory, so it can be copied into place and used during the builds. (Some downloads are used for more installs, you only need to download it once :-))

for Oracle Database
- jdk-8u241-linux-x64.rpm
- LINUX.X64_193000_db_home.zip

for OAS 5.5.0
- jdk-8u241-linux-x64.rpm
- V983368-01.zip
- V988574-01.zip

for OAS 5.9.0
- [jdk-8u281-linux-x64.rpm](https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html)
- [Oracle WebLogic Server 12c (12.2.1.4) Generic - Download the file "Fusion Middleware Infrastructure Installer (1.5 GB)"](https://www.oracle.com/middleware/technologies/weblogic-server-downloads.html#license-lightbox)
- [Patch 30657796](https://www.oracle.com/solutions/business-analytics/analytics-server/analytics-server.html#license-lightbox)
- [Oracle_Analytics_Server_Linux_5.9.0.zip](https://www.oracle.com/solutions/business-analytics/analytics-server/analytics-server.html#license-lightbox)


for OAS 6.4.0
- jdk-8u281-linux-x64.rpm 
- V1019848-01.zip
- fmw_12.2.1.4.0_infrastructure_Disk1_1of1.zip

for ORDS
- [Java 11](https://adoptopenjdk.net/releases.html?variant=openjdk11&jvmVariant=hotspot)
- [Tomcat 9.0.5](https://tomcat.apache.org/download-90.cgi)
- [Oracle REST Data Services (ORDS) 21.x](http://www.oracle.com/technetwork/developer-tools/rest-data-services/downloads/index.html)
- [Oracle Application Express (APEX) 21.x - for images only](http://www.oracle.com/technetwork/developer-tools/apex/downloads/index.html)
- [Oracle SQLcl 21.x](http://www.oracle.com/technetwork/developer-tools/sqlcl/downloads/index.html)

for RStudio
- oracle-instantclient-basic-21.1.0.0.0-1.x86_64.rpm
- oracle-instantclient-devel-21.1.0.0.0-1.x86_64.rpm
- oracle-instantclient-jdbc-21.1.0.0.0-1.x86_64.rpm
- oracle-instantclient-odbc-21.1.0.0.0-1.x86_64.rpm
- oracle-instantclient-sqlplus-21.1.0.0.0-1.x86_64.rpm
- ore-client-linux-x86-64-1.5.1.zip
- ore-server-linux-x86-64-1.5.1.zip
- ore-supporting-linux-x86-64-1.5.1.zip
- rstudio-server-rhel-1.3.1093-x86_64.rpm

With all software in place login to the virtual machine and start the build script (only OAS 6.4.0 is enabled by default)
```
/vagrant/scripts/build.sh
```
after build there will be a database, OAS and RStudio image:

```
[docker_user@localhost ~]$ docker images

REPOSITORY        TAG         IMAGE ID       CREATED          SIZE
thedoc/rstudio    3.6.1       0eabf923874f   59 minutes ago   2.27GB
oracle/oas        6.4.0       9cd511707c74   23 hours ago     21.7GB
oracle/database   19.3.0-ee   82faa400709a   24 hours ago     7.51GB
oraclelinux       7-slim      fd78c5e25c7f   5 days ago       133MB
oraclelinux       8-slim      a9c84545e7ad   5 days ago       110MB

```
# You can start the containers individualy or though docker-compose
## Docker-compose
docker-compose takes care of dependencies, networking, etc.
Aliasses have been defined to make starting containers easier.

- dcup [oas|oradb|rstiudio]     - create and start containers
- dcstart [oas|oradb|rstiudio]  - start containers
- dcstop [oas|oradb|rstiudio]   - stop containers
- dclog [oas|oradb|rstiudio]    - show container log

'''
CONTAINER ID   IMAGE                       COMMAND                  CREATED          STATUS                 PORTS                                                                                  NAMES
856984ddb35b   thedoc/rstudio:3.6.1        "/bin/sh -c 'rstudio…"   20 seconds ago   Up 18 seconds          0.0.0.0:8787->8787/tcp, :::8787->8787/tcp                                              dockerfiles_rstudio_1
5855f82a2093   oracle/oas:6.4.0            "/bin/sh -c ${ORACLE…"   21 hours ago     Up 3 hours             0.0.0.0:9500-9514->9500-9514/tcp, :::9500-9514->9500-9514/tcp                          dockerfiles_oas_1
e33e3e25a4fe   oracle/database:19.3.0-ee   "/bin/sh -c 'exec $O…"   22 hours ago     Up 3 hours (healthy)   0.0.0.0:1521->1521/tcp, :::1521->1521/tcp, 0.0.0.0:5500->5500/tcp, :::5500->5500/tcp   dockerfiles_oradb_1
'''

## Individualy
### Create the network and volume for the database and oas container
```
sudo docker network create --subnet=172.18.0.0/16 oracle_network
sudo docker volume create --name ora1930_oradata --opt type=none --opt device=/u01/volumes/ora1930_oradata/ --opt o=bind
```
### Start Oracle database container
```
 sudo docker run --name ora1930 \
  --detach \
  --network oracle_network \
  --ip 172.18.0.22 \
  -p 1521:1521 -p 5500:5500 \
  -e ORACLE_SID=db1930 \
  -e ORACLE_PDB=pdb1930 \
  -e ORACLE_PWD=oracle \
  --mount source=ora1930_oradata,destination=/opt/oracle/oradata \
  oracle/database:19.3.0-ee

docker logs -f ora1930
```

### Start Oracle OAS 5.5.0 container
```
sudo docker run --name oas55 \
  --detach \
  --network=oracle_network \
  -p 9500-9514:9500-9514 \
  --stop-timeout 600 \
  -e "BI_CONFIG_RCU_DBSTRING=172.18.0.22:1521:pdb1930" \
  -e "BI_CONFIG_RCU_PWD=oracle" \
  oracle/oas:5.5.0

docker logs -f oas55
```

### Start Oracle OAS 5.9.0 container
```
sudo docker run --name oas59 \
  --detach \
  --network=oracle_network \
  -p 9500-9514:9500-9514 \
  --stop-timeout 600 \
  -e "BI_CONFIG_RCU_DBSTRING=172.18.0.22:1521:pdb1930" \
  -e "BI_CONFIG_RCU_PWD=oracle" \
  oracle/oas:5.9.0

docker logs -f oas59
```

### Start RStudio container
```
sudo docker run --name rstudio \
  --detach \
  --network oracle_network \
  -p 8787:8787 \
  thedoc/rstudio:3.6.1

docker logs -f rstudio
```

### Start DBT
```
docker run -ti --name dbt \
  --network oracle_network \
  thedoc/dbt:0.19.0

docker logs -f dbt
```
# Problems with stuck CPU's
I kept getting messages of stuck CPU's in my linux guest. It looks like there was contention between Virtualbox and Hyper-V (even thoud it was switched off).
This fix worked for me: https://forums.virtualbox.org/viewtopic.php?f=25&t=97412