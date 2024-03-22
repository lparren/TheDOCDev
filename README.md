This is the TheDOC Development and Testing environment in a Vagrant VM (using virtualbox) and Docker containers for the different OS and tool versions.

# vagrant

Vagrant is used to setup a Oracle Enterprise Linux 8 virtual machine with:
- 4 cpu cores
- 16 Gb of memory
- 250 Gb of disk space (in total)
- ssh forwatding (incl X11)
- ports forwarded for several tools:
  - ssh
  - Oracle DB
  - Oracle Analytics Server
  <!-- - Spark -->

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

The following software will be installed automatically in user docker_user:
- Oracle client (21c)
- Visual code
- Oracle SQL Developer Extension for VSCode
<!-- - Pycharm community edition -->
- Anaconda
<!-- - Jupyter -->

The folder dockerfiles is copied into the VM  to folder /u01. there a re subfolders
  - meltano
    testing the [Meltano](https://meltano.com/) application 
  - oracle
    Containers for Oracle database and Analytics Server
  - postgres
    Testing postgres and dbt


You can log into the VM on ssh port 2222 (default port assigned by vagrant, when more vm's are active this can change) with users: docker_user, vagrant or root (the password for all accounts is vagrant or use the private_key which is created in folder ./TheDOCDev/vagrant/.vagrant/machines/default/virtualbox). X11 forwarding has been enabled in the vm and docker_user is sudo enabled.

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


for OAS 6.4.0 (https://www.oracle.com/solutions/business-analytics/analytics-server/analytics-server.html#license-lightbox)
- jdk-8u321-linux-x64.rpm
- Oracle WebLogic Server 12c (12.2.1.4) Generic - Download the file "Fusion Middleware Infrastructure Installer (1.5 GB)"
- Oracle_Analytics_Server_Linux_2022(6.4).zip (after downloading rename to Oracle_Analytics_Server_Linux_6.4.0.zip)
- p28186730_139428_Generic.zip
- p33618954_122140_Generic.zip
- p33751264_122140_Generic.zip
- p33735326_12214220105_Generic.zip
- p33791665_12214220105_Generic.zip

for OAS 7.0.0 (https://www.oracle.com/solutions/business-analytics/analytics-server/analytics-server.html#)
- [Java SE Development Kit 8u](https://www.oracle.com/java/technologies/downloads/?#java8)
- [Oracle WebLogic Server 12.2.1.4 Fusion Middleware Infrastructure Installer](https://download.oracle.com/otn/nt/middleware/12c/122140/fmw_12.2.1.4.0_infrastructure_Disk1_1of1.zip?)
- [Oracle Analytics Server 2023 Update Installer](https://www.oracle.com/solutions/business-analytics/analytics-server/analytics-server.html?)
- [Patch 28186730](https://support.oracle.com/epmos/faces/PatchDetail?patchId=28186730&amp;)
- [Patch 34974729](https://support.oracle.com/epmos/faces/PatchDetail?parent=DOCUMENT&amp;sourceId=2832967.2&amp;patchId=34974729&amp;)
- [Patch 34839859](https://support.oracle.com/epmos/faces/PatchDetail?parent=DOCUMENT&amp;sourceId=2832967.2&amp;patchId=34839859&amp;)
- [Patch 34542329](https://support.oracle.com/epmos/faces/PatchDetail?parent=DOCUMENT&amp;sourceId=2832967.2&amp;patchId=34542329&amp;)
- [Patch 34944256](https://support.oracle.com/epmos/faces/PatchDetail?parent=DOCUMENT&amp;sourceId=2832967.2&amp;patchId=34944256&amp;)
- [Patch 33950717](https://support.oracle.com/epmos/faces/PatchDetail?parent=DOCUMENT&amp;sourceId=2832967.2&amp;patchId=33950717&amp;)
- [Patch 34549208](https://support.oracle.com/epmos/faces/PatchDetail?parent=DOCUMENT&amp;sourceId=2832967.2&amp;patchId=34549208&amp;)

for OAS 7.6.0 (https://www.oracle.com/solutions/business-analytics/analytics-server/analytics-server.html#)
- [jdk-8u401-linux-x64.rpm ](https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html)
- [Oracle WebLogic Server 12.2.1.4 Fusion Middleware Infrastructure Installer](https://download.oracle.com/otn/nt/middleware/12c/122140/fmw_12.2.1.4.0_infrastructure_Disk1_1of1.zip?)
- [Oracle Analytics Server 2024 Linux](https://www.oracle.com/solutions/business-analytics/analytics-server/analytics-server.html#)
- [Patch 28186730](https://support.oracle.com/epmos/faces/PatchDetail?patchId=28186730&amp;)
- [Patch 34974729](https://support.oracle.com/epmos/faces/PatchDetail?parent=DOCUMENT&amp;sourceId=2832967.2&amp;patchId=34974729&amp;)
- [Patch 34839859](https://support.oracle.com/epmos/faces/PatchDetail?parent=DOCUMENT&amp;sourceId=2832967.2&amp;patchId=34839859&amp;)
- [Patch 34542329](https://support.oracle.com/epmos/faces/PatchDetail?parent=DOCUMENT&amp;sourceId=2832967.2&amp;patchId=34542329&amp;)
- [Patch 34944256](https://support.oracle.com/epmos/faces/PatchDetail?parent=DOCUMENT&amp;sourceId=2832967.2&amp;patchId=34944256&amp;)
- [Patch 33950717](https://support.oracle.com/epmos/faces/PatchDetail?parent=DOCUMENT&amp;sourceId=2832967.2&amp;patchId=33950717&amp;)
- [Patch 34549208](https://support.oracle.com/epmos/faces/PatchDetail?parent=DOCUMENT&amp;sourceId=2832967.2&amp;patchId=34549208&amp;)
<!--- [Patch 35024228](https://support.oracle.com/epmos/faces/ui/patch/PatchDetail.jspx?parent=DOCUMENT&amp;sourceId=2832967.2&amp;patchId=35024228&amp;)-->

<!-- for ORDS
- [Java 11](https://adoptopenjdk.net/releases.html?variant=openjdk11&jvmVariant=hotspot)
- [Tomcat 9.0.5](https://tomcat.apache.org/download-90.cgi)
- [Oracle REST Data Services (ORDS) 21.x](http://www.oracle.com/technetwork/developer-tools/rest-data-services/downloads/index.html)
- [Oracle Application Express (APEX) 21.x - for images only](http://www.oracle.com/technetwork/developer-tools/apex/downloads/index.html)
- [Oracle SQLcl 21.x](http://www.oracle.com/technetwork/developer-tools/sqlcl/downloads/index.html) -->

for RStudio
- ore-client-linux-x86-64-1.5.1.zip
- ore-server-linux-x86-64-1.5.1.zip
- ore-supporting-linux-x86-64-1.5.1.zip
- rstudio-server-rhel-1.3.1093-x86_64.rpm

With all software in place login to the virtual machine and start the build script (only OAS 7.6.0 is enabled by default)
```
/vagrant/scripts/build.sh
```
after build there will be a database, OAS image:

```
[docker_user@localhost ~]$ docker images

REPOSITORY            TAG         IMAGE ID       CREATED          SIZE
oracle/oas            7.6.0       1d699499db62   15 minutes ago   29.3GB
oracle/database       19.3.0-ee   08351437f741   2 hours ago      7.61GB
oraclelinux           8-slim      656791178b56   13 days ago      116MB
lazyteam/lazydocker   latest      6518a6686572   22 months ago    55.7MB
```

# You can start the containers individualy or through docker compose
## Docker compose
docker compose takes care of dependencies, networking, etc.
Aliasses have been defined to make starting containers easier.

Aliasses:
  - lzd:    [lazydocker](https://github.com/jesseduffield/lazydocker/tree/master) - A simple terminal UI for both docker and docker-compose, written in Go with the gocui library.
  - mlt:    Start meltano docker container interactive
  - mltui:  Start meltano docker container in the backgroup
  - oracle
    - orastart: [oradb|oas|23cfree|dbt] Starts a container: database, Analytics server, 23cfree database or dbt (oas uses a oradb 19.3 instance) 
    - orastop:  [oradb|oas|23cfree|dbt] Stops a container 
    - oaup:     [oradb|oas|23cfree|dbt] Creates a container instance from an image
    - oralog:   [oradb|oas|23cfree|dbt] Shows the logging for a container
  - Postgresql
    - pgstart:  [db|pgadmin|dbt] Start postgresql container: db is the database, pgadmin: the postgres admintool, dbt  
    - pgstop:   [db|pgadmin|dbt] Stops the container  
    - pgup:     [db|pgadmin|dbt] Creates a container instance from an image
    - pglog:    [db|pgadmin|dbt] Shows the logging for a container

### First run
On first run start oraup oreadb. When the logging shows DATABASE READY run oraup oas.

```
CONTAINER ID   IMAGE                       COMMAND                  CREATED             STATUS                       PORTS                                                                                  NAMES
1fd5d829e65b   oracle/oas:7.6.0            "/bin/sh -c ${ORACLE…"   34 minutes ago      Up 34 minutes                0/tcp, 0.0.0.0:9500-9514->9500-9514/tcp, :::9500-9514->9500-9514/tcp                   oracle-oas-1
827582584ee2   oracle/database:19.3.0-ee   "/bin/sh -c 'exec $O…"   About an hour ago   Up About an hour (healthy)   0.0.0.0:1521->1521/tcp, :::1521->1521/tcp, 0.0.0.0:5500->5500/tcp, :::5500->5500/tcp   oracle-oradb-1
```

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
I kept getting messages of stuck CPU's in my linux guest. It looks like there was contention between Virtualbox and Hyper-V (even though it was switched off).
This fix worked for me: https://forums.virtualbox.org/viewtopic.php?f=25&t=97412


# Problems with guest additions after upgrade
Whenever I upgrade virtualbox the vagrant-vbguest plugin sometimes will not install the new version and this will lead to a mounting error during startup. I fixed it with these steps:
  - vagrant up 
  - connect wit ssh and execute the following command (substitute version with your current version)  
``` 
    sudo ln -s /opt/VBoxGuestAdditions-<version>/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
```
  - reinstall the plugin
```
    vagrant plugin install vagrant-vbguest
```
  - Force reinstall of the geuest additions
```
    vagrant vbguest --do install
```
  - reload the virtual machine
```
    vagrant reload
```

  vagrant keeps report the old version during startup (6.1.32) while vagrant-vbguest reports the new one (7.0.2). Everything seems to work correctly though.

# Standing on the shoulders of giants
Thank you very much:
  Tim Hall (https://www.oracle-base.com)
  Gianni Ceresa (https://gianniceresa.com/)
