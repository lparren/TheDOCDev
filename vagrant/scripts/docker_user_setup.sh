echo "******************************************************************************"
echo "Setup docker_user "
echo "******************************************************************************"

echo "******************************************************************************"
echo "Install oracle client." `date`
echo "******************************************************************************"
sudo dnf install -y oracle-instantclient-release-el8.x86_64
sudo dnf install -y oracle-instantclient-basic.x86_64 
sudo dnf install -y oracle-instantclient-devel.x86_64
sudo dnf install -y oracle-instantclient-jdbc.x86_64
sudo dnf install -y oracle-instantclient-odbc.x86_64
sudo dnf install -y oracle-instantclient-sqlplus.x86_64
sudo dnf install -y oracle-instantclient-tools.x86_64

echo "export CLIENT_HOME=/usr/lib/oracle/21/client64" >> /home/docker_user/.bash_profile
echo "export LD_LIBRARY_PATH=$CLIENT_HOME/lib" >> /home/docker_user/.bash_profile
echo "export PATH=$PATH:$CLIENT_HOME/bin" >> /home/docker_user/.bash_profile

echo "******************************************************************************"
echo "Clone db-sample-schemas." `date`
echo "******************************************************************************"
# Clone the latest Git repository. Use SSH so no password.
cd /u01
cp -r /vagrant/dockerfiles /u01
git clone https://github.com/oracle/db-sample-schemas.git
cd /u01/db-sample-schemas
perl -p -i.bak -e 's#__SUB__CWD__#'$(pwd)'#g' *.sql */*.sql */*.dat
cd ~

echo "******************************************************************************"
echo "Install lazydocker." `date`
echo "******************************************************************************"
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

echo "******************************************************************************"
echo "Install PyCharm" `date`
echo "******************************************************************************"
wget -q https://download.jetbrains.com/python/pycharm-community-2021.1.tar.gz
tar -xvf pycharm-community-2021.1.tar.gz
mv pycharm-community-2021.1/ pycharm-ce
rm pycharm-community-2021.1.tar.gz
cd ~

# echo "******************************************************************************"
# echo "Install Jupyter" `date`
# echo "******************************************************************************"
# conda install -c conda-forge -y notebook
# conda install -c conda-forge -y jupyterlab
# conda install -c conda-forge -y nb_conda_kernels
# conda install -c conda-forge -y jupyter_contrib_nbextensions
# conda install -y pip
# conda update -y conda
# conda init bash

echo "******************************************************************************"
echo "Create aliasses" `date`
echo "******************************************************************************"
echo "alias jupyter=\"jupyter notebook &\"" >> /home/docker_user/.bash_profile
echo "alias chrome=\"google-chrome &\"" >> /home/docker_user/.bash_profile
echo "alias pycharm=\"~/pycharm-ce/bin/pycharm.sh &\"" >> /home/docker_user/.bash_profile
echo "alias dcup=\"docker-compose --project-directory /u01/dockerfiles/  up --detach \"" >> /home/docker_user/.bash_profile
echo "alias dcstart=\"docker-compose --project-directory /u01/dockerfiles/ start \"" >> /home/docker_user/.bash_profile
echo "alias dcstop=\"docker-compose --project-directory /u01/dockerfiles/ stop \"" >> /home/docker_user/.bash_profile
echo "alias dclog=\"docker-compose --project-directory /u01/dockerfiles/ logs -f \"" >> /home/docker_user/.bash_profile
echo "alias dbt=\"docker-compose --project-directory /u01/dockerfiles/ run dbt \"" >> /home/docker_user/.bash_profile
echo "alias lazydocker=\"sudo /home/docker_user/lazydocker\"" >> /home/docker_user/.bash_profile

echo "*******************************************************"
echo "*** You need to copy all the software in place now! ***"
echo "*** /vagrant/scripts/builds.sh                      ***"
echo "*******************************************************"
