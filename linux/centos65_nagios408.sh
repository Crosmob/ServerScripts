# install nagios 4.0.8 on centos 6.5 @ digitalocean.com

# update VPS
yum -y update
yum -y install gd gd-devel wget httpd php gcc perl

# reboot
reboot

# users and groups
adduser nagios
groupadd nagcmd
usermod -a -G nagcmd nagios
usermod -a -G nagios apache

# working directory
cd /root/

# get archives
wget http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-4.0.8.tar.gz
wget http://nagios-plugins.org/download/nagios-plugins-2.0.3.tar.gz

# install nagios
tar xf nagios-4.0.8.tar.gz
cd nagios-4.0.8/
./configure --with-command-group=nagcmd
make all; make install; 
make install-init; make install-config; 
make install-commandmode; make install-webconf

# configure email and htuser
sed -i 's/nagios@localhost/youremail@yourdomain/g' /usr/local/nagios/etc/objects/contacts.cfg
htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

# install plugins
cd /root/
tar xf nagios-plugins-2.0.3.tar.gz
cd nagios-plugins-2.0.3
./configure --with-nagios-user=nagios --with-nagios-group=nagios
make; make install

# add/enable nagios service
chkconfig --add nagios
chkconfig nagios on

# create initial config
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

# some bug fixes
touch /var/www/html/index.html
chown nagios.nagcmd /usr/local/nagios/var/rw
chmod g+rwx /usr/local/nagios/var/rw
chmod g+s /usr/local/nagios/var/rw

# init bug fix
sed -i '/$NagiosBin -d $NagiosCfgFile/a (sleep 10; chmod 666 \/usr\/local\/nagios\/var\/rw\/nagios\.cmd) &'  /etc/init.d/nagios

# 4G swap space (this is a digitalocean VPS)
dd if=/dev/zero of=/swap bs=1024 count=4000000
mkswap /swap 
swapon /swap
echo /swap swap swap defaults 0 0 >> /etc/fstab
echo vm.swappiness = 0 >> /etc/sysctl.conf 
sysctl -p

# start services
service nagios start
service httpd restart

# remove gcc
yum remove gcc
