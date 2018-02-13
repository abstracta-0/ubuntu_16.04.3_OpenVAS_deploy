#!/bin/bash

dhclient

mkdir /etc/OpenVAS
path2="/etc/OpenVAS"
cd $(echo $path2 | tr -d '\r')

apt-get update && apt-get dist-upgrade -y && apt-get install git


git clone https://github.com/abstracta-0/ubuntu_16.04.3_OpenVAS_deploy.git

cd ubuntu_16.04.3_OpenVAS_deploy

chmod +x *

/bin/bash /etc/OpenVAS/ubuntu_16.04.3_OpenVAS_deploy/ubnt_bhat_mgr.sh |& tee install.log
