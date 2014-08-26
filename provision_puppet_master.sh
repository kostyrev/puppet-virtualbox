#!/bin/bash


sudo yum install --nogpgcheck -y http://fedora-mirror01.rbc.ru/pub/epel/6/i386/epel-release-6-8.noarch.rpm
sudo yum install --nogpgcheck -y https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm

sudo /bin/echo '192.168.230.20 puppetm.local' | sudo tee -a /etc/hosts
sudo /bin/echo '192.168.230.21 puppet-client.local' | sudo tee -a /etc/hosts

sudo yum install -y puppet-server git

sudo touch /etc/puppet/autosign.conf
sudo /bin/echo '*.local' | sudo tee -a /etc/puppet/autosign.conf

sudo install -m0600 --group=vagrant --owner=vagrant /vagrant/ssh/id_rsa /home/vagrant/.ssh/
sudo install -m0644 --group=vagrant --owner=vagrant /vagrant/ssh/id_rsa.pub /home/vagrant/.ssh/
sudo install -m0600 --group=vagrant --owner=vagrant /vagrant/ssh/ssh_config /home/vagrant/.ssh/config
#sudo install -m0600 --group=vagrant --owner=vagrant /vagrant/ssh/known_hosts /home/vagrant/.ssh/known_hosts

#sudo install -m0600 /vagrant/ssh/id_rsa /home/vagrant/.ssh/
#sudo install -m0644 /vagrant/ssh/id_rsa.pub /home/vagrant/.ssh/
#sudo install -m0600 /vagrant/ssh/ssh_config /home/vagrant/.ssh/config
#sudo install -m0644 /vagrant/ssh/known_hosts /home/vagrant/.ssh/known_hosts


sudo groupadd dvp > /dev/null 2>&1
sudo gpasswd -a vagrant dvp  > /dev/null 2>&1

sudo chgrp dvp /etc/puppet/environments  > /dev/null 2>&1
sudo chmod g+w /etc/puppet/environments  > /dev/null 2>&1

#newgrp dvp 

eval `ssh-agent`  > /dev/null 2>&1
ssh-add /home/vagrant/.ssh/id_rsa  > /dev/null 2>&1

sudo install -m644 --group=vagrant --owner=vagrant  /vagrant/puppetmaster/puppet.conf  /etc/puppet/puppet.conf


mkdir ~/.ssh
chmod 700 ~/.ssh

ssh-keyscan -H gitlab.caravan.dmz > ~/.ssh/known_hosts 2>/dev/null && git clone git@gitlab.example.org:puppet/production.git /etc/puppet/environments/production

chgrp -R dvp /etc/puppet/environments/production
chmod -R g+w /etc/puppet/environments/production

ssh-add -D  > /dev/null 2>&1

sudo /etc/init.d/puppetmaster start

sudo puppet agent --server puppetm.local -t 2> /dev/null
#sudo service puppet restart

git config --system alias.st status
git config --system alias.ci 'commit -v'
git config --system alias.br branch
git config --system alias.co checkout

exit 0



