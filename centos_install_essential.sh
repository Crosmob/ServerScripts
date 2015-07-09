#!/bin/bash

# Make sure only root can run our script
if [ “$(id -u)” != “0” ]; then
echo “This script must be run as root” 2>&1
exit 1
fi

yum -y update
yum -y upgrade
yum install gcc -y
gcc --version

# install wget
yum install nano bash-completion net-tools wget curl lsof -y
yum install telnet -y
yum install systemd-analyze -y

# install finger
yum install finger* -y
yum install p7zip -y
yum install ntfs-3g -y
yum install rkhunter -y
yum install selinux-policy -y

## To output numerical service sockets
netstat -tulpn  	
## To output literal service sockets
netstat -tulp      	

systemctl stop postfix
yum remove postfix
systemctl stop chronyd
yum remove chrony
netstat -tulpn
netstat -tulp

netstat -tulpn
systemd-analize > "log-`date '+%Y-%m-%d'`.log"

# remove system bell
rmmod -v pcspkr

