#!/bin/bash

# To install the server and client type:
yum -y install openssh-server openssh-clients

# Start the service:
chkconfig sshd on
service sshd start

# Make sure port 22 is opened:
netstat -tulpn | grep :22
# Firewall Settings
# Edit /etc/sysconfig/iptables (IPv4 firewall),
echo "-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT" >> /etc/sysconfig/iptables

#Save and close the file. Restart iptables:
service iptables restart
