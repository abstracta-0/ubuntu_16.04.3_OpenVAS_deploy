#!/bin/bash
# Using Debian 9 for a master/slave(remote scanner) setup
# This is the Master (Manager)
# Tested on FRESH install of Debian 9 Stretch
# MAKE SURE TO MAKE THIS SCRIPT EXECUTABLE 
# chmod +x OpenVAS_mstr_setup.sh

echo "are you root? [Y/n]"
 
read answer
 
if [ $answer == Y ]; then
        apt-get update && apt-get dist-upgrade -y
else
        echo "You didn't answer Yes. Goodbye"
        exit
fi

# NEED TO Set the environment variable across reboots
echo export LD_LIBRARY_PATH=/usr/local/lib/ openvassd>>/root/.bashrc
echo LD_LIBRARY_PATH=/usr/local/lib/ openvassd>>/root/.profile
echo LD_LIBRARY_PATH=/usr/local/lib/ openvassd>>/etc/environment
source /root/.bashrc
source /root/.profile
 
 
# backup sources file (this is where debian looks for to get its packages for updates
cp /etc/apt/sources.list /etc/apt/sources.list.bak
 
# remove the CDROM repo from the sources list
sed -i 's/deb cdrom/# deb cdrom/g' /etc/apt/sources.list
 
 
mkdir /etc/OpenVAS
 
path="/etc/OpenVAS"
 
cd $(echo $path | tr -d '\r')
 
# download additional packages and libraries
 
wget -nc http://wald.intevation.org/frs/download.php/2420/openvas-libraries-9.0.1.tar.gz
wget -nc http://wald.intevation.org/frs/download.php/2423/openvas-scanner-5.1.1.tar.gz
wget -nc http://wald.intevation.org/frs/download.php/2448/openvas-manager-7.0.2.tar.gz
wget -nc http://wald.intevation.org/frs/download.php/2397/openvas-cli-1.4.5.tar.gz
wget -nc http://wald.intevation.org/frs/download.php/2429/greenbone-security-assistant-7.0.2.tar.gz
 
apt-get -y install nsis rpm net-tools dpkg-dev pkg-config libssh-dev libglib2.0-dev libpcap-dev uuid-dev bison libksba-dev sqlite3 libpopt-dev heimdal-multidev gcc-mingw-w64 cmake python-setuptools libgpgme11-dev python-paramiko libgnutls28-dev redis-server libsnmp-dev libgcrypt20-dev libldap2-dev libmicrohttpd-dev libxml2-dev libxslt1-dev xsltproc rsync gnutls-bin nmap alien nsis rpm texlive doxygen libhiredis-dev libsqlite3-dev xmltoman
 
 
tar xzf openvas-libraries-9.0.1.tar.gz
cd openvas-libraries-9.0.1/
mkdir build
cd build/
cmake ..
make
make install
cd ../../

tar xzf openvas-scanner-5.1.1.tar.gz
cd openvas-scanner-5.1.1
mkdir build
cd build/
cmake ..
make
make install
cd ../../

tar xzf openvas-manager-7.0.2.tar.gz
cd openvas-manager-7.0.2/
mkdir build
cd build/
cmake ..
make
make install
cd ../../
 
tar xzf openvas-cli-1.4.5.tar.gz
cd openvas-cli-1.4.5/
mkdir build
cd build/
cmake ..
make
make install
cd ../../

tar xzf greenbone-security-assistant-7.0.2.tar.gz 
cd greenbone-security-assistant-7.0.2/
mkdir build
cd build/ 
cmake ..
make
make install
cd ../../
 
/usr/bin/redis-server /etc/OpenVAS/openvas-scanner-5.1.1/doc/example_redis_2_6.conf.in
 
/usr/local/sbin/openvasmd
/usr/local/sbin/greenbone-scapdata-sync
/usr/local/sbin/greenbone-certdata-sync
/usr/local/sbin/greenbone-nvt-sync
/usr/local/bin/openvas-manage-certs -a
/usr/local/sbin/openvassd
/usr/local/sbin/openvasmd --rebuild

/usr/local/sbin/openvasmd --create-user=administrator --role=Admin && openvasmd --user=administrator --new-password=Password01


