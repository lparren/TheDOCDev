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
echo "Copy dockerfiles form host." `date`
echo "******************************************************************************"
cd /u01
cp -r /vagrant/dockerfiles /u01

echo "******************************************************************************"
echo "Install VSCode sql-developer and postgres extension" `date`
echo "******************************************************************************"

code --install-extension Oracle.sql-developer
code --install-extension ckolkman.vscode-postgres

echo "******************************************************************************"
echo "Install lazydocker." `date`
echo "******************************************************************************"
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# echo "******************************************************************************"
# echo "Install PyCharm" `date`
# echo "******************************************************************************"
# wget -q https://download.jetbrains.com/python/pycharm-community-2021.1.tar.gz
# tar -xvf pycharm-community-2021.1.tar.gz
# mv pycharm-community-2021.1/ pycharm-ce
# rm pycharm-community-2021.1.tar.gz
# cd ~

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
echo "Create project folder" `date`
echo "******************************************************************************"
mkdir /home/docker_user/project

echo "******************************************************************************"
echo "Create aliasses" `date`
echo "******************************************************************************"
# echo "alias jupyter=\"jupyter notebook &\"" >> /home/docker_user/.bash_profile
echo "alias chrome=\"google-chrome &\"" >> /home/docker_user/.bash_profile
# echo "alias pycharm=\"~/pycharm-ce/bin/pycharm.sh &\"" >> /home/docker_user/.bash_profile
echo "# Oracle aliasses" >> /home/docker_user/.bash_profile
echo "alias oraup=\"docker compose --project-directory /u01/dockerfiles/oracle/  up --detach \"" >> /home/docker_user/.bash_profile
echo "alias orastart=\"docker compose --project-directory /u01/dockerfiles/oracle/ start \"" >> /home/docker_user/.bash_profile
echo "alias orastop=\"docker compose --project-directory /u01/dockerfiles/oracle/ stop \"" >> /home/docker_user/.bash_profile
echo "alias oralog=\"docker compose --project-directory /u01/dockerfiles/oracle/ logs -f \"" >> /home/docker_user/.bash_profile
# 
echo "# Postgres aliasses" >> /home/docker_user/.bash_profile
echo "alias pgup=\"docker compose --project-directory /u01/dockerfiles/postgres/  up --detach \"" >> /home/docker_user/.bash_profile
echo "alias pgstart=\"docker compose --project-directory /u01/dockerfiles/postgres/ start \"" >> /home/docker_user/.bash_profile
echo "alias pgstop=\"docker compose --project-directory /u01/dockerfiles/postgres/ stop \"" >> /home/docker_user/.bash_profile
echo "alias pglog=\"docker compose --project-directory /u01/dockerfiles/postgres/ logs -f \"" >> /home/docker_user/.bash_profile

echo "# Lazydocker aliasses" >> /home/docker_user/.bash_profile
#echo "alias lzd=\"docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v /home/lazydocker:/.config/jesseduffield/lazydocker lazyteam/lazydocker\"" >> /home/docker_user/.bash_profile
echo "alias lzd=\"lazydocker\"" >> /home/docker_user/.bash_profile

echo "#" >> /home/docker_user/.bash_profile
echo "alias mlt=\"docker run --rm -it -v ${PWD}:/project -w /project -e 5000 -p 5000:5000 meltano/meltano:latest \"" >> /home/docker_user/.bash_profile
echo "alias mltui=\"docker run --rm -d -v ${PWD}:/project -w /project -e 5000 -p 5000:5000 meltano/meltano:latest \"" >> /home/docker_user/.bash_profile

echo "*******************************************************"
echo "*** You need to copy all the software in place now! ***"
echo "*** /vagrant/scripts/builds.sh                      ***"
echo "*******************************************************"
