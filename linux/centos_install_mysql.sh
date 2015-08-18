#!/bin/bash

# mysql mysql

DATABASE_PASS = "Passw0rd";

wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm

rpm -ivh mysql-community-release-el7-5.noarch.rpm

yum -y install mysql-server
yum -y install mysql-community-server
systemctl restart mysqld

# Make sure that NOBODY can access the server without a password
mysql -e "UPDATE mysql.user SET Password = PASSWORD('Passw0rd') WHERE User = 'root'"
# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER ''@'$(hostname)'"
# Kill off the demo database
mysql -e "DROP DATABASE test"
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"
# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param

/usr/bin/systemctl restart mysqld
sleep 1;
/usr/bin/systemctl enable mysqld
sleep 1;
/usr/bin/systemctl restart mysqld
