#!/bin/bash

# see hosts
cat /etc/hosts

echo "Type the hostname of your preference - ONLY CENTOS 7, followed by [ENTER]:"
read htname

hostnamectl set-hostname $htname
