sh /vagrant/scripts/prepare_disks.sh

echo "******************************************************************************"
echo "Prepare Yum with the latest repos." `date`
echo "******************************************************************************"
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
dnf install -y dnf-utils zip unzip git
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf config-manager --enable ol8_addons
dnf install -y oracle-epel-release-el8
dnf install -y xorg-x11-xauth  x11vnc

# Enable X11 forwarding
sed -i -e "s|#X11Forwarding yes|X11Forwarding yes|g"   /etc/ssh/sshd_config
sed -i -e "s|#X11DisplayOffset 10|X11DisplayOffset 10|g"   /etc/ssh/sshd_config
sed -i -e "s|#X11UseLocalhost yes|X11UseLocalhost yes|g"   /etc/ssh/sshd_config

echo "******************************************************************************"
echo "Install google chrome" `date`
echo "******************************************************************************"
wget -nv https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
dnf install -y ./google-chrome-stable_current_*.rpm
rm -f ./google-chrome-stable_current_*.rpm

# echo "******************************************************************************"
# echo "Install Anaconda" `date`
# echo "******************************************************************************"
#
mkdir /opt/anaconda
wget -nv https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p /opt/miniconda
export PATH=/opt/miniconda/bin:$PATH
conda config --set always_yes yes --set changeps1 no
conda info -a
groupadd condagrp
chgrp -R condagrp /opt/miniconda
chmod 770 -R /opt/miniconda
ln -s /opt/miniconda/etc/profile.d/conda.sh /etc/profile.d/conda.sh

echo "******************************************************************************"
echo "Install Docker." `date`
echo "******************************************************************************"
dnf install -y docker-ce --nobest
dnf update -y

echo "******************************************************************************"
echo "Prepare the drive for the docker images." `date`
echo "******************************************************************************"
ls /dev/sd*
echo -e "n\np\n1\n\n\nw" | fdisk /dev/sdc

ls /dev/sd*
docker-storage-config -s btrfs -d /dev/sdc1

#echo "******************************************************************************"
#echo "Enable experimental features." `date`
#echo "******************************************************************************"
#sed -i -e "s|OPTIONS='--selinux-enabled'|OPTIONS='--selinux-enabled --experimental=true'|g" /etc/sysconfig/docker

echo "******************************************************************************"
echo "Enable Docker." `date`
echo "******************************************************************************"
systemctl enable docker.service
systemctl start docker.service
systemctl status docker.service

echo "******************************************************************************"
echo "Create non-root docker user." `date`
echo "******************************************************************************"
groupadd -g 1042 docker_fg
useradd -G docker_fg,condagrp,docker docker_user
echo "docker_user:vagrant" | chpasswd
mkdir -p /u01/volumes/ora1930_oradata
mkdir -p /u01/volumes/oas59_data
chown -R docker_user:docker_fg /u01
chmod -R 777 /u01/volumes
chmod -R g+s /u01/volumes

# Add users so host reports process ownership properly. Not required.
useradd -u 500 oracle
echo "oracle:oracle" | chpasswd

echo "docker_user  ALL=(ALL)  NOPASSWD: ALL" >> /etc/sudoers
echo "docker_user  ALL=(ALL)  NOPASSWD: /usr/bin/docker" >> /etc/sudoers
#echo "alias docker=\"sudo /usr/bin/docker\"" >> /home/docker_user/.bash_profile

echo "******************************************************************************"
echo "Configure docker-compose." `date`
echo "******************************************************************************"
curl -L https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
# bash command completion
sudo curl \
    -L https://raw.githubusercontent.com/docker/compose/1.29.1/contrib/completion/bash/docker-compose \
    -o /etc/bash_completion.d/docker-compose
echo "docker_user  ALL=(ALL)  NOPASSWD: /usr/local/bin/docker-compose" >> /etc/sudoers
# create symbolic link in /usr/bin
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

echo "******************************************************************************"
echo "Install lazydocker." `date`
echo "******************************************************************************"
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

echo "******************************************************************************"
echo "Copy setup files to the local disks." `date`
echo "******************************************************************************"
cp /vagrant/scripts/docker_user_setup.sh /home/docker_user/
chown docker_user:docker_user /home/docker_user/docker_user_setup.sh
chmod +x /home/docker_user/docker_user_setup.sh
sudo su - docker_user -c '/home/docker_user/docker_user_setup.sh'
