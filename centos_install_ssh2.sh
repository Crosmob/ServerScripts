yum install gcc php-devel php-pear libssh2 libssh2-devel
# rpm -Uvh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
pecl install -f ssh2
echo extension=ssh2.so > /etc/php.d/ssh2.ini
service httpd restart
php -m | grep ssh2
