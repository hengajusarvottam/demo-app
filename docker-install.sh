#!/bin/bash

# updated packages
echo "
*****************
Updating Packages
*****************
"
sudo apt update

# install docker
echo "
*****************
Installing docker
*****************
"
sudo apt install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io

echo "
**************
Docker Version
**************
"
docker -v

# install docker-compose
echo "
*************************
Installing docker-compose
************************
"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo usermod -aG docker ${USER}

echo "
**********************
Docker-compose Version
**********************
"
docker-compose --version


echo "
*********************************************
Start to install-Vagrant
*********************************************
"
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vagrant

echo "
***************
Vagrant Version
***************
"
vagrant --version

echo "
***************
Download box with ubuntu image
***************
"
vagrant box add bento/ubuntu-22.04 --provider=virtualbox

echo "
***************
Vagrant box list
***************
"
vagrant box list

echo "
***************
Vagrant box list
***************
"
sudo apt install virtualbox -y 

