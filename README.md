This is the TheDOC Development and Testing environment in a Vagrant VM (using virtualbox) and Docker containers for the different OS and tool versions.

# vagrant

Vagrant is used to setup a Oracle Enterprise Linux 8 virtual machine with:
- 8 cpu cores
- 20 Gb of memory
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
- Oracle client (19c)
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
- [Patch 34065178](https://support.oracle.com/epmos/faces/PatchDetail?patchId=34065178&amp;)
- [Patch 28186730](https://support.oracle.com/epmos/faces/PatchDetail?patchId=28186730&amp;)
- [Patch 36485713](https://support.oracle.com/epmos/faces/PatchDetail?patchId=36485713&amp;)
- [Patch 36402397](https://support.oracle.com/epmos/faces/PatchDetail?patchId=36402397&amp;)
- [Patch 34542329](https://support.oracle.com/epmos/faces/PatchDetail?patchId=34542329&amp;)
- [Patch 36348444](https://support.oracle.com/epmos/faces/PatchDetail?patchId=36348444&amp;)
- [Patch 36316422](https://support.oracle.com/epmos/faces/PatchDetail?patchId=36316422&amp;)
- [Patch 36349529](https://support.oracle.com/epmos/faces/PatchDetail?patchId=36349529&amp;)
<!--- [Patch 35024228](https://support.oracle.com/epmos/faces/ui/patch/PatchDetail.jspx?parent=DOCUMENT&amp;sourceId=2832967.2&amp;patchId=35024228&amp;)-->

for OAS 8.2.0 (https://www.oracle.com/solutions/business-analytics/analytics-server/analytics-server.html#)
- [jdk-8u441-linux-x64.rpm ](https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html)
- [Oracle WebLogic Server 12.2.1.4 Fusion Middleware Infrastructure Installer](https://download.oracle.com/otn/nt/middleware/12c/122140/fmw_12.2.1.4.0_infrastructure_Disk1_1of1.zip?)
- [Oracle Analytics Server 2025 Linux](https://www.oracle.com/solutions/business-analytics/analytics-server/analytics-server.html#)
- [Patch 28186730](https://support.oracle.com/epmos/faces/PatchDetail?patchId=28186730&amp;)
- [Patch 37476485](https://support.oracle.com/epmos/faces/PatchDetail?patchId=37476485&amp;)
- [Patch 37388935](https://support.oracle.com/epmos/faces/PatchDetail?patchId=37388935&amp;)
- [Patch 34809489](https://support.oracle.com/epmos/faces/PatchDetail?patchId=34809489&amp;)
- [Patch 37284722](https://support.oracle.com/epmos/faces/PatchDetail?patchId=37284722&amp;)
- [Patch 37035947](https://support.oracle.com/epmos/faces/PatchDetail?patchId=37035947&amp;)
- [Patch 36946553](https://support.oracle.com/epmos/faces/PatchDetail?patchId=36946553&amp;)
- [Patch 36316422](https://support.oracle.com/epmos/faces/PatchDetail?patchId=36316422&amp;)

for ORDS
- [Java 11 (11.0.23_9)](https://adoptopenjdk.net/releases.html?variant=openjdk11&jvmVariant=hotspot)
- [Tomcat 9.0.90](https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.90/bin/apache-tomcat-9.0.90.tar.gz)
- [Oracle REST Data Services (ORDS) latest](https://download.oracle.com/otn_software/java/ords/ords-latest.zip)
- [Oracle Application Express (APEX) latest](https://download.oracle.com/otn_software/apex/apex-latest.zip)
- [Oracle SQLcl latest](https://download.oracle.com/otn_software/java/sqldeveloper/sqlcl-latest.zip)

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

# Problems with stuck CPU's
I kept getting messages of stuck CPU's in my linux guest. It looks like there was contention between Virtualbox and Hyper-V (even though it was switched off).
This fix worked for me: https://forums.virtualbox.org/viewtopic.php?f=25&t=97412

## Update new Win11 Laptop
After I upgraded my laptop to a new Intel Core 7 Ultra machine with a fresh windows installation the problems started reoccuring. I turns out that microsoft forces the activation of *Virtualization Based Security* in a new OEM install. This means that a Hyper-V VM is used as an extra layer of security. Unfortunately this interferes with Virtualbox. I had to use the following additional steps get Hyper-V turned of completely. If you have a managed laptop (like me) check with yopur administrator if this is acceptable.

To turn off the Windows Memory Integrity security feature, on the Windows host navigate to 
```
Start > Settings > Update & Security > Windows Security > Device security > Core isolation > Memory integrity.
```

Alternatively, you can disable VBS completely in the *Group Policy Editor* under 
```
Computer Configuration > Administrative Templates > System > Device Guard > Turn On Virtualization Based Security.
 Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All 
```

When VBS has been switched of you are still not done. Make the following changes to the registry
```
  Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard
      EnableVirtualizationBasedSecurity must be set to 0 
  Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CredentialGuard
      Enabled  must be set to 0 
  Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity
      Enabled  must be set to 0 
  Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\KernelShadowStacks
      Enabled  must be set to 0 
```

When all changes have been made reboot your system end Hyper-V, Core ISolation and Virtualization Based Security will be switched of.
You can verify it is off by running msinfo32.exe. If there is still a hypervisor running it will report this at the bottom of the right window
```
  A hypervisor has been detected. Features required for Hyper-V will not be displayed.
```

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
  Gerald Venzl (https://blogs.oracle.com/authors/gerald-venzl)


