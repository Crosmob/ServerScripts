#!/bin/bash

# apache

yum install httpd -y
sleep 1;
systemctl restart httpd
sleep 1;
service httpd restart
sleep 1;
echo "you need to configure Apache: /etc/httpd/conf.d/welcome.conf";
firewall-cmd --permanent --add-service=http
systemctl restart firewalld

yum install -y php php-mysql php-pdo php-gd php-mbstring

echo "<?php phpinfo(); ?>" > /var/www/html/info.php
systemctl restart httpd
sleep 1;

echo "you need to configure PHP: /etc/php.ini";
