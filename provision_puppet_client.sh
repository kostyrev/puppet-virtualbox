#!/bin/bash

sudo yum install --nogpgcheck -y http://fedora-mirror01.rbc.ru/pub/epel/6/i386/epel-release-6-8.noarch.rpm
sudo yum install --nogpgcheck -y https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm

sudo yum install -y puppet git

sudo /bin/echo '192.168.230.20 puppetm.local' | sudo tee -a /etc/hosts
sudo /bin/echo '192.168.230.21 puppet-client.local' | sudo tee -a /etc/hosts


sudo puppet agent --server puppetm.local -t 2> /dev/null




exit 0
