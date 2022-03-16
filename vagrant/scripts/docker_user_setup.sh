echo "******************************************************************************"
echo "Setup docker_user "
echo "******************************************************************************"

# Clone the latest Git repository. Use SSH so no password.
cd /u01
cp -r /vagrant/dockerfiles /u01
git clone https://github.com/oracle/db-sample-schemas.git
cd /u01/db-sample-schemas
perl -p -i.bak -e 's#__SUB__CWD__#'$(pwd)'#g' *.sql */*.sql */*.dat
cd ~

echo "******************************************************************************"
echo "Install PyCharm"
echo "******************************************************************************"
wget -q https://download.jetbrains.com/python/pycharm-community-2021.1.tar.gz
tar -xvf pycharm-community-2021.1.tar.gz
mv pycharm-community-2021.1/ pycharm-ce
rm pycharm-community-2021.1.tar.gz
cd ~

echo "alias pycharm=\"~/pycharm-ce/bin/pycharm.sh &\"" >> /home/docker_user/.bash_profile
echo "alias dcup=\"docker-compose --project-directory /u01/dockerfiles/  up --detach \"" >> /home/docker_user/.bash_profile
echo "alias dcstart=\"docker-compose --project-directory /u01/dockerfiles/ start \"" >> /home/docker_user/.bash_profile
echo "alias dcstop=\"docker-compose --project-directory /u01/dockerfiles/ stop \"" >> /home/docker_user/.bash_profile
echo "alias dclog=\"docker-compose --project-directory /u01/dockerfiles/ logs -f \"" >> /home/docker_user/.bash_profile
echo "alias dbt=\"docker-compose --project-directory /u01/dockerfiles/ run dbt \"" >> /home/docker_user/.bash_profile
#echo "alias ?=\"? \"" >> /home/docker_user/.bash_profile

echo "******************************************************************************"
echo "Add lazydocker alias"
echo "******************************************************************************"
echo "alias lazydocker=\"sudo /usr/local/bin/lazydocker\"" >> /home/docker_user/.bash_profile

echo "*******************************************************"
echo "*** You need to copy all the software in place now! ***"
echo "*** /vagrant/scripts/builds.sh                      ***"
echo "*******************************************************"
