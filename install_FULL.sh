#!/bin/bash

dhclient

mkdir /etc/OpenVAS
path2="/etc/OpenVAS"
cd $(echo $path2 | tr -d '\r')

sed -i 's/deb cdrom/# deb cdrom/g' /etc/apt/sources.list

apt-get update && apt-get dist-upgrade -y && apt-get install git


git clone https://github.com/abstracta-0/deb9_OpenVAS_deploy.git

cd deb9_OpenVAS_deploy

chmod +x *

/bin/bash deb9_OpenVAS_deploy |& tee install.log
